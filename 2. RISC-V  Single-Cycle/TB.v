`timescale 1ns/1ns
module TB();
    reg clk = 0;
    reg rst = 1;
    new_top_level UT_RISK (clk, rst);
    always begin
        #5 clk = ~clk;
    end
    initial begin
        #7 rst = ~rst;
        #1500 $stop;
    end

endmodule