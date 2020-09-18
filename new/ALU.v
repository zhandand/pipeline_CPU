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
    //rs��sa
    input wire [31:0] ALUopnd2,
    //rt����չ��??
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
        //aluӦ�÷���??ô��

        `ALU_OP_SLL   : temp <= ALUopnd2 << sa; //�߼�����
        `ALU_OP_SRL   : temp <= ALUopnd2 >> sa; //�߼�����
        `ALU_OP_SRA   : temp <= (ALUopnd2 << (~sa)) | (ALUopnd2 >> sa); //��������
        `ALU_OP_SLT   : 
        if (ALUopnd2 > ALUopnd1) begin
            temp <= 5'b11111;
        end else begin
            temp <= 5'b00000;
        end
        `ALU_OP_SLTU  : 
        if (ALUopnd2 == 5'b00000) begin
            temp <= ALUopnd1;
            // ����aluֻ�Ƿ���gpr[rs]��???��
        end

        `ALU_OP_SUB   : temp <= ALUopnd1 - ALUopnd2;
        `ALU_OP_XOR   : temp <= ALUopnd1 ^ ALUopnd2;
        `ALU_OP_CMP0  :; //�޲�??
        
        default: ;
    endcase
end

assign ALURes = temp;

endmodule
