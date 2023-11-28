module three_to_one_mux(input [31:0] A, B, C, input [1:0] sel, output reg [31:0] mux_out);


always @(sel,A,B,C) begin
	if (sel == 2'b00) mux_out = A;
	else if (sel == 2'b01) mux_out =  B;
	else if (sel == 2'b10) mux_out = C;
	else mux_out = A;
end
endmodule