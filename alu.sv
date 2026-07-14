`timescale 1ns/1ps
module alu
(
  input  alu_op_e                  op,
  input  logic signed [31:0]        a,
  input  logic signed [31:0]        b,
  output logic signed [31:0]        y,
  output logic                     ne
);

  always_comb begin
    unique case (op)
      ALU_ADD:   y = a + b;
      ALU_SUB:   y = a - b;
      ALU_PASSB: y = b;
      default:   y = '0;
    endcase
  end

  assign ne = (a != b);

endmodule
