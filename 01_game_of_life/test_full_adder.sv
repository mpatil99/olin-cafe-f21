`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_full_adder;

  logic a,b,cin;
  wire s;
  wire cout;

  full_adder UUT(a, b, cin, s, cout);

  initial begin
    // Collect waveforms
    $dumpfile("full_adder.vcd");
    $dumpvars(0, UUT);
    
    $display("a b cin | s cout");
    for (int i = 0; i < 8; i = i + 1) begin
      a = i[0];
      b = i[1];
      cin = i[2];
      #1 $display("%1b %1b  %1b  | %1b  %1b", a, b, cin, s, cout);
    end

    $finish;      
	end
  
endmodule
