`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 16:46:57
// Design Name: 
// Module Name: BinToBCD
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


module BinToBCD(
    input [7:0]I_A  ,
    input [7:0]I_B  ,
    input [8:0]I_C  ,
    input [1:0]I_count  ,
    
    output [3:0]O_res_A0  ,
    output [3:0]O_res_B0  ,
    output [3:0]O_res_A1  ,
    output [3:0]O_res_B1  ,
    output [3:0]O_res_A2  ,
    output [3:0]O_res_B2  ,
    output [3:0]O_res_A3  ,
    output [3:0]O_res_B3
    );
    reg [3:0]res_A0;
    reg [3:0]res_B0;
    reg [3:0]res_A1;
    reg [3:0]res_B1;
    reg [3:0]res_A2;
    reg [3:0]res_B2;
    reg [3:0]res_C0;
    reg [3:0]res_C1;
    reg [3:0]res_C2;
    integer i;
    wire [7:0]I_At=I_A[7]?~I_A+1:I_A;
    wire [7:0]I_Bt=I_B[7]?~I_B+1:I_B;
    wire [8:0]I_Ct=I_C[8]?~I_C+1:I_C;
    always@(I_A) begin
        res_A0=4'd0;
        res_A1=4'd0;
        res_A2=4'd0;
        for(i=7;i>=0;i=i-1)begin
                if(res_A0>=5)res_A0=res_A0+3;
                if(res_A1>=5)res_A1=res_A1+3;
                if(res_A2>=5)res_A2=res_A2+3;
                
                res_A2=res_A2<<1;
                res_A2[0]=res_A1[3];
                res_A1=res_A1<<1;
                res_A1[0]=res_A0[3];
                res_A0=res_A0<<1;
                res_A0[0]=I_At[i];

            end
               
        end
        
        always@(I_C) begin
            res_C0=4'd0;
            res_C1=4'd0;
            res_C2=4'd0;
            for(i=7;i>=0;i=i-1)begin
                if(res_C0>=5)res_C0=res_C0+3;
                if(res_C1>=5)res_C1=res_C1+3;
                if(res_C2>=5)res_C2=res_C2+3;
                res_C2=res_C2<<1;
                res_C2[0]=res_C1[3];
                res_C1=res_C1<<1;
                res_C1[0]=res_C0[3];
                res_C0=res_C0<<1;
                res_C0[0]=I_Ct[i];  
            end
        end
        always@(I_B) begin
        res_B0=4'd0;
        res_B1=4'd0;
        res_B2=4'd0;
        for(i=7;i>=0;i=i-1)begin
                if(res_B0>=5)res_B0=res_B0+3;
                if(res_B1>=5)res_B1=res_B1+3;
                if(res_B2>=5)res_B2=res_B2+3;
                res_B2=res_B2<<1;
                res_B2[0]=res_B1[3];
                res_B1=res_B1<<1;
                res_B1[0]=res_B0[3];
                res_B0=res_B0<<1;
                res_B0[0]=I_Bt[i];  
            end
        end
    assign O_res_A0=I_count==3?res_C0:res_A0;
    assign O_res_B0=I_count==3?10:res_B0;
    assign O_res_A1=I_count==3?res_C1:res_A1;
    assign O_res_B1=I_count==3?10:res_B1;
    assign O_res_A2=I_count==3?res_C2:res_A2;
    assign O_res_B2=I_count==3?10:res_B2;
    assign O_res_A3=I_count==3?I_C[7]?11:10:I_A[7]?11:10;
    assign O_res_B3=I_count==3?10:I_B[7]?11:10;
endmodule
