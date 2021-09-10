`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
// Design Name: 
// Module Name: SignedExtend
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


module SignedExtend(
    input I_clk  ,
    input I_rstn  ,
    input [15:0]I_imm  ,
    output [31:0]O_imm_e
    );
    
    assign O_imm_e={{(16){I_imm[15]}}, I_imm};
endmodule
