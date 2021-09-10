`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/28 15:58:13
// Design Name: 
// Module Name: Imm_extend
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


module Imm_extend(
        input         clk,
        input         rstn,
        
        input [15:0] imm_in,
        output [31:0] imm_out,
        input imm_c
    );
    
    assign imm_out=(imm_c==1)?{imm_in, 16'b0}:{{(16){imm_in[15]}}, imm_in};
endmodule
