`timescale 1ns / 1ps

module Multi_Seg_Driver(clk,bcd_in,sseg_a_o,sseg_c_o);
input clk;
input [15:0] bcd_in;
output [3:0] sseg_a_o;
output [6:0] sseg_c_o;

 

wire en;
wire [3:0] anode, bcd_seg;
anode_gen UUT1(clk, en, anode);
Mux4_to_1 UUT2(anode, bcd_seg, en, bcd_in, sseg_a_o);
ss_decode  UUT3(clk, bcd_seg,sseg_c_o);
endmodule
 

module anode_gen(clk, en, anode);
input clk;
output reg en;


output [3:0] anode = 4'b1000;

reg [3:0] bcd_seg = 4'b0000;
reg [3:0] anode = 4'b1000;
 

parameter g_s = 8;
parameter gt = 4;
reg [g_s-1:0] g_count = 0;
 

    always @(posedge clk)
    begin
    g_count = g_count +1;
        if(g_count == 0)
            begin
            if(anode == 4'b0001)
                begin
                anode = 4'b1000;
                end
            else
                begin
                anode = anode >>1;
                end
            end
    end

    always @(posedge clk)
    begin
        if (&g_count[g_s-1:gt])
            begin
            en = 1'b1;
            end
        else
            en = 1'b0;
    end
endmodule
 

module ss_decode (clk, bcd, SEG);
    input clk;
    input [3:0] bcd;
    output reg [6:0] SEG;

   

    always @(posedge clk)
    begin
        case(bcd)
            0 : SEG = 7'b1000000;
            1 : SEG = 7'b1111001;
            2 : SEG = 7'b0100100;
            3 : SEG = 7'b0110000;
            4 : SEG = 7'b0011001;
            5 : SEG = 7'b0010010;
            6 : SEG = 7'b0000010;
            7 : SEG = 7'b1111000;
            8 : SEG = 7'b0000000;
            9 : SEG = 7'b0010000;
            
            default : SEG = 7'b1111111;
        endcase
    end
endmodule
 

module Mux4_to_1(anode, bcd_seg, en, bcd_in, sseg_a_o);
    input en;
    input [3:0] anode;
    input [15:0] bcd_in;
    output [3:0] sseg_a_o;
    output reg [3:0] bcd_seg;
   

    always @(*)
    begin
        if(en)
        begin
            case(anode)
                4'b1000 : bcd_seg = bcd_in[15:12];
                4'b0100 : bcd_seg = bcd_in[11:8];
                4'b0010 : bcd_seg = bcd_in[7:4];
                4'b0001 : bcd_seg = bcd_in[3:0];
                default : bcd_seg = 4'b1111;
            endcase
        end
    end
    assign sseg_a_o = ~anode;
endmodule