`default_nettype none

module mux16(ena, in, out);
  input wire [3:0]ena;
  input wire [15:0]in;

  logic [1:0] intermediate;

  output logic out;

  mux8 UPPER8 (ena[2:0], in[15:8], intermediate[1]);
  mux8 LOWER8 (ena[2:0], in[7:0], intermediate[0]);

  always_comb begin
    out = ena[3] ? intermediate[1]: intermediate[0];
  end 

endmodule