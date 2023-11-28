module rat_in_maze(input start, rst, clk, run, output fail, done, dout, output [1:0] move);

wire [3:0] x,y;
wire wr;

intelligent_rat rat(start, rst, clk, run, dout, fail, done, move, x, y, wr);

maze maze_map (x, y, wr, dout);

endmodule