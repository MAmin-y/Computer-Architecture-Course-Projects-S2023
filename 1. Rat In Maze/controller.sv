`define S0 5'b00000
`define S1 5'b00001
`define S2 5'b00010
`define S3 5'b00011
`define S4 5'b00100
`define S5 5'b00101
`define S6 5'b00110
`define S7 5'b00111
`define S8 5'b01000
`define S9 5'b01001
`define S10 5'b01010
`define S11 5'b01011
`define S12 5'b01100
`define counter 5'b01101
`define S14 5'b01110
`define S15 5'b01111
`define S16 5'b10000

module controller(input start, clk, rst, run, dout, is_empty_st, co, f_point, all_read, x_poslim, x_neglim , y_poslim, y_neglim,  
			input [1:0] po, poped,
		  output reg inc_y, inc_x, dec_x, dec_y, push, wr, rst_count, ld_x,
							ld_y, done, fail, pop, ld_counter, cnt,read);

reg [4:0] ps, ns;

always @(posedge clk) begin
	if (rst)
		ps <= 5'b00000;
	else
		ps <= ns;
end

always @(ps, start, poped, run, dout, po, f_point, all_read, is_empty_st, x_poslim, x_neglim, y_poslim, y_neglim)
begin
	case (ps)
		`S0: ns = start ? `S16 : `S0;
		`S16: ns = start ? `S16 : `S1;
		`S1: ns = `S2;
		`S2: begin
 			ns = (x_poslim || x_neglim || y_neglim) ? `counter:
				(y_poslim) ? `S8:
				(dout == 1'b1 && po == 2'b11) ? `S8 :
			   	(dout == 1'b1 && po != 2'b11) ? `counter:
				(dout == 0) ? `S14:
				`S9;
			end
		`S14: ns = `S3;
		`S3: ns = `S4;
		`S4: ns = `S5;
		`S5: ns = f_point ? `S6 : `S1;
		`S6: ns = run ? `S7 : `S6;
		`S7: ns = all_read ? `S0 : `S7;
		`S8: ns = is_empty_st ? `S9 : `S10;
		`S9: ns = `S0;
		`S10: ns = `S11;
		`S11: ns = `S15;
		`S15: ns = `S12 ;
		`S12: ns = (poped == 2'b11) ? `S8 : `counter;
		`counter: ns = `S1;
	endcase
end

always @(ps)
	begin
		{inc_y, inc_x, dec_x, dec_y, push, wr, rst_count, ld_x, ld_y, done,
							 fail, pop,ld_counter,cnt, read} = 15'b0000_0000_0000_000;
		case (ps)
			`S0: ;
			`S16: ;
			`S1: ;
			`S2: begin
				if(po == 2'b00)
					dec_y = 1'b1;
				else if (po == 2'b01)
					inc_x = 1'b1;
				else if (po == 2'b10)
					dec_x = 1'b1;
				else if (po == 2'b11)
					inc_y = 1'b1;
				end
			`S14: ;
			`S3: {push, wr} = 2'b11;
			`S4: begin
				if(po == 2'b00)
					dec_y = 1'b1;
				else if (po == 2'b01)
					inc_x = 1'b1;
				else if (po == 2'b10)
					dec_x = 1'b1;
				else if (po == 2'b11)
					inc_y = 1'b1;
				{ld_x,ld_y} = 2'b11;
				end

			`S5:{rst_count} = 1'b1;
			`S6: done = 1'b1;
			`S7: read = 1'b1;
			`S8: ;
			`S9: fail = 1'b1;
			`S10: pop = 1'b1;
			`S11: begin
				if(poped == 2'b00)
					inc_y = 1'b1;
				else if (poped == 2'b01)
					dec_x = 1'b1;
				else if (poped == 2'b10)
					inc_x = 1'b1;
				else if (poped == 2'b11)
					dec_y = 1'b1;
				{ld_x,ld_y} = 2'b11;
				end
			`S15: ;
			`S12: {wr,ld_counter} = 2'b11;
			`counter: {cnt} = 1'b1;
		endcase
	end
endmodule


