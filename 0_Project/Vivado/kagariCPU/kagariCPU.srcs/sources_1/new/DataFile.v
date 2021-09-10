`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/29 13:43:44
// Design Name: 
// Module Name: DataFile
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


module DataFile(
        input         clk,
        input         rstn,
        
        input memwe,
        input [31:0] address,    
        output [31:0]readdata,   
        input [31:0] writedata           
    );
    
    reg [7:0] mem[255:0];
    initial begin
    $readmemb("D:\\Documents\\CodeFiles\\Mars_for_cpu\\mipsdata.txt",mem);
    end
    wire [7:0] addr=address[7:0];
    assign readdata={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
    
    always@(posedge clk)begin
        if(memwe) begin
            mem[addr]<=writedata[7:0];
            mem[addr+1]<=writedata[15:8];
            mem[addr+2]<=writedata[23:16];
            mem[addr+3]<=writedata[31:24];
        end
    end
endmodule
