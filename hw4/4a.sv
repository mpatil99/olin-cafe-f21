`default_nettype none

module four_a(clk, rst, in, out);
  input logic clk;
  input logic rst;

  input logic in;
  output logic out;

  logic [1:0]pos_count;
  logic [1:0]neg_count;

always @(posedge in) begin
  if (rst)
    pos_count <=0;
  else if (pos_count ==2) pos_count <= 0;
  else pos_count<= pos_count +1;
end

always @(negedge in) begin
  if (rst)
    neg_count <=0;
  else if (neg_count ==2) neg_count <= 0;
  else neg_count<= neg_count +1;
end

always_comb begin
  out = ((pos_count == 2) | (neg_count == 2));
end 
endmodule