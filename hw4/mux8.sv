`default_nettype none

module mux8(ena, in, out);
  input wire [2:0]ena;
  input wire [7:0]in;

  logic [1:0] intermediate;

  output logic out;

  mux4 UPPER4 (ena[1:0], in[7:4], intermediate[1]);
  mux4 LOWER4 (ena[1:0], in[3:0], intermediate[0]);

  always_comb begin
    out = ena[2] ? intermediate[1]: intermediate[0];
  end 

endmodule