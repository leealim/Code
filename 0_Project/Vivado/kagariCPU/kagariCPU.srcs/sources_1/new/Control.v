`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/28 14:14:18
// Design Name: 
// Module Name: Control
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


module Control(
        input         clk,
        input         rstn,
        
        input [5:0] opcode,
        input [5:0] func,
        
        output regwe,[1:0]rwdc,[1:0]op,rwac,aluopc,memwe,[1:0] pc_c,imm_extenc_c
    );
    
    wire [3:0] instType;
    
    assign instType = 
                    (opcode==6'b001111)? 1:         //lui
                    (opcode==6'b001001)? 2:         //addiu
                    (opcode==6'b100011)? 3:         //lw
                    (opcode==6'b101011)? 4:         //sw
                    (opcode==6'b000100)? 5:         //beq
                    (opcode==6'b000010)? 6:         //j
                    (opcode==6'b001110)? 7:         //xori
                    (opcode==6'b000000)? (
                        (func== 6'b100000)? 8:0     //add
                    ):10;
    
    assign regwe=(instType==1||instType==2||instType==3||instType==8||instType==7)?1:0;//1:能写入，0：不能写入
    assign rwdc=(instType==2||instType==8||instType==7)?1:
                (instType==3)?2:0; //1:选alu输出作为写寄存器数据，0：选择立即数作为写寄存器数据 2:写入存储器数据
    assign rwac=(instType==8)?1:0;  //1:选择rd作为写寄存器地址，0：选择rt作为写寄存器地址
    
    assign op=(instType==2||instType==8||instType==3||instType==4)?1:(instType==7)?2:0; //1: 选择加法 2：选择异或  0:不操作
    assign aluopc=(instType==8)?1:0; //1:选择regnum2 作为alu操作数，0：选择立即数作为操作数
    
    assign memwe=(instType==4)?1:0; //1:能写 0：不能写
    assign pc_c=(instType==5)?1:(instType==6)?2:0; //1:beq 2：j 0:+4
    
    assign imm_extenc_c=(instType==1)?1:0;
endmodule
