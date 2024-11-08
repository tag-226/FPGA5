`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 02:49:58 PM
// Design Name: 
// Module Name: multi_digit_display_tb
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


module Multi_Seg_Driver_tb;
    reg clk;
    reg [15:0] bcd_in;
    wire [3:0] sseg_a_o;
    wire [6:0] sseg_c_o;
   

    Multi_Seg_Driver uut(clk,bcd_in,sseg_a_o,sseg_c_o);
   
    always
    begin
        #5 clk = ~clk;  // Toggle clock every 5 time units (10-time unit clock period)
    end
   

    initial begin
        clk = 0;
    bcd_in  = 16'b0001001000110100;
    #1280;
    bcd_in  = 16'b0101011001111000;
    #1280;
    
    $stop;
end
endmodule

