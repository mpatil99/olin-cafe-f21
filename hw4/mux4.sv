`default_nettype none

module mux4(ena, in, out);
  input wire [1:0]ena;
  input wire [3:0]in;

  logic [1:0] intermediate;

  output logic out;

  always_comb begin
    intermediate[1] = ena[0] ? in[3]: in[2];
    intermediate[0] = ena[0] ? in[1]: in[0];
    out = ena[1] ? intermediate[1]: intermediate[0];
  end 

endmodule