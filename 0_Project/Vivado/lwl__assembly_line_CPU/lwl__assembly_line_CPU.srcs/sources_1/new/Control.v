`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
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
    input I_clk  ,
    input I_rstn  ,
    input [5:0]I_opcode  ,
    input [5:0]I_func  ,
    
    output O_ALUsrcA  ,
    output O_ALUsrcB  ,
    output [7:0]O_ALUop  ,
    output O_DataMemWe  ,
    output O_RegsWe  ,
    output O_RegWriteData ,
    output O_RegWriteAddr ,
    output O_jump  ,
    output O_borj ,
    output [1:0] O_ifsltsub 
    );
    
    parameter sw=8'd1;
    parameter lw=8'd2;
    parameter beq=8'd3;
    parameter j=8'd4;
    parameter andi=8'd5;
    parameter ori=8'd6;
    parameter xori=8'd7;
    parameter addi=8'd9;
    parameter lui=8'd8;
    parameter slti=8'd10;
    parameter and_=8'd11;
    parameter or_=8'd12;
    parameter xor_=8'd13;
    parameter nor_=8'd14;
    parameter add=8'd15;
    parameter sub=8'd16;
    parameter sll=8'd17;
    parameter srl=8'd18;
    parameter slt=8'd19;

    wire [7:0] inst_type=   (I_opcode==6'b101011)?sw:
                            (I_opcode==6'b100011)?lw:
                            (I_opcode==6'b000100)?beq:
                            (I_opcode==6'b000010)?j:
                            (I_opcode==6'b001000)?andi:
                            (I_opcode==6'b001101)?ori:
                            (I_opcode==6'b001110)?xori:
                            (I_opcode==6'b001000)?addi:
                            (I_opcode==6'b001111)?lui:
                            (I_opcode==6'b001010)?slti:
                            (I_opcode==6'b000000)?(
                                (I_func==6'b100100)?and_:
                                (I_func==6'b100101)?or_:
                                (I_func==6'b100110)?xor_:
                                (I_func==6'b100111)?nor_:
                                (I_func==6'b100000)?add:
                                (I_func==6'b100010)?sub:
                                (I_func==6'b000000)?sll:
                                (I_func==6'b000010)?srl:
                                (I_func==6'b101010)?slt:0
                                ):
                            0;
    parameter op_add=8'b00000001;
    parameter op_sub=8'b00000010;
    parameter op_or=8'b00000100;
    parameter op_xor=8'b00001000;
    parameter op_and=8'b00010000;
    parameter op_nor=8'b00100000;
    parameter op_sll=8'b01000000;
    parameter op_srl=8'b10000000;  
    parameter imm=1;
    parameter rtdata=0;
    parameter memData=1;
    parameter aluRes=0;
    parameter rd=1;
    parameter rs=0;
    parameter rtaddr=0;
    parameter bjump=1;
    parameter jump=0;                      
    assign O_ALUop= (
                    inst_type==sw||
                    inst_type==lw||
                    inst_type==add||
                    inst_type==addi
                    )?op_add:
                    (inst_type==sub||inst_type==slt||inst_type==slti)?op_sub:
                    (inst_type==or_||inst_type==ori)?op_or:
                    (inst_type==xor_||inst_type==xori)?op_xor:
                    (inst_type==and_||inst_type==andi)?op_and:
                    (inst_type==nor_)?op_nor:
                    (inst_type==sll)?op_sll:
                    (inst_type==srl)?op_srl:
                    0 ;
    assign O_DataMemWe=(
                    inst_type==sw
                    )?1:0  ;
    assign O_RegsWe=(
                    inst_type==lw||
                    inst_type==and_||
                    inst_type==or_||
                    inst_type==xor_||
                    inst_type==nor_||
                    inst_type==add||
                    inst_type==sub||
                    inst_type==sll||
                    inst_type==srl||
                    inst_type==slt||
                    inst_type==andi||
                    inst_type==ori||
                    inst_type==addi||
                    inst_type==xor_||
                    inst_type==slti||
                    inst_type==lui
                    )?1:0  ;
    assign O_ALUsrcB=(
                    inst_type==sw||
                    inst_type==lw||
                    inst_type==andi||
                    inst_type==ori||
                    inst_type==addi||
                    inst_type==xor_||
                    inst_type==slti
                    )?imm:rtdata;
    assign O_ALUsrcA=(
                    inst_type==sll||
                    inst_type==srl
                    )?imm:rs;
    assign O_RegWriteData=(
                    inst_type==lw
                    )?memData:aluRes ;
    assign O_RegWriteAddr=(
                    inst_type==and_||
                    inst_type==or_||
                    inst_type==xor_||
                    inst_type==nor_||
                    inst_type==add||
                    inst_type==sub||
                    inst_type==srl||
                    inst_type==sll||
                    inst_type==slt
                    )?rd:rtaddr ;
    assign O_jump=(
                    inst_type==beq||
                    inst_type==j
                    )?1:0  ;
    assign O_borj=(
                    inst_type==beq
                    )?bjump:jump;
    assign O_ifsltsub=(
                    inst_type==slt||
                    inst_type==slti
                    )?1:(inst_type==lui)?2:0;
endmodule
