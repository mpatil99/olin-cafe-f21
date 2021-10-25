/*
  Outputs a pulse generator with a period of "ticks".
  out should go high for one cycle ever "ticks" clocks.
*/
module pulse_generator(clk, rst, ena, ticks, out);

parameter N = 8;
input wire clk, rst, ena;
input wire [N-1:0] ticks;
output logic out;

logic [N-1:0] counter;
logic counter_comparator;

always_comb begin
  counter_comparator = counter > ticks-1;
end

always_ff @(posedge clk ) begin
  if (rst) begin
    counter <= 0;
    out <= 0;
  end
  else if (ena) begin
    counter <= counter_comparator ? 0: counter + 1;
    out <= counter_comparator;
  end
  else begin // This is not required
    counter <= counter; // hold current value
    out <= out;
  end
end

endmodule
