/*
  A pulse width modulation module 
*/

module debouncer(clk, rst, ena, step, duty, out);

parameter N = 8;

input wire clk, rst;
input wire bouncy_input; // Enables the output.
input wire [N-1:0] bounce_time; // The "duty cycle" input.
output logic debounced_out;

logic [N-1:0] counter;
logic counter_overflow;

always_comb begin
  // Reset counter when it hits max value
  counter_overflow = (counter >= (2**N-1));
  start_counter = 
  // Set signal low when counter exceeds duty percent ticks
  // Mux is needed to handle case to make Max duty case always on
  duty_comparator = (duty == (2**N-1)) ? 1 : counter < duty;
end

always_ff @(posedge clk ) begin
    if (rst) begin
        out <= 0;
        counter <=0;
    end
    else if (ena) begin 
        counter <= counter_overflow ? 0: counter + 1;
        out <= duty_comparator;
    end
    else begin
        out <= out;
        counter <= counter;
    end
end

endmodule
