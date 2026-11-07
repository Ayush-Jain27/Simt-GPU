`timescale 1ns/1ps
module mac8 (
    input logic clk,
    input logic clear,
    input logic [7:0] en,
    input logic signed [7:0] a [0:7],
    input logic signed [7:0] b [0:7],
    output wire signed [31:0] acc [0:7]
);

    for (genvar i = 0; i < 8; i++) begin : GEN_MAC
        mac u_mac (
            .clk(clk),
            .clear(clear),
            .en(en[i]),
            .a(a[i]),
            .b(b[i]),
            .acc(acc[i])
        );
    end

endmodule
