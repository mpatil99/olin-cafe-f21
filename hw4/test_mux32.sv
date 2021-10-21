`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_mux32;
  logic [4:0]ena;
  logic [31:0]in;
  wire out;

  mux32 UUT(ena, in, out);

  initial begin
    // Collect waveforms
    $dumpfile("mux32.vcd");
    $dumpvars(0, UUT);
    
    for (int j = 0; j < 32; j = j + 1) begin
      in = 1 << j;
      $display("ena | out | in = %4b", in );
      for (int i = 0; i < 32; i = i + 1) begin
        ena = i[4:0];
        #1 $display("%2b | %1b", ena, out);
      end

    end
    $finish;      
	end

endmodule
