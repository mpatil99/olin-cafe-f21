// Generates "triangle" waves (counts from 0 to 2^N-1, then back down again)
// The triangle should increment/decrement only if the ena signal is high, and hold its value otherwise.
module triangle_generator(clk, rst, ena, out);

parameter N = 8;
input wire clk, rst, ena;
output logic [N-1:0] out;

typedef enum logic {RED, GREEN, BLUE} state_t;
state_t state;

always_comb begin
    if (button_out) begin
        if (state == RED) begin
            state = BLUE;
        end
        else if (state == BLUE) begin
            state = GREEN; 
        end
        else if (state == GREEN) begin
            state = BLUE; 
        end
    end
  
end

always_ff @(posedge clk ) begin
    if (rst) begin
        state <= RED;
        out <= 0;
    end
    else if (ena) begin
        if (state == RED) begin
            out <= 0;
        end
        else if (state == BLUE) begin
            out <= 2;
        end
        else if (state == BLUE) begin
            out <= 4;
        end
    end
    else begin
        out <= out;
    end
end

endmodule