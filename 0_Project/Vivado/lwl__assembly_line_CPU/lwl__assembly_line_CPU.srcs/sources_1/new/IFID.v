`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
// Design Name: 
// Module Name: IFID
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


module IFID(
    input I_clk,
    input I_rstn,
    input I_C_dataRelated,
    input [31:0]I_inst,
    input [31:0]I_pcPlus4,
    output [31:0]O_inst,
    output [31:0]O_pcPlus4
    );
    //¶¨ÒåÔÝ´æ¼Ä´æÆ÷
    reg [31:0]inst;
    reg [31:0]pcPlus4;
    
    
    always@(posedge I_clk or negedge I_rstn) begin
        //¸´Î»³õÊ¼»¯¼Ä´æÆ÷
        if(!I_rstn) begin
            inst<=32'b0;
            pcPlus4<=32'b100;
        end
        //¸ù¾ÝÊäÈëÐÅºÅ¸³Öµ¼Ä´æÆ÷
        else begin
            if(!I_C_dataRelated) begin
                inst<=I_inst;
                pcPlus4<=I_pcPlus4;
            end 
        end
    end
    //Êä³ö¼Ä´æÆ÷´æ´¢Öµ
    assign  O_inst=inst;
    assign  O_pcPlus4=pcPlus4;
endmodule
