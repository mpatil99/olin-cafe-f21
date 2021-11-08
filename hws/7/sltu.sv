module sltu(a, b, out);
parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

// Using only *structural* combinational logic, make a module that computes if a is less than b!
// Note: this assumes that the two inputs are signed: aka should be interpreted as two's complement.

// Copy any other modules you use into this folder and update the Makefile accordingly.
logic [N-1:0] not_b, sub_out;
logic c_out, result_different;

adder_n #(.N(32)) SUB(a, not_b, 1'b1, sub_out, c_out);
mux4 #(.N(1)) MUX(result_different, 1'b1, 1'b0, result_different, {a[N-1], b[N-1]}, out);
always_comb not_b = ~b;
always_comb result_different = sub_out[N-1];
endmodule


