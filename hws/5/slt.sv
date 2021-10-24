module slt(a, b, c_out, out);
parameter N = 32;
input wire signed [N-1:0] a, b;
output logic c_out;
output logic out;

logic [N-1:0] sum;


// Using only *structural* combinational logic, make a module that computes if a is less than b!
// Note: this assumes that the two inputs are signed: aka should be interpreted as two's complement.

// Copy any other modules you use into this folder and update the Makefile accordingly.
adder_n ADDER_N (a, ~b, 1'b1, sum, c_out); // Subtractor

always_comb begin : subtract
    out = sum[N-1];
end

endmodule