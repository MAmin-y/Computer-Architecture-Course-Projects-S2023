module controller (
    input clk, Zero, ALU_sine,
    input[2:0] func3,
    input[6:0] op, func7,
    output reg MemWrite, ALUSrc, RegWrite,
    output reg [1:0] PCSrc, ResultSrc,
    output reg [2:0] ALUControl, ImmSrc
);

    always@(op,func3,func7) begin
        case(op)
            7'b0110011: begin
                            PCSrc = 2'b00;
                            ResultSrc = 2'b00;
                            MemWrite = 1'b0;
                            ALUSrc = 1'b0;
                            RegWrite = 1'b1;
                            if(func7 == 7'b0000000 && func3 == 3'b000) ALUControl = 3'b000;
                            else if(func7 == 7'b0100000 && func3 == 3'b000) ALUControl = 3'b001;
                            else if(func7 == 7'b0000000 && func3 == 3'b111) ALUControl = 3'b010;
                            else if(func7 == 7'b0000000 && func3 == 3'b110) ALUControl = 3'b011;
                            else if(func7 == 7'b0000000 && func3 == 3'b010) ALUControl = 3'b100;

                        end

            7'b0000011: begin
                            PCSrc = 2'b00;
                            ResultSrc = 2'b01;
                            MemWrite = 1'b0;
                            ALUControl = 3'b000;
                            ALUSrc = 1'b1;
                            ImmSrc = 3'b000;
                            RegWrite = 1'b1;
                        end

            7'b0010011: begin
                            PCSrc = 2'b00;
                            ResultSrc = 2'b00;
                            MemWrite = 1'b0;
                            ALUSrc = 1'b1;
                            ImmSrc = 3'b000;
                            RegWrite = 1'b1;
                            if(func3 == 3'b000) ALUControl = 3'b000;
                            else if(func3 == 3'b100) ALUControl = 3'b101;
                            else if(func3 == 3'b110) ALUControl = 3'b011;
                            else if(func3 == 3'b010) ALUControl = 3'b100;
                        end

            7'b1100111: begin
                            PCSrc = 2'b10;
                            ResultSrc = 2'b10;
                            MemWrite = 1'b0;
                            ALUControl = 3'b000;
                            ALUSrc = 1'b1;
                            ImmSrc = 3'b000;
                            RegWrite = 1'b1;
                        end

            7'b0100011: begin
                            PCSrc = 2'b00;
                            MemWrite = 1'b1;
                            ALUControl = 3'b000;
                            ALUSrc = 1'b1;
                            ImmSrc = 3'b001;
                            RegWrite = 1'b0;
                        end

            7'b1101111: begin
                            PCSrc = 2'b01;
                            ResultSrc = 2'b10;
                            MemWrite = 1'b0;
                            ImmSrc = 3'b100;
                            RegWrite = 1'b1;
                        end

            7'b1100011: begin
                            MemWrite = 1'b0;
                            ALUControl = 3'b001;
                            ALUSrc = 1'b0;
                            ImmSrc = 3'b010;
                            RegWrite = 1'b0;
                            if (func3 == 3'b000 && Zero)  PCSrc = 2'b01;
                            else if (func3 == 3'b001 && ~Zero)  PCSrc = 2'b01; 
                            else if (func3 == 3'b100 && ALU_sine)  PCSrc = 2'b01; 
                            else if (func3 == 3'b101 && ~ALU_sine)  PCSrc = 2'b01; 
			    else PCSrc = 2'b00;
                        end

            7'b0110111: begin
                            PCSrc = 2'b00;
                            ResultSrc = 2'b11;
                            MemWrite = 1'b0;
                            ImmSrc = 3'b011;
                            RegWrite = 1'b1;
                        end
		default: begin
                            PCSrc = 2'b00;
                        end
        endcase 
    end
endmodule