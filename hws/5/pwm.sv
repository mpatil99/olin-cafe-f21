/*
  A pulse width modulation module 
*/

module pwm(clk, rst, ena, step, duty, out);

parameter N = 8;

input wire clk, rst;
input wire ena; // Enables the output.
input wire step; // Enables the internal counter. You should only increment when this signal is high (this is how we slow down the PWM to reasonable speeds).
input wire [N-1:0] duty; // The "duty cycle" input.
output logic out;

logic [N-1:0] counter;
logic counter_overflow;
logic duty_comparator;


// Create combinational (always_comb) and sequential (always_ff @(posedge clk)) 
// logic that drives the out signal.
// out should be off if ena is low.
// out should be fully zero (no pulses) if duty is 0.
// out should have its highest duty cycle if duty is 2^N-1;
// bonus: out should be fully zero at duty = 0, and fully 1 (always on) at duty = 2^N-1;
// You can use behavioural combinational logic, but try to keep your sequential
//   and combinational blocks as separate as possible.

// // SOLUTION START

// always_comb begin
//   out = ena & ( (counter < duty) | &counter );
// end

// always_ff @(posedge clk) begin
//   if(rst) begin
//     counter <=0;
//   end
//   else if (step) begin
//     counter <= counter + 1;
//   end
// end

// // SOLUTION END
always_comb begin
  // Reset counter when it hits max value
  counter_overflow = (counter == (2**N-1));
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
    if (step) begin
      counter <= counter_overflow ? 0: counter + 1;
      out <= duty_comparator;
    end
    else begin
      out <= out;
      counter <= counter;
    end
    end
  else begin 
    out <= 0;
    counter <=0;
  end
end

endmodule
