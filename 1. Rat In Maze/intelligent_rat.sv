module intelligent_rat(input start, rst, clk, run, dout, output fail, done , output [1:0]move, output[3:0] x,y, output wr);


wire ld_x, ld_y, inc_x , inc_y, dec_x, dec_y, pop, push, cnt, rst_count, ld_counter, x_poslim, read, all_read,
			x_neglim , y_poslim, y_neglim, is_empty_st, is_full_st, cout, f_point;

wire [1:0] poped, out_count, reading_out;

datapath mouse_dp(clk ,rst ,wr ,ld_x, ld_y, inc_x , inc_y, dec_x, dec_y, pop, push, cnt, rst_count, ld_counter,read,
		x, y, x_poslim, x_neglim , y_poslim, y_neglim, is_empty_st, is_full_st,
									 cout, f_point, all_read, poped, out_count, reading_out);

controller mouse_controller(start, clk, rst, run, dout, is_empty_st, cout, f_point, all_read,x_poslim, x_neglim , y_poslim, y_neglim, 
				 out_count, poped,
		  		inc_y, inc_x, dec_x, dec_y, push, wr, rst_count, ld_x,
							 ld_y, done, fail, pop, ld_counter, cnt, read);
assign move = reading_out;

endmodule