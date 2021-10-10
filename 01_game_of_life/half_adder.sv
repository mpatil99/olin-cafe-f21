module half_adder(a, b, s, cout);
  input logic a,b;
  output logic s, cout;

  always_comb begin
    s = a ^ b;
    cout= a & b;
  end    
endmodule