`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
    input I_clk,
    input I_rstn,
    input [31:0]I_resALU,
    input [31:0]I_dm_data,
    input [4:0]I_addr_regs_write,
    input I_RegsWe,
    input I_RegWriteData,
    output [31:0]O_resALU,
    output [31:0]O_dm_data,
    output [4:0]O_addr_regs_write,
    output O_RegsWe,
    output O_RegWriteData
);

//¶¨ÒåÔÝ´æ¼Ä´æÆ÷
    reg RegWriteData;
    reg RegsWe;
    reg [31:0]resALU;
    reg [31:0]dm_data;
    reg [4:0]addr_regs_write;
    
    
    always@(posedge I_clk or negedge I_rstn) begin
        //¸´Î»³õÊ¼»¯¼Ä´æÆ÷
        if(!I_rstn) begin
            RegWriteData<=0;
            RegsWe<=0;
            dm_data<=32'b0;
            resALU<=32'b0;
            addr_regs_write<=5'b0;
        end
        //¸ù¾ÝÊäÈëÐÅºÅ¸³Öµ¼Ä´æÆ÷
        else begin
            RegWriteData<=I_RegWriteData;
            RegsWe<=I_RegsWe;
            dm_data<=I_dm_data;
            resALU<=I_resALU;
            addr_regs_write<=I_addr_regs_write;
        end
    end
    //Êä³ö¼Ä´æÆ÷´æ´¢Öµ
    assign  O_RegWriteData=RegWriteData;
    assign  O_RegsWe=RegsWe;
    assign  O_dm_data=dm_data;
    assign  O_resALU=resALU;
    assign  O_addr_regs_write=addr_regs_write;
endmodule
