`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_full_adder;

  logic [31:0]a;
  logic [31:0]b;
  wire [31:0]s;
  wire cout;

  full_adder32 UUT(a, b, s, cout);

  initial begin
    // Collect waveforms
    $dumpfile("full_adder32.vcd");
    $dumpvars(0, UUT);
    
    $display("    a     b |     s cout");
    for (int i = 0; i < 32; i = i + 1) begin
      a = (1<<i); 
      for (int j = 0; j < 32; j = j + 1) begin
        b = (1<<j);
        #1 $display("%32b %32b| %32b  %1b", a, b, s, cout);
      end
    end

    // Test carry
    a = (1<<32)-1; 
    b = (1<<32)-1;
    #1 $display("%32b %32b| %32b  %1b", a, b, s, cout);

    $finish;      
	end
  
endmodule
