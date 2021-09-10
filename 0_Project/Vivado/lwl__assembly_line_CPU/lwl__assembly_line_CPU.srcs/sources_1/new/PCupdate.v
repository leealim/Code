`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 19:49:07
// Design Name: 
// Module Name: PCupdate
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


module PCupdate(
        input I_clk  ,
        input I_rstn  ,
        input I_borj  ,
        input I_jump  ,
        input [31:0]I_rsd  ,
        input [31:0]I_rtd  ,
        input [31:0]I_imme  ,
        input [31:0]I_pcPlus4_d  , 
        input [31:0]I_pcPlus4_f  ,
        input [31:0]I_inst  ,
        output [31:0]O_pc_update
    );
    wire ifjump=I_borj?((I_rsd==I_rtd)&&I_jump?1:0):I_jump;
    wire [31:0] jump_addr=I_borj?(I_imme<<2+I_pcPlus4_d):{I_pcPlus4_d[31:28],I_inst[25:0]<<2};
    assign O_pc_update=I_jump?jump_addr:I_pcPlus4_f;
endmodule
