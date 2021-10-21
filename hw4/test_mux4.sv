`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_mux4;
  logic [1:0]ena;
  logic [3:0]in;
  wire out;

  mux4 UUT(ena, in, out);

  initial begin
    // Collect waveforms
    $dumpfile("mux4.vcd");
    $dumpvars(0, UUT);
    
    $display("ena in | out");
    in = 7;
    for (int i = 0; i < 4; i = i + 1) begin
      ena = i[1:0];
      #1 $display("%2b %4b | %1b", ena, in, out);
    end

    in = 14;
    for (int i = 0; i < 4; i = i + 1) begin
      ena = i[1:0];
      #1 $display("%2b %4b | %1b", ena, in, out);
    end
        
    $finish;      
	end

endmodule
