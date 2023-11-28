`timescale 1ns/1ns
module TB();
    reg clk = 0;
    reg rst = 1;
    top_level UT_RISK (clk, rst);
    always begin
        #10 clk = ~clk;
    end
    initial begin
        #15 rst = ~rst;
        #5000 $stop;
    end

endmodule
