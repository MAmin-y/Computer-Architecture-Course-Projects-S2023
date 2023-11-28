`timescale 1ns/1ns

module Stack #(parameter WIDTH = 2,
		parameter DEPTH = 256)
(input clk, rst, pop, push, read, input [WIDTH-1:0]din, output is_empty, is_full, all_read, output reg [WIDTH-1:0] poped, pout );

reg [WIDTH-1:0]stack[DEPTH-1:0];
reg [7:0]head = 8'b0;
reg [7:0]read_ptr = 8'b0;

always @ (posedge clk)
begin
    if(rst)
    begin
        poped  <= 1'bz;
        head <= 0;
    end

    else if(pop)
	begin
	if(!is_empty)
	begin
    		poped  = stack[head - 1'b1];
		stack[head - 1'b1] = 2'bxx;
    		head = head - 1'b1;
	end
	end

	else if(push)
    	begin
        	stack[head] = din;
        	head   = head + 1'b1;
    	end
	else if(read)
	begin
	pout = stack[read_ptr];
	read_ptr = read_ptr + 1;
	end
end

assign is_empty = !(|head);
assign is_full  = (head == 100000000);
assign all_read = (head == read_ptr);

endmodule