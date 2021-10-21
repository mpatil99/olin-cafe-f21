`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_4a;
  logic clk;
  logic rst;
  logic in;
  wire out;

  four_a UUT(clk, rst, clk, out);

  always #4 clk = ~clk;
  initial begin
    // Collect waveforms
    $dumpfile("4a.vcd");
    $dumpvars(0, UUT);
    clk = 0;
    rst = 1;
    in = 0;
    repeat(3) @(posedge clk);
    rst =0;

    $display("in | out");
    for (int i = 0; i < 1024; i = i + 1) begin
      
      repeat(4) @(posedge clk);
      
    end
        
    $finish;      
	end

endmodule
