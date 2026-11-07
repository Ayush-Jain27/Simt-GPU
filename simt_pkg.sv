`timescale 1ns/1ps
package simt_pkg;

    typedef enum logic [1:0] {
        ALU_ADD   = 2'b00,
        ALU_SUB   = 2'b01,
        ALU_PASSB = 2'b10
    } alu_op_e;

endpackage
