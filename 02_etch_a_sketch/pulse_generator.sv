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

// logic tick_rst;
// always_comb tick_rst = rst | counter_comparator;

// always_ff @(posedge clk) begin : counter_logic
//   if(tick_rst) begin
//     counter <= 0;
//   end else if (ena) begin
//     // an equivalent: counter <= counter_comparator ? counter <= 0; counter <= counter + 1;

//     if(counter_comparator) begin
//       counter <= 0;
//     end
//     else begin
//       counter <= counter + 1;
//     end
//   end
// end

// always_comb counter_comparator = counter >= (ticks -1);

// always_comb out = counter_comparator & ena;

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
