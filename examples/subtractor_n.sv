module less_than(a, b, sum, out); 

parameter N = 8; //32

input  wire [N-1:0] a, b;
output logic [N-1:0] sum;
logic c_out;
output logic out;

adder_n ADDER_N (a, ~b, 1'b1, sum, c_out); // Subtractor


always_comb begin : subtract
    out = ~c_out;
end

endmodule
// to instantiate
// adder_n #(.N(32)) adder_32bit_a ( port list );
