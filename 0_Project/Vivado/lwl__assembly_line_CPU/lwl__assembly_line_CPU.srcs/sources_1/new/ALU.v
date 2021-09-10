`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
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


module ALU(
    input I_clk,
    input I_rstn,     
    input [31:0]    I_A   ,        
    input [31:0]    I_B  ,                          
    input [7:0]     I_op   , 
                             
    output [31:0]   O_C            
    );
    
    parameter op_add=8'b00000001;
    parameter op_sub=8'b00000010;
    parameter op_or=8'b00000100;
    parameter op_xor=8'b00001000;
    parameter op_and=8'b00010000;
    parameter op_nor=8'b00100000;
    parameter op_sll=8'b01000000;
    parameter op_srl=8'b10000000;  
    
    assign O_C= (I_op==op_add)?I_A+I_B:
                (I_op==op_sub)?I_A-I_B:
                (I_op==op_or)?I_A|I_B:
                (I_op==op_xor)?I_A^I_B:
                (I_op==op_and)?I_A&I_B:
                (I_op==op_nor)?~(I_A|I_B):
                (I_op==op_sll)?I_B<<I_A[10:6]:
                (I_op==op_srl)?I_B>>I_A[10:6]:
                32'b0;
endmodule