module maze #(parameter FILE_NAME = "input.dat", WIDTH = 16 , LENGTH = 16) 
		(input [3:0] x,y, input wr, output dout);

reg [0:WIDTH - 1]map[0: LENGTH - 1];

initial $readmemh(FILE_NAME , map);

always @(posedge wr) begin
	if(wr) begin
		map[y][x] = ~map[y][x];
	end
end

assign dout = map[y][x];
endmodule