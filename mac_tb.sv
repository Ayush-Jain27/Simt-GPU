`timescale 1ns/1ps

module mac_tb;
    logic               clk = 0;
    logic               clear;
    logic signed [7:0]  a, b;
    logic signed [31:0] acc;

    mac dut (.clk(clk), .clear(clear), .a(a), .b(b), .acc(acc));

    always #5 clk = ~clk;           // 10 ns clock

    initial begin
        clear = 1; a = 0; b = 0;
        @(posedge clk);             // clear acc to 0

        clear = 0; a = 3; b = 4;    // 3*4 = 12
        @(posedge clk); #1;
        if (acc === 32'sd12) $display("PASS: acc=%0d (want 12)", acc);
        else                 $error("FAIL: acc=%0d (want 12)", acc);

        a = 5; b = 6;               // +5*6 -> 42
        @(posedge clk); #1;
        if (acc === 32'sd42) $display("PASS: acc=%0d (want 42)", acc);
        else                 $error("FAIL: acc=%0d (want 42)", acc);

        a = -2; b = 3;              // +(-6) -> 36
        @(posedge clk); #1;
        if (acc === 32'sd36) $display("PASS: acc=%0d (want 36)", acc);
        else                 $error("FAIL: acc=%0d (want 36)", acc);

        $display("Done.");
        $finish;
    end
endmodule