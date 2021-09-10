`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/07 18:10:41
// Design Name: 
// Module Name: DataRelated
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


module DataRelated(
        input I_clk  ,
        input I_rstn  ,
        input [4:0]I_reg_write_addr_e ,
        input [4:0]I_reg_write_addr_m ,
        input [4:0]I_reg_write_addr_w ,
        input I_RegsWe_e  ,
        input I_RegsWe_m  ,
        input I_RegsWe_w  ,
        input I_ALUsrcA  ,
        input I_ALUsrcB  ,
        input [4:0]I_read_addr_1  ,
        input [4:0]I_read_addr_2  ,
        
        output O_if_dr_Stop  
    );
    assign O_if_dr_Stop=(I_read_addr_1==0?0:
                (I_ALUsrcA?0:
                    (
                        (I_RegsWe_e?I_read_addr_1==I_reg_write_addr_e:0)||
                        (I_RegsWe_m?I_read_addr_1==I_reg_write_addr_m:0)||
                        (I_RegsWe_w?I_read_addr_1==I_reg_write_addr_w:0)
                    )
                ))||(I_read_addr_2==0?0:
                (I_ALUsrcB?0:
                    (
                        (I_RegsWe_e?I_read_addr_2==I_reg_write_addr_e:0)||
                        (I_RegsWe_m?I_read_addr_2==I_reg_write_addr_m:0)||
                        (I_RegsWe_w?I_read_addr_2==I_reg_write_addr_w:0)
                    )
                ));
endmodule
