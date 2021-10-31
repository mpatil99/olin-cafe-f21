module shift_left_logical(in, shamt, out);

parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

input wire [N-1:0] in;            // the input number that will be shifted left. Fill in the remainder with zeros.
input wire [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
output logic [N-1:0] out;       

logic [N-1:0]inter0,inter1,inter2,inter3;

// The general logic is to shift logarithmically based on shamt.
// If nth bit of shamt is high, the signal is shifted by 2**n
// This is than cascaded through muxes handling powers of two all the way up to N
always_comb begin : blockName
    inter0 = shamt[0] ? {in[30:0], 1'b0}: in;
    inter1 = shamt[1] ? {inter0[29:0], 2'b0}: inter0;
    inter2 = shamt[2] ? {inter1[27:0], 4'b0}: inter1;
    inter3 = shamt[3] ? {inter2[23:0], 8'b0}: inter2;
    out = shamt[4] ? {inter3[15:0], 16'b0}: inter3;
    
end

endmodule
