`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32; // Don't need to support other numbers, just using this as a constant.

input wire [N-1:0] a, b; // Inputs to the ALU.
input alu_control_t control; // Sets the current operation.
output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // is high if a == b.

// Use *only* structural logic and previously defined modules to implement an 
// ALU that can do all of operations defined in alu_types.sv's alu_op_code_t!
logic [N-1:0] xor_out, sll_out, srl_out, sra_out, add_out, sub_out;
logic add_c_out, sub_c_out, slt_out, sltu_out, sltu_out2;

shift_left_logical SLL(a, b[4:0], sll_out);
shift_right_logical SRL(a, b[4:0], srl_out);
shift_right_arithmetic SRA(a, b[4:0], sra_out);
adder_n #(.N(32)) ADD (a, b, 1'b0, add_out, add_c_out);
adder_n #(.N(32)) SUB (a, ~b, 1'b1, sub_out, sub_c_out);
slt #(.N(32)) SLT (a,b, slt_out);
sltu #(.N(32)) SLTU (a,b, sltu_out);

always_comb begin : control_mode
    xor_out = a ^ b;
    equal = &(~xor_out);
    if (control != ALU_ADD && control != ALU_SUB) begin
        overflow = 0;
    end

    case (control)
        ALU_AND  : result = a & b;
        ALU_OR   : result = a | b;
        ALU_XOR  : result = xor_out;
        ALU_SLL  : result = sll_out;
        ALU_SRL  : result = srl_out;
        ALU_SRA  : result = sra_out;
        ALU_ADD  : result = add_out;
        ALU_SUB  : result = sub_out;
        ALU_SLT  : result = slt_out;
        ALU_SLTU : result = sltu_out;
        default  : result = 0;
    endcase
    case (control)
        ALU_SUB, ALU_SLT, ALU_SLTU: begin
            overflow = ((a[N-1] ^ sub_out[N-1]) & (a[N-1] ^ b[N-1]));
        end
        ALU_ADD: overflow = ((a[N-1] ^ add_out[N-1]) & ~(a[N-1] ^ b[N-1]));
        default: overflow = 0;
    endcase
    zero = &(~(result ^ 32'b0));
end

endmodule