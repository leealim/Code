`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 16:31:57
// Design Name: 
// Module Name: Display
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


module Display(
    input I_clk  ,
    input I_rstn  ,
    input [3:0]I_A0  ,
    input [3:0]I_B0  ,
    input [3:0]I_A1  ,
    input [3:0]I_B1  ,
    input [3:0]I_A2  ,
    input [3:0]I_B2  ,
    input [3:0]I_A3  ,
    input [3:0]I_B3  ,
    output [6:0]O_led_A  ,
    output [3:0]O_px_A  ,
    output [6:0]O_led_B  ,
    output [3:0]O_px_B
    );
    integer count;
    reg [6:0]led_A;
    reg [6:0]led_B;
    reg [3:0]px_A;
    reg [3:0]px_B;
    parameter c=100000;
    always @(posedge I_clk or negedge I_rstn)   begin
        if(!I_rstn) begin
            count<=0;
            led_A<=7'd0;
            led_B<=7'd0;
            px_A<=4'd0;
            px_B<=4'd0;
        end
        else begin
            if(count==0) begin
            px_A<=4'b0001;
            px_B<=4'b0001;
            case (I_A0)
                4'b0000: led_A <= 7'b0111111; // 0
                4'b0001: led_A <= 7'b0000110; // 1
                4'b0010: led_A <= 7'b1011011; // 2
                4'b0011: led_A <= 7'b1001111; // 3
                4'b0100: led_A <= 7'b1100110; // 4
                4'b0101: led_A <= 7'b1101101; // 5
                4'b0110: led_A <= 7'b1111101; // 6
                4'b0111: led_A <= 7'b0000111; // 7
                4'b1000: led_A <= 7'b1111111; // 8
                4'b1001: led_A <= 7'b1101111; // 9
                4'b1010: led_A <= 7'b0000000; // A
                4'b1011: led_A <= 7'b0000001; // b
                4'b1100: led_A <= 7'b0111001; // c
                4'b1101: led_A <= 7'b1011110; // d
                4'b1110: led_A <= 7'b1111001; // E
                4'b1111: led_A <= 7'b1110001; // F
                default: led_A <= 7'b0000000;
            endcase 
            case (I_B0)
                4'b0000: led_B <= 7'b0111111; // 0
                4'b0001: led_B <= 7'b0000110; // 1
                4'b0010: led_B <= 7'b1011011; // 2
                4'b0011: led_B <= 7'b1001111; // 3
                4'b0100: led_B <= 7'b1100110; // 4
                4'b0101: led_B <= 7'b1101101; // 5
                4'b0110: led_B <= 7'b1111101; // 6
                4'b0111: led_B <= 7'b0000111; // 7
                4'b1000: led_B <= 7'b1111111; // 8
                4'b1001: led_B <= 7'b1101111; // 9
                4'b1010: led_B <= 7'b0000000; // A
                4'b1011: led_B <= 7'b0000001; // b
                4'b1100: led_B <= 7'b0111001; // c
                4'b1101: led_B <= 7'b1011110; // d
                4'b1110: led_B <= 7'b1111001; // E
                4'b1111: led_B <= 7'b1110001; // F
                default: led_B <= 7'b0000000;
            endcase 
            count<=count+1;
        end 
        else if(count==1*c) begin
            px_A<=4'b0010;
            px_B<=4'b0010;
            case (I_A1)
                4'b0000: led_A <= 7'b0111111; // 0
                4'b0001: led_A <= 7'b0000110; // 1
                4'b0010: led_A <= 7'b1011011; // 2
                4'b0011: led_A <= 7'b1001111; // 3
                4'b0100: led_A <= 7'b1100110; // 4
                4'b0101: led_A <= 7'b1101101; // 5
                4'b0110: led_A <= 7'b1111101; // 6
                4'b0111: led_A <= 7'b0000111; // 7
                4'b1000: led_A <= 7'b1111111; // 8
                4'b1001: led_A <= 7'b1101111; // 9
                4'b1010: led_A <= 7'b0000000; // A
                4'b1011: led_A <= 7'b0000001; // b
                4'b1100: led_A <= 7'b0111001; // c
                4'b1101: led_A <= 7'b1011110; // d
                4'b1110: led_A <= 7'b1111001; // E
                4'b1111: led_A <= 7'b1110001; // F
                default: led_A <= 7'b0000000;
            endcase 
            case (I_B1)
                4'b0000: led_B <= 7'b0111111; // 0
                4'b0001: led_B <= 7'b0000110; // 1
                4'b0010: led_B <= 7'b1011011; // 2
                4'b0011: led_B <= 7'b1001111; // 3
                4'b0100: led_B <= 7'b1100110; // 4
                4'b0101: led_B <= 7'b1101101; // 5
                4'b0110: led_B <= 7'b1111101; // 6
                4'b0111: led_B <= 7'b0000111; // 7
                4'b1000: led_B <= 7'b1111111; // 8
                4'b1001: led_B <= 7'b1101111; // 9
                4'b1010: led_B <= 7'b0000000; // A
                4'b1011: led_B <= 7'b0000001; // b
                4'b1100: led_B <= 7'b0111001; // c
                4'b1101: led_B <= 7'b1011110; // d
                4'b1110: led_B <= 7'b1111001; // E
                4'b1111: led_B <= 7'b1110001; // F
                default: led_B <= 7'b0000000;
            endcase 
            count<=count+1;
        end 
        else if(count==2*c) begin
            px_A<=4'b0100;
            px_B<=4'b0100;
            case (I_A2)
                4'b0000: led_A <= 7'b0111111; // 0
                4'b0001: led_A <= 7'b0000110; // 1
                4'b0010: led_A <= 7'b1011011; // 2
                4'b0011: led_A <= 7'b1001111; // 3
                4'b0100: led_A <= 7'b1100110; // 4
                4'b0101: led_A <= 7'b1101101; // 5
                4'b0110: led_A <= 7'b1111101; // 6
                4'b0111: led_A <= 7'b0000111; // 7
                4'b1000: led_A <= 7'b1111111; // 8
                4'b1001: led_A <= 7'b1101111; // 9
                4'b1010: led_A <= 7'b0000000; // A
                4'b1011: led_A <= 7'b0000001; // b
                4'b1100: led_A <= 7'b0111001; // c
                4'b1101: led_A <= 7'b1011110; // d
                4'b1110: led_A <= 7'b1111001; // E
                4'b1111: led_A <= 7'b1110001; // F
                default: led_A <= 7'b0000000;
            endcase 
            case (I_B2)
                4'b0000: led_B <= 7'b0111111; // 0
                4'b0001: led_B <= 7'b0000110; // 1
                4'b0010: led_B <= 7'b1011011; // 2
                4'b0011: led_B <= 7'b1001111; // 3
                4'b0100: led_B <= 7'b1100110; // 4
                4'b0101: led_B <= 7'b1101101; // 5
                4'b0110: led_B <= 7'b1111101; // 6
                4'b0111: led_B <= 7'b0000111; // 7
                4'b1000: led_B <= 7'b1111111; // 8
                4'b1001: led_B <= 7'b1101111; // 9
                4'b1010: led_B <= 7'b0000000; // A
                4'b1011: led_B <= 7'b0000001; // b
                4'b1100: led_B <= 7'b0111001; // c
                4'b1101: led_B <= 7'b1011110; // d
                4'b1110: led_B <= 7'b1111001; // E
                4'b1111: led_B <= 7'b1110001; // F
                default: led_B <= 7'b0000000;
            endcase 
            count<=count+1;
        end 
        else if(count==3*c) begin
            px_A<=4'b1000;
            px_B<=4'b1000;
            case (I_A3)
                4'b0000: led_A <= 7'b0111111; // 0
                4'b0001: led_A <= 7'b0000110; // 1
                4'b0010: led_A <= 7'b1011011; // 2
                4'b0011: led_A <= 7'b1001111; // 3
                4'b0100: led_A <= 7'b1100110; // 4
                4'b0101: led_A <= 7'b1101101; // 5
                4'b0110: led_A <= 7'b1111101; // 6
                4'b0111: led_A <= 7'b0000111; // 7
                4'b1000: led_A <= 7'b1111111; // 8
                4'b1001: led_A <= 7'b1101111; // 9
                4'b1010: led_A <= 7'b0000000; // A
                4'b1011: led_A <= 7'b1000000; // b
                4'b1100: led_A <= 7'b0111001; // c
                4'b1101: led_A <= 7'b1011110; // d
                4'b1110: led_A <= 7'b1111001; // E
                4'b1111: led_A <= 7'b1110001; // F
                default: led_A <= 7'b0000000;
            endcase 
            case (I_B3)
                4'b0000: led_B <= 7'b0111111; // 0
                4'b0001: led_B <= 7'b0000110; // 1
                4'b0010: led_B <= 7'b1011011; // 2
                4'b0011: led_B <= 7'b1001111; // 3
                4'b0100: led_B <= 7'b1100110; // 4
                4'b0101: led_B <= 7'b1101101; // 5
                4'b0110: led_B <= 7'b1111101; // 6
                4'b0111: led_B <= 7'b0000111; // 7
                4'b1000: led_B <= 7'b1111111; // 8
                4'b1001: led_B <= 7'b1101111; // 9
                4'b1010: led_B <= 7'b0000000; // A
                4'b1011: led_B <= 7'b1000000; // b
                4'b1100: led_B <= 7'b0111001; // c
                4'b1101: led_B <= 7'b1011110; // d
                4'b1110: led_B <= 7'b1111001; // E
                4'b1111: led_B <= 7'b1110001; // F
                default: led_B <= 7'b0000000;
            endcase 
            count<=count+1;
        end 
        else if(count==4*c)count<=0;
        else
            count<=count+1;
        end
    end
    assign O_led_A=led_A;
    assign O_led_B=led_B;
    assign O_px_A=px_A;
    assign O_px_B=px_B;
endmodule
