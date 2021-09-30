`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/28 15:43:42
// Design Name: 
// Module Name: InstructionFile
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


module InstructionFile(
        input         clk,
        input         rstn,

        input [31:0] inst_addr,
        output [31:0] inst
    );
    
    reg [7:0] mem[255:0];
    initial begin
    $readmemb("D:\\Documents\\CodeFiles\\Mars_for_cpu\\TempFile\\machinecodevschandled.txt",mem);
    end
    wire [7:0] addr=inst_addr[7:0];
    assign inst={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
endmodule
