`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
    input I_clk  ,
    input I_rstn  ,
    input [31:0]I_inst_addr  ,
    output [31:0]O_inst_out
    );
    
    reg [7:0] mem[255:0];
    initial begin
    $readmemb("D:\\Documents\\CodeFiles\\Mars_for_cpu\\machinecodevschandled.txt",mem);
    end
    wire [7:0] addr=I_inst_addr[7:0];
    assign O_inst_out={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
endmodule
