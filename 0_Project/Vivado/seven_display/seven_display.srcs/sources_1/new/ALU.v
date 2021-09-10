`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 16:31:37
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
    input [7:0]I_A  ,
    input [7:0]I_B  ,
    input I_op  ,
    
    output [7:0]O_C,
    output O_of           
    );
    wire [8:0]A={I_A[7],I_A};
    wire [8:0]B={I_B[7],I_B};
    wire [8:0]C=I_op?(A-B):(A+B);
    assign O_C=C[7:0];
    assign O_of=C[8]^C[7];
endmodule
