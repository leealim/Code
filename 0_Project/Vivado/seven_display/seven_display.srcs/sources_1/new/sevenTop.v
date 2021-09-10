`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/07 22:07:30
// Design Name: 
// Module Name: sevenTop
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


module sevenTop(
        input  clk,
        input  rstn,
        
        input I_plus,
        input I_minus,
        input I_comfirm,
        input [7:0] I_switch,
        
        output [6:0]O_led_A,
        output [3:0]O_px_A,
        output [6:0]O_led_B,
        output [3:0]O_px_B,
        output [3:0]debug,
        output overflow
    );
    reg [7:0]A;
    reg [7:0]B;
    reg op;
    reg [1:0]count;
    //reg [8:0]regC;
    wire [7:0]C;
    ALU alu(
        .I_A            (A          ),
        .I_B            (B          ),                    
        .I_op           (op         ),
                         
        .O_C            (C          ), 
        .O_of           (overflow   )           
        );
        
    wire [3:0]res_A0;
    wire [3:0]res_B0;
    wire [3:0]res_A1;
    wire [3:0]res_B1;
    wire [3:0]res_A2;
    wire [3:0]res_B2;
    wire [3:0]res_A3;
    wire [3:0]res_B3;
    BinToBCD btb(
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
    
    Display dis(
        .I_clk          (clk        ), 
        .I_rstn         (rstn       ),
        .I_A0           (res_A0     ),
        .I_B0           (res_B0     ),
        .I_A1           (res_A1     ),
        .I_B1           (res_B1     ),
        .I_A2           (res_A2     ),
        .I_B2           (res_B2     ),
        .I_A3           (res_A3     ),
        .I_B3           (res_B3     ),
        
        .O_led_A        (O_led_A    ),
        .O_px_A           (O_px_A       ),
        .O_led_B        (O_led_B    ),
        .O_px_B         (O_px_B     )
        );   
        
    always @(negedge rstn or posedge I_comfirm or posedge I_plus or posedge I_minus or posedge clk)
    begin
        if(!rstn) begin
            count<=2'b0;
            op<=0;
        end
        else 
        if(count==0&&I_comfirm) begin 
            count<=1;
        end
        else 
        if(count==1&&(I_plus||I_minus)) begin
                op<=I_plus?0:1;
                count<=2;
        end
        else 
        if(count==2&&I_comfirm)    begin
            count<=3;
        end
//        else 
//        if(count==3&&(I_plus||I_minus))begin  //count=3
//            op<=I_plus?0:1;
//            count<=2;
//        end
    end
    always @(rstn or I_switch or count)
    begin
        if(!rstn) begin
            A<=I_switch;
            B<=8'b0;
            //regC<=9'b0;
        end
        else if(count==0) begin
            A<=I_switch;
            //regC[7:0]<=I_switch;
        end
        else
        if(count==2) begin
            B<=I_switch;
            //A<=regC[7:0];
        end
        //else if(count==3) regC<=C;
    end
    assign debug=
                count==0?4'b0001:
                count==1?4'b0010:
                count==2?4'b0100:
                count==3?4'b1000:
                4'b0000;
endmodule
