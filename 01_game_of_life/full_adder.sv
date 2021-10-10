module full_adder(a,b,cin, s, cout);
  input logic a,b,cin;
  output logic s, cout;
  logic p,g;

  always_comb begin
    p = a ^ b;
    g = a & b;


    s = p ^cin;
    cout = g | (p & cin);
  end
    
endmodule