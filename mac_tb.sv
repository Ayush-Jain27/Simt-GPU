`timescale 1ns/1ps

module mac_tb;
    logic               clk = 0;
    logic               clear;
    logic               en;
    logic signed [7:0]  a, b;
    logic signed [31:0] acc;

    mac dut (.clk(clk), .clear(clear), .en(en), .a(a), .b(b), .acc(acc));

    always #5 clk = ~clk;           // 10 ns clock

    initial begin
        clear = 1; en = 0; a = 0; b = 0;
        @(negedge clk);             // clear acc to 0

        clear = 0; en = 1; a = 3; b = 4;    // 3*4 = 12
        @(posedge clk); #1;
        if (acc === 32'sd12) $display("PASS: acc=%0d (want 12)", acc);
        else                 $error("FAIL: acc=%0d (want 12)", acc);

        @(negedge clk);
        a = 5; b = 6;               // +5*6 -> 42
        @(posedge clk); #1;
        if (acc === 32'sd42) $display("PASS: acc=%0d (want 42)", acc);
        else                 $error("FAIL: acc=%0d (want 42)", acc);

        @(negedge clk);
        a = -2; b = 3;              // +(-6) -> 36
        @(posedge clk); #1;
        if (acc === 32'sd36) $display("PASS: acc=%0d (want 36)", acc);
        else                 $error("FAIL: acc=%0d (want 36)", acc);

        @(negedge clk);
        en = 0; a = 10; b = 10;     // en=0, accumulator stays 36
        @(posedge clk); #1;
        if (acc === 32'sd36) $display("PASS: acc=%0d (want 36)", acc);
        else                 $error("FAIL: acc=%0d (want 36)", acc);

        @(negedge clk);
        clear = 1; en = 1;          // clear has priority over enable
        @(posedge clk); #1;
        if (acc === 32'sd0) $display("PASS: acc=%0d (want 0)", acc);
        else                $error("FAIL: acc=%0d (want 0)", acc);

        @(negedge clk);
        clear = 0; en = 1;
        a = -128; b = 127;          // -128*127 = -16256
        @(posedge clk); #1;
        if (acc === -32'sd16256) $display("PASS: acc=%0d (want -16256)", acc);
        else                     $error("FAIL: acc=%0d (want -16256)", acc);

        @(negedge clk);
        a = -128; b = -128;         // +16384 -> 128
        @(posedge clk); #1;
        if (acc === 32'sd128) $display("PASS: acc=%0d (want 128)", acc);
        else                  $error("FAIL: acc=%0d (want 128)", acc);

        $display("Done.");
        $finish;
    end
endmodule
