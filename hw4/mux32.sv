`default_nettype none

module mux32(ena, in, out);
  input wire [4:0]ena;
  input wire [31:0]in;

  logic [1:0] intermediate;

  output logic out;

  mux16 UPPER16 (ena[3:0], in[31:16], intermediate[1]);
  mux16 LOWER16 (ena[3:0], in[15:0], intermediate[0]);

  always_comb begin
    out = ena[4] ? intermediate[1]: intermediate[0];
  end 


endmodule