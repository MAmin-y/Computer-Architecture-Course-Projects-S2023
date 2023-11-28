`timescale 1ns/1ns

module TB();

reg clk = 0;
reg start = 0;
reg run = 0;
reg rst = 0;
wire fail, done;
wire [1:0] move;
wire dout;

rat_in_maze uut(start, rst, clk, run, fail, done, dout, move);

always #5 clk = ~clk;

initial begin

#13 rst = ~rst;
#13 rst = ~rst;

#13 start = ~start;
#13 start = ~start;

#40000 run = 1;

#8000 $stop;
end
endmodule