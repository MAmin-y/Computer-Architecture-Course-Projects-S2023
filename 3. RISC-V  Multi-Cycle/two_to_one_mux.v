module two_to_one_mux(input [31:0] A, B, input sel, output [31:0] mux_out);

	assign mux_out = (sel) ? B : A;
	// if PcSrc was 1 then B goes on output
	// if PcSrc was 0 then A goes on output
endmodule