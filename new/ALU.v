`timescale 1ns / 1ps
`include "const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/18 13:24:14
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU (
    input wire [3:0] ALUop,
    input wire [31:0] ALUopnd1,
    //rs或sa
    input wire [31:0] ALUopnd2,
    //rt或扩展单??
    output wire [31:0] ALURes
);
//for output
reg [31:0] temp;

wire [4:0] sa;
assign sa = ALUopnd1[4:0];

always @(*) begin
    case (ALUop)
        `ALU_OP_ADD   : temp <= ALUopnd1 + ALUopnd2;
        `ALU_OP_AND   : temp <= ALUopnd1 & ALUopnd2;
        `ALU_OP_NOR   : temp <= (~ALUopnd1 & ALUopnd2) | (ALUopnd1 & ~ALUopnd2);
        `ALU_OP_OR    : temp <= ALUopnd1 | ALUopnd2;

        `ALU_OP_MOV   : temp <= ALUopnd1;
        //alu应该返回??么？

        `ALU_OP_SLL   : temp <= ALUopnd2 << sa; //逻辑左移
        `ALU_OP_SRL   : temp <= ALUopnd2 >> sa; //逻辑右移
        `ALU_OP_SRA   : temp <= (ALUopnd2 << (~sa)) | (ALUopnd2 >> sa); //算数右移
        `ALU_OP_SLT   : 
        if (ALUopnd2 > ALUopnd1) begin
            temp <= 5'b11111;
        end else begin
            temp <= 5'b00000;
        end
        `ALU_OP_SLTU  : 
        if (ALUopnd2 == 5'b00000) begin
            temp <= ALUopnd1;
            // 这里alu只是返回gpr[rs]的???？
        end

        `ALU_OP_SUB   : temp <= ALUopnd1 - ALUopnd2;
        `ALU_OP_XOR   : temp <= ALUopnd1 ^ ALUopnd2;
        `ALU_OP_CMP0  :; //无操??
        
        default: ;
    endcase
end

assign ALURes = temp;

endmodule

