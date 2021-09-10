`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/04 20:35:11
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input I_clk  ,
    input I_rstn  ,
    input I_we  ,
    input [31:0]I_address  ,
    input [31:0]I_write_data  ,
    output [31:0]O_read_data
    );
    
    reg [7:0] mem[255:0];
    initial begin
    $readmemb("D:\\Documents\\CodeFiles\\Mars_for_cpu\\mipsdata.txt",mem);
    end
    wire [7:0] addr=I_address[7:0];
    assign O_read_data={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
    
    always@(posedge I_clk)begin
        if(I_we) begin
            mem[addr]<=I_write_data[7:0];
            mem[addr+1]<=I_write_data[15:8];
            mem[addr+2]<=I_write_data[23:16];
            mem[addr+3]<=I_write_data[31:24];
        end
    end
endmodule
