module instruction_reg(input [31:0] pc, data_out, input clk, rst, EN, output reg[31:0] OldPc, Inst);

    always @(posedge clk) begin
        if(rst) begin
            Inst <= 32'b0;
            OldPc <= 32'b0;
        end

        else if(EN) begin
            OldPc <= pc;
            Inst <= data_out;
        end

        else  begin
            OldPc <= OldPc;
            Inst <= Inst;
	end 
    end

endmodule
