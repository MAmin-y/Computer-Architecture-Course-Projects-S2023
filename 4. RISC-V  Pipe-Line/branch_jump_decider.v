module branch_jump_decider (
    input Zero, ALU_sine,
    input [1:0] jumpE,
    input [2:0] branchE,
    output reg [1:0] PCSrcE
);
    always @(Zero,ALU_sine,jumpE,branchE) begin
        if(branchE == 3'b000 && jumpE == 2'b00) PCSrcE = 2'b00;
        else if(branchE == 3'b001 && Zero) PCSrcE = 2'b01;
        else if(branchE == 3'b010 && ~Zero) PCSrcE = 2'b01;
        else if(branchE == 3'b011 && ALU_sine) PCSrcE = 2'b01;
        else if(branchE == 3'b100 && ~ALU_sine) PCSrcE = 2'b01;
        else if(jumpE == 2'b01) PCSrcE = 2'b10;
        else if(jumpE == 2'b10) PCSrcE = 2'b01;
        else PCSrcE = 2'b00;
    end
    
endmodule
