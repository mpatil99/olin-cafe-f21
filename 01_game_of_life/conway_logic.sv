`default_nettype none

module conway_logic(in, prev_state, next_state);
  input wire [7:0]in;
  input wire prev_state;
  output logic next_state;

  logic [9:0]s;
  logic [9:0]c;
  logic [1:0]intermediate;
  logic [9:0]cases;

    half_adder ADD0(in[0], in[1], s[0], c[0]);    
    half_adder ADD1(in[2], in[3], s[1], c[1]);    
    half_adder ADD2(in[4], in[5], s[2], c[2]);    
    half_adder ADD3(in[6], in[7], s[3], c[3]);
       
    half_adder ADD4(s[0], s[1], s[4],  c[4]);    
    half_adder ADD5(c[0], c[1], s[5],  c[5]);  
    half_adder ADD6(s[2], s[3], s[6],  c[6]);    
    half_adder ADD7(c[2], c[3], s[7],  c[7]);   

    half_adder ADD8(s[4], s[6], s[8],  c[8]);    
    half_adder ADD9(intermediate[0], intermediate[1], s[9],  c[9]); 

  always_comb begin 
    intermediate[0] = c[4] | s[5];
    intermediate[1] = c[6] | s[7];
    cases[0] = ~(c[5] | c[7] | c[9]);
    cases[1] = ~(s[8] & ~s[9]);
    cases[2] = ~(c[8] & s[9]);
    cases[3] = c[8] & ~s[9] & prev_state;
    cases[4] = ~s[8]  & ~c[8] & s[9] & prev_state;
    cases[5] = s[8] & s[9];

    next_state = cases[0] & cases[1] & cases[2] & (cases[3] | cases[4] | cases[5]);
  end
endmodule
