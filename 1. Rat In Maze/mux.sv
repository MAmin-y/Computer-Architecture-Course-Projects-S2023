module two_to_one_mux(input [3:0] x, input [3:0] y, input selx, sely, output [3:0] w);
	assign w = (selx) ? x:
		   (sely) ? y:
		    4'bxxxx;
endmodule