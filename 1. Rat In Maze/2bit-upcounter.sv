module two_bit_counter(input clk, rst, cnt, rst_count, ld, input [1:0] pi, output reg [1:0] po, output cout);

 always@ (posedge clk, posedge rst) begin
	if (ld)
		po <= pi;
	else if(rst || rst_count)
		po <= 2'b00;
	else if(cnt)
		po <= po + 1;
 end

 assign cout = &{cnt, po};

endmodule