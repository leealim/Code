`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
    input I_clk,
    input I_rstn,
    input [31:0]I_addr_dataMem,
    input [31:0]I_data_dataMem,
    input [4:0]I_addr_regs_write,
    input I_DataMemWe,
    input I_RegsWe,
    input I_RegWriteData,
    output [31:0]O_addr_dataMem,
    output [31:0]O_data_dataMem,
    output [4:0]O_addr_regs_write,
    output O_DataMemWe,
    output O_RegsWe,
    output O_RegWriteData
);


    //¶¨ÒåÔİ´æ¼Ä´æÆ÷
    reg [31:0]data_dataMem;
    reg [31:0]addr_dataMem;
    reg [4:0]addr_regs_write;
    reg DataMemWe;
    reg RegWriteData;
    reg RegsWe;
    
    always@(posedge I_clk or negedge I_rstn) begin
        //¸´Î»³õÊ¼»¯¼Ä´æÆ÷
        if(!I_rstn) begin
            data_dataMem<=32'b0;
            addr_dataMem<=32'b0;
            addr_regs_write<=5'b0;
            DataMemWe<=0;
            RegWriteData<=0;
            RegsWe<=0;
        end
        //¸ù¾İÊäÈëĞÅºÅ¸³Öµ¼Ä´æÆ÷
        else begin
            data_dataMem<=I_data_dataMem;
            addr_dataMem<=I_addr_dataMem;
            addr_regs_write<=I_addr_regs_write;
            DataMemWe<=I_DataMemWe;
            RegWriteData<=I_RegWriteData;
            RegsWe<=I_RegsWe;
        end
    end
    //Êä³ö¼Ä´æÆ÷´æ´¢Öµ
    assign  O_data_dataMem=data_dataMem;
    assign  O_addr_dataMem=addr_dataMem;
    assign  O_addr_regs_write=addr_regs_write;
    assign  O_DataMemWe=DataMemWe;
    assign  O_RegWriteData=RegWriteData;
    assign  O_RegsWe=RegsWe;
endmodule