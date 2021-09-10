`timescale 1ns / 1ps
module IDEX(
    input I_clk,
    input I_rstn,
    input I_C_dataRelated,
    input [31:0]I_regiterData1,
    input [31:0]I_regiterData2,
    input [31:0]I_imm_extend,
    input [4:0]I_rd,
    input [4:0]I_rt,
    input I_C_ALUsrcA,
    input I_C_ALUsrcB,
    input [7:0]I_C_ALUop,
    input I_DataMemWe,
    input I_RegsWe,
    input I_RegWriteData,
    input I_RegWriteAddr,
    input [1:0]I_C_ifsltsub,

    output [31:0]O_regiterData1,
    output [31:0]O_regiterData2,
    output [31:0]O_imm_extend,
    output [4:0]O_rd,
    output [4:0]O_rt,
    output O_C_ALUsrcA,
    output O_C_ALUsrcB,
    output [7:0]O_C_ALUop,
    output O_DataMemWe,
    output O_RegsWe,
    output O_RegWriteData,
    output O_RegWriteAddr,
    output [1:0]O_C_ifsltsub
    );
    //¶¨ÒåÔÝ´æ¼Ä´æÆ÷
    reg [31:0]regiterData1;
    reg [31:0]regiterData2;
    reg [4:0]rd;
    reg [31:0]imm_extend;
    reg C_ALUsrcB;
    reg C_ALUsrcA;
    reg [4:0]rt;
    reg [7:0]C_ALUop;
    reg DataMemWe;
    reg RegWriteData;
    reg RegsWe;
    reg RegWriteAddr;
    reg [1:0]C_ifsltsub;
    
    always@(posedge I_clk or negedge I_rstn) begin
        //¸´Î»³õÊ¼»¯¼Ä´æÆ÷
        if(!I_rstn||I_C_dataRelated) begin
            regiterData1<=32'b0;
            regiterData2<=32'b0;
            rd<=5'b0;
            imm_extend<=32'b0;
            C_ALUsrcB<=0;
            C_ALUsrcA<=0;
            rt<=5'b0;
            C_ALUop<=7'b0;
	        DataMemWe<=0;
            RegWriteData<=0;
            RegsWe<=0;
            RegWriteAddr<=0;
            C_ifsltsub<=2'b0;
        end
        //¸ù¾ÝÊäÈëÐÅºÅ¸³Öµ¼Ä´æÆ÷
        else begin
                regiterData1<=I_regiterData1;
                regiterData2<=I_regiterData2;
                rd<=I_rd;
                imm_extend<=I_imm_extend;
                C_ALUsrcB<=I_C_ALUsrcB;
                C_ALUsrcA<=I_C_ALUsrcA;
                rt<=I_rt;
                C_ALUop<=I_C_ALUop;
                DataMemWe<=I_DataMemWe;
                RegWriteData<=I_RegWriteData;
                RegsWe<=I_RegsWe;
                RegWriteAddr<=I_RegWriteAddr;
                C_ifsltsub<=I_C_ifsltsub;
        end
    end
    //Êä³ö¼Ä´æÆ÷´æ´¢Öµ
    assign  O_regiterData1=regiterData1;
    assign  O_regiterData2=regiterData2;  
    assign  O_rd=rd;
    assign  O_imm_extend=imm_extend;
    assign  O_C_ALUsrcB=C_ALUsrcB;
    assign  O_C_ALUsrcA=C_ALUsrcA;
    assign  O_rt=rt;
    assign  O_C_ALUop=C_ALUop;
    assign  O_DataMemWe=DataMemWe;
    assign  O_RegWriteData=RegWriteData;
    assign  O_RegsWe=RegsWe;
    assign  O_RegWriteAddr=RegWriteAddr;
    assign  O_C_ifsltsub=C_ifsltsub;
endmodule