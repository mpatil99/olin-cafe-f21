`timescale 1ns/1ps
`default_nettype none
module test_subtractors;

parameter N = 8; // change this to test different adders.

int errors = 0;

logic [N-1:0] a, b;
wire [N-1:0] sum;
wire out;

less_than #(.N(N)) UUT(.a(a), .b(b), .sum(sum), .out(out));

/*
It's impossible to exhaustively test all inputs as N gets larger, there are just
too many possibilities. Instead we can use a combination of testing interesting 
specified edge cases (e.g. adding by zero, seeing what happens on an overflow)
and some random testing! SystemVerilog has a lot of capabilities for this 
that we'll explore in further testbenches.
  1) the tester: sets inputs
  2) checker(s): verifies that the functionality of our HDL is correct
                 using higher level programming constructs that don't translate*
                 to real hardware.
*Okay, many of them do, but we're trying to learn here, right?
*/


// Some behavioural comb. logic that computes correct values.
// logic [N+1:0] sum_and_carry;
logic correct_comparison;
// logic [N-1:0] correct_sum;

always_comb begin : behavioural_solution_logic
  correct_comparison = a < b;
end

// You can make "tasks" in testbenches. Think of them like methods of a class, 
// they have access to the member variables.
task print_io;
  $display("%d < %d = %b (%b)", a, b, sum, out, correct_comparison);
endtask


// 2) the test cases
initial begin
  //$dumpfile("adder_n.vcd");
  //$dumpvars(0, UUT);
  
  $display("Specific interesting tests.");
  
  // Zero + zero 
  a = 0;
  b = 0;
  #1 print_io();

  // Two + Two
  a = 2;
  b = 2;
  #1 print_io();

    // Two + Two
  a = 2;
  b = 1;
  #1 print_io();

  // -1 + -1
  a = -1;
  b = 1;
  #1 print_io();

  // Overflow case with carry in.
  a = (1 << (N-1)) -1;
  b = (1 << (N-1));
  #1 print_io();
  
  $display("Random testing.");
  for (int i = 0; i < 10; i = i + 1) begin : random_testing
    a = $random();
    b = $random();
    #1 print_io();
  end
  if (errors !== 0) begin
    $display("---------------------------------------------------------------");
    $display("-- FAILURE                                                   --");
    $display("---------------------------------------------------------------");
    $display(" %d failures found, try again!", errors);
  end else begin
    $display("---------------------------------------------------------------");
    $display("-- SUCCESS                                                   --");
    $display("---------------------------------------------------------------");
  end
  $finish;
end

// Note: the triple === (corresponding !==) check 4-state (e.g. 0,1,x,z) values.
//       It's best practice to use these for checkers!
always @(a,b) begin
  assert(correct_comparison === out) else begin
    $display("  ERROR: sum should be %d, is %d",correct_comparison , out);
    errors = errors + 1;
  end
  // assert(c_out === correct_carry_out) else begin
  //   $display("  ERROR: sum should be %d", correct_sum);
  //   errors = errors + 1;
  // end
end

endmodule
