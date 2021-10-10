`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_half_adder;

  logic a,b;
  wire s;
  wire cout;

  half_adder UUT(a, b, s, cout);

  initial begin
    // Collect waveforms
    $dumpfile("half_adder.vcd");
    $dumpvars(0, UUT);
    
    $display("a b | s cout");
    for (int i = 0; i < 4; i = i + 1) begin
      a = i[0];
      b = i[1];
      #1 $display("%1b %1b | %1b %1b", a, b, s, cout);
    end
    
    $finish;      
	end
  
endmodule
