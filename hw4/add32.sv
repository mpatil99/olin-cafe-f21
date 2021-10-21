`default_nettype none

module conway_cell(clk, rst, ena, state_0, state_d, state_q, neighbors);
  input wire clk;
  input wire rst;
  input wire ena;

  input wire state_0;
  output logic state_d;
  output logic state_q;

  input wire [7:0] neighbors;
  logic [3:0] living_neighbors;

  conway_logic LOGIC(neighbors, state_q, state_d);

  always @(posedge clk ) begin
    if (rst)
      state_q <= state_0; 
    else if (ena)
      state_q <= state_d;
    end
    else begin // This is not required
      state_q <= state_q; // hold current value
    end
  end



endmodule