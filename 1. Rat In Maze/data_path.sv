module datapath(input clk ,rst ,wr ,ld_x, ld_y, inc_x , inc_y, dec_x, dec_y, pop, push, cnt, rst_count, ld_counter, read,
		output [3:0] x,y, output x_poslim, x_neglim , y_poslim, y_neglim, is_empty_st, is_full_st, cout, f_point, all_read, output [1:0] poped, out_count, reading_out);

wire [3:0] x_op, y_op;
wire final_x, final_y;

reg_4b x_reg (x, ld_x, clk, rst, x_op, final_x);
reg_4b y_reg (y, ld_y, clk, rst, y_op, final_y);

inc_and_dec x_inc_dec (x_op, inc_x, dec_x, x, x_poslim, x_neglim);
inc_and_dec y_inc_dec (y_op, inc_y, dec_y, y, y_poslim, y_neglim);

Stack direct_stack (clk, rst, pop, push, read, out_count,  is_empty_st, is_full_st, all_read, poped, reading_out);

two_bit_counter counter (clk, rst, cnt, rst_count, ld_counter, poped, out_count, cout);

assign f_point = (final_x & final_y);

endmodule
