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
    
    assign regwe=(instType==1||instType==2||instType==3||instType==8||instType==7)?1:0;//1:��д�룬0������д��
    assign rwdc=(instType==2||instType==8||instType==7)?1:
                (instType==3)?2:0; //1:ѡalu�����Ϊд�Ĵ������ݣ�0��ѡ����������Ϊд�Ĵ������� 2:д��洢������
    assign rwac=(instType==8)?1:0;  //1:ѡ��rd��Ϊд�Ĵ�����ַ��0��ѡ��rt��Ϊд�Ĵ�����ַ
    
    assign op=(instType==2||instType==8||instType==3||instType==4)?1:(instType==7)?2:0; //1: ѡ��ӷ� 2��ѡ�����  0:������
    assign aluopc=(instType==8)?1:0; //1:ѡ��regnum2 ��Ϊalu��������0��ѡ����������Ϊ������
    
    assign memwe=(instType==4)?1:0; //1:��д 0������д
    assign pc_c=(instType==5)?1:(instType==6)?2:0; //1:beq 2��j 0:+4
    
    assign imm_extenc_c=(instType==1)?1:0;
endmodule
