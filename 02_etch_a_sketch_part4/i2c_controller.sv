`timescale 1ns / 1ps
`default_nettype none

`include "i2c_types.sv"

// TI has a good reference on how i2c works: https://training.ti.com/sites/default/files/docs/slides-i2c-protocol.pdf
// In this guide the "main" device is called the "controller" and the "secondary" device is called the "target".
module i2c_controller(
  clk, rst,
  scl, sda, mode,
  i_ready, i_valid, i_addr, i_data,
  o_ready, o_valid, o_data
);

parameter CLK_HZ = 12_000_000;
parameter CLK_PERIOD_NS = (1_000_000_000/CLK_HZ);
parameter I2C_CLK_HZ = 400_000; // Must be <= 400kHz
parameter DIVIDER_COUNT = CLK_HZ/I2C_CLK_HZ/2;  // Divide by two necessary since we toggle the signal
`ifdef SIMULATION
parameter COOLDOWN_CYCLES = 12; // Wait between transactions (can help smooth over issues with ACK or STOP or START conditions).
`else
parameter COOLDOWN_CYCLES = 120; // Wait between transactions (can help smooth over issues with ACK or STOP or START conditions).
`endif // SIMULATION

//Module I/O and parameters
input wire clk, rst; // standard signals
output logic scl; // i2c signals
inout wire sda;

// Create a tristate for the sda input/output pin.
// Tristates let you go into "high impedance" mode which allows the secondary device to use the same wire to send data back!
// It's your job to drive sda_oe (output enable) low (combinationally) when it's the secondary's turn to talk.
logic sda_oe; // output enable for the sda tristate
logic sda_out; // input to the tristate
assign sda = sda_oe ? sda_out : 1'bz; // Needs to be an assign for icarus verilog.

input wire i2c_transaction_t mode; // See i2c_types.sv, 0 is WRITE and 1 is READ
output logic i_ready; // ready/valid handshake signals
input wire i_valid;
input wire [6:0] i_addr; // the address of the secondary device.
input wire [7:0] i_data; // data to be sent on a WRITE opearation
input wire o_ready; // unused (for now)
output logic o_valid; // high when data is valid. Should stay high until a new i_valid starts a new transaction.
output logic [7:0] o_data; // the result of a read transaction (can be x's on a write).

// Main FSM logic
i2c_state_t state; // see i2c_types for the canonical states.

logic [$clog2(DIVIDER_COUNT):0] clk_divider_counter;
logic [$clog2(COOLDOWN_CYCLES):0] cooldown_counter; // optional, but recommended - have the system wait a few clk cycles before i_ready goes high again - this can make debugging STOP/ACK/START issues way easier!!!
logic [3:0] bit_counter;
logic [7:0] addr_buffer;
logic [7:0] data_buffer;

always_ff @(posedge clk) begin : i2c_fsm  
  if(rst) begin
    // #Reset all values to initialization values
    clk_divider_counter <= DIVIDER_COUNT-1;
    scl <= 1;
    bit_counter <= 0;
    o_data <= 0;
    o_valid <= 0;
    i_ready <= 1;
    // #Set initial state in FSM
    state <= S_IDLE;
  end else begin // out of reset
// SOlUTION START
    if(state == S_IDLE) begin
      // #Check that both cooldown clock has expired 
      // #Check that input to system is ready is as well
      if(i_valid & i_ready) begin 
        // #Reset cooldown clock
        i_ready <= 0;
        cooldown_counter <= COOLDOWN_CYCLES;
        o_valid <= 0; // #Turn off output
        state <= S_START; // #Move to start state
        addr_buffer <= {i_addr, mode}; // #Concatenate address and R/W bit
        data_buffer <= i_data; // #Make a copy of data
        bit_counter <= 7;
        clk_divider_counter <= DIVIDER_COUNT-1;
      end
      else begin
        scl <= 1;

        // #Cooldown counter adds further slowdown while keeping the FSM in the IDLE state
        if(cooldown_counter > 0) begin
          i_ready <= 0;
          cooldown_counter <= cooldown_counter - 1;
        end else begin
          i_ready <= 1;
        end
      end
    end else begin // handle all non-idle state here
    if (clk_divider_counter == 0) begin // #Scale down system clock by DIVIDER COUNT
      clk_divider_counter <= DIVIDER_COUNT-1; // #Reset clock scalar
      scl <= ~scl; // #Flip i2c clock
      case(state)
        S_START: begin
          state <= S_ADDR;
        end
        S_ADDR: begin
          if(scl) begin // negative edge logic
            // #Decrement bit counter
            if(bit_counter > 0) bit_counter <= bit_counter - 1;
          // end else begin // positive edge logic
            // #Switch state when counter expires
            if(bit_counter == 0) state <= S_ACK_ADDR;
          end
        end
        S_ACK_ADDR: begin
          // $display("[i2c controller] waiting for ack on address 0x%h, addr[0] = %b", addr_buffer[7:1], addr_buffer[0]);
          //if(~sda) begin // # Could wait for acknowledge from secondary, however ignored for now.
            bit_counter <= 7;
            case(addr_buffer[0]) // # switch to R/W state based on state
              WRITE_8BIT_REGISTER : begin
                if(scl) state <= S_WR_DATA;
              end
              READ_8BIT : begin
                if(~scl) state <= S_RD_DATA;
              end
            endcase
          //end
          /*
          else begin
            if(~scl) begin
              state <= S_STOP; // Go to STOP if there is no acknowledge. Technically you could go to START again (look up repeated START) if you are worried about efficiency.
            end
          end
          */
        end

        S_RD_DATA : begin
          if(~scl) begin
            // #Read newest bit from SDA assumbing MSB
            data_buffer[0] <= sda;
            // #Shift received bits up by one
            data_buffer[7:1] <= data_buffer[6:0];
            // #Decrement Counter
            if(bit_counter > 0) begin
              bit_counter <= bit_counter - 1;
            end
            else begin
              state <= S_ACK_RD;
            end
          end
        end
        S_ACK_RD : begin
          if(~scl) begin // positive edge
            state <= S_STOP;
            // #Set data as output and let the higher level module know that we're ready
            o_data <= data_buffer;
            o_valid <= 1;
          end
        end
        S_WR_DATA: begin
          if(scl) begin // negative edge logic
            bit_counter <= bit_counter - 1;
            if(bit_counter > 0) begin  
              // data_buffer[0] <= 1'b1; // Shift in ones to leave SDA as default high. More for the prettiness of the waveform, it shouldn't matter.
              // #Shift data up by one. See combinational below for transmission. 
              data_buffer[7:1] <= data_buffer[6:0];
            end
          end
          else if(&bit_counter) begin
              state <= S_ACK_WR;
          end
        end
        S_ACK_WR: begin
          if(scl) begin // negative edge logic? //TODO(avinash)
            state <= S_STOP;
            if(~sda) begin
            end
          end
        end

        S_STOP: begin
          state <= S_IDLE;
        end
        S_ERROR: begin
`ifndef SIMULATION // In simulation stop, in synthesis, keep running!
          state <= S_IDLE;
`endif
        end
      endcase
      end else begin // still waiting on clock divider counter
        clk_divider_counter <= clk_divider_counter - 1;
      end
    end
  end
// SOLUTION END
end

// SOLUTION START
always_comb case(state)
  S_START, S_ADDR, S_WR_DATA, S_ACK_RD: sda_oe = 1;
  default : sda_oe = 0;
endcase

// #Set sda_out based on state
always_comb case(state)
  // #SDA goes low when starting
  S_START: sda_out = 0; // Start signal.
  // #Set SDA to the bit_counter^th bit of the address+R/W buffer
  S_ADDR: sda_out = addr_buffer[bit_counter[2:0]];
  // #Write Data based on bit_counter
  S_WR_DATA : sda_out = data_buffer[7]; //data_buffer[bit_counter];
  // #Pull low to ack read.
  S_ACK_RD : sda_out = 0;
  default : sda_out = 0; //TODO
endcase
// SOLUTION END

endmodule
