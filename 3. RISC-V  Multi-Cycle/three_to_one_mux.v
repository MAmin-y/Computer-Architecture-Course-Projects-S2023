module three_to_one_mux(input [31:0] A, B, C, input [1:0] sel, output [31:0] mux_out);

	assign mux_out = (sel == 2'b00) ? A :
			 (sel == 2'b01) ? B :
			 (sel == 2'b10) ? C :
			 32'bx;
endmodule