`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 20:45:06
// Design Name: 
// Module Name: BTB
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


module BTB(

    );
    reg [7:0] A;
    reg [7:0] B;
    reg [8:0] C;
    reg rstn;
    reg [1:0]count;
    BinToBCD btb(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_A            (A          ),
        .I_B            (B          ),
        .I_C            (C          ), 
        .I_count        (count      ),
        
        .O_res_A0           (res_A0     ),
        .O_res_B0           (res_B0     ),
        .O_res_A1           (res_A1     ),
        .O_res_B1           (res_B1     ),
        .O_res_A2           (res_A2     ),
        .O_res_B2           (res_B2     ),
        .O_res_A3           (res_A3     ),
        .O_res_B3           (res_B3     )
    );
    initial
    begin
        count=3;
        A=8'b01111111;
        B=8'b11111111;
        C=9'b111111111;
        rstn = 1'b0;
        #10
        rstn = 1'b1;
        #10
        count=0;
        A=8'b11111111;
        B=8'b01111111;
        C=9'b011111111;
        #500
        rstn = 1'b0;   
    end  
endmodule
