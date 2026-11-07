`timescale 1ns/1ps
module regfile (
    input logic clk,
    input logic we,

    input logic [3:0] waddr,
    input logic [31:0] wdata,

    input logic [3:0] raddr1,
    input logic [3:0] raddr2,
    input logic [3:0] raddr3,

    output logic [31:0] rdata1,
    output logic [31:0] rdata2,
    output logic [31:0] rdata3
);

    // Each execution lane has 16 registers that are 32 bits wide.
    // Register 0 always reads as zero and cannot be written to.

    logic [31:0] registers [0:15];


    // Write to the selected register on the rising clock edge.
    // A write only occurs when we is high.
    // Writes to register 0 are ignored.

    always_ff @(posedge clk) begin
        if (we) begin
            if (waddr != 4'd0) begin
                registers[waddr] <= wdata;
            end
        end
    end


    // First read port
    // This will be used to read the first source operand.

    always_comb begin
        if (raddr1 == 4'd0) begin
            rdata1 = 32'd0;
        end
        else begin
            rdata1 = registers[raddr1];
        end
    end


    // Second read port
    // Reads the second source operand for ALU and MAC operations.

    always_comb begin
        if (raddr2 == 4'd0) begin
            rdata2 = 32'd0;
        end
        else begin
            rdata2 = registers[raddr2];
        end
    end


    // Third read port
    // The MAC instruction needs the old destination value
    // along with the two multiplication operands.

    always_comb begin
        if (raddr3 == 4'd0) begin
            rdata3 = 32'd0;
        end
        else begin
            rdata3 = registers[raddr3];
        end
    end

endmodule
