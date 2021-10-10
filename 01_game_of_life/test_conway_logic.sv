`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_conway_logic;


  logic [7:0]in;
  logic prev_state;
  wire next_state;

  conway_logic UUT(in, prev_state, next_state);

  initial begin
    // Collect waveforms
    $dumpfile("conway_logic.vcd");
    $dumpvars(0, UUT);
    
    $display("p 7 6 5 4 3 2 1 0 | n");
    for (int i = 0; i < 512; i = i + 1) begin
      in = i[9:0];
      prev_state = i[8];
      #1 $display(
        "%1b %1b %1b %1b %1b %1b %1b %1b %1b | %1b",
         prev_state, in[7], in[6], in[5], in[4], in[3],
          in[2], in[1], in[0], next_state,
          );
    end

    $finish;      
	end
  
endmodule
