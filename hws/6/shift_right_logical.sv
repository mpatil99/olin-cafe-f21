module shift_right_logical(in, shamt, out);

parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

input wire [N-1:0] in;            // the input number that will be shifted left. Fill in the remainder with zeros.
input wire [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
output logic [N-1:0] out;       

logic [N-1:0]inter0,inter1,inter2,inter3;

always_comb begin : blockName
    inter0 = shamt[0] ? {1'b0, in[31:1]}: in;
    inter1 = shamt[1] ? {2'b0, inter0[31:2]}: inter0;
    inter2 = shamt[2] ? {4'b0, inter1[31:4]}: inter1;
    inter3 = shamt[3] ? {8'b0, inter2[31:8]}: inter2;
    out = shamt[4] ? {16'b0, inter3[31:16]}: inter3;
    
end

endmodule
