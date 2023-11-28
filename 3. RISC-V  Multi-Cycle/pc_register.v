module pc_register(input [31:0] pc_next, input clk, EN, rst, output reg[31:0] pc);

    always @(posedge clk) begin
        if(rst)
            pc <= 32'b0;
        else if(EN)
            pc <= pc_next;
        else 
            pc <= pc;
    end

endmodule