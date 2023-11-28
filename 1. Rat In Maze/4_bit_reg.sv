module reg_4b(input [3:0] d,input ld, clk, rst , output reg [3:0]q, output final_p);

always @(posedge clk, posedge rst) begin
	if (rst)
		q <= 4'b0000;
	else if (ld)
		q <= d;
end

assign final_p = (&(q));
endmodule