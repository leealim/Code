`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 21:42:42
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
        input         clk,
        input         rstn,

        input [31:0] A,
        input [31:0] B,
        input [1:0] op,
        
        output [31:0] C
    );
    wire [31:0]resAdd;
    wire co;
    FullAdder32 adder(A,B,0,resAdd,co);//可能需要检查溢出
    assign C=(op==1)?resAdd:
            (op==2)?(A^B):0;
    
endmodule

module FullAdder32(
        input [31:0] a,
        input [31:0] b,
        input carryIn,
        output [31:0] s,
        output carryOut
    );
    wire c16;
    FullAdder16 adder1(a[15:0],b[15:0],carryIn,s[15:0],c16);
    FullAdder16 adder2(a[31:16],b[31:16],c16,s[31:16],carryOut);
    
endmodule

module FullAdder16(
        input [15:0] a,
        input [15:0] b,
        input carryIn,
        output [15:0] s,
        output carryOut
    );
    wire [3:0]pm;
    wire [3:0]gm;
    wire [3:0]c;
    fourBitFullAdder adder4(a[3:0],b[3:0],carryIn,s[3:0],pm[0],gm[0]);
    fourBitFullAdder adder8(a[7:4],b[7:4],c[0],s[7:4],pm[1],gm[1]);
    fourBitFullAdder adder12(a[11:8],b[11:8],c[1],s[11:8],pm[2],gm[2]);
    fourBitFullAdder adder16(a[15:12],b[15:12],c[2],s[15:12],pm[3],gm[3]);
    fourCLA fcla16(carryIn,gm,pm,c);
    assign carryOut=c[3];
endmodule

module fourBitFullAdder(
        input [3:0] a,
        input [3:0] b,
        input carryIn,
        output [3:0] s,
        output Pm,Gm
    );
    wire [3:0] g;
    wire [3:0] p;
    assign  g=a&b,
            p=a^b,
            Pm = p[0] & p[1] & p[2] & p[3],
            Gm = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
            
    wire [3:0] c;
    fourCLA fcla4(carryIn,g,p,c);
    oneBitFullAdder adder1(a[0],b[0],carryIn,s[0]);//此处有未连接端口
    oneBitFullAdder adder2(a[1],b[1],c[0],s[1]);
    oneBitFullAdder adder3(a[2],b[2],c[1],s[2]);
    oneBitFullAdder adder4(a[3],b[3],c[2],s[3]);
endmodule

module fourCLA(
        input c0,[3:0] g,wire [3:0] p,
        output [3:0] c
    );
    
   assign   c[0] = g[0] | (p[0] & c0),
            c[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c0),
			c[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c0),
			c[3] = g[3] | (p[3] & g[2]) | (p[3] & p[2 ]& g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c0);
    
endmodule

module oneBitFullAdder(
        input a,b,c0,
        output s//,c1
    );
    
   assign   s = a ^ b^c0/*,
            c1=(a ^ b) & c0 | (a & b)*/; 
    
endmodule