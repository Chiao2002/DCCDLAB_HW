`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2021 03:12:42 PM
// Design Name: 
// Module Name: bit_reverse
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


module bit_reverse( 
                    clk,
                    rst,
                    en,
                    in_real,
                    in_imag,
                    out_real,
                    out_imag
                    );
    input clk, rst;
    input en;
    input signed [16:0] in_real;
    input signed [16:0] in_imag;
    output signed [16:0] out_real;
    output signed [16:0] out_imag;
    
    wire [6:0] counter;
    wire [4:0] addr;
    wire ping_wrt, pong_wrt;
    wire ping_rd, pong_rd;
    
    reg signed [16:0] out_real;
    reg signed [16:0] out_imag;
    reg signed [16:0] ping_buf_real [0:15];
    reg signed [16:0] ping_buf_imag [0:15];
    reg signed [16:0] pong_buf_real [0:15];
    reg signed [16:0] pong_buf_imag [0:15];
    reg [4:0] ping_load;
    reg [4:0] pong_load;
    
    reg [4:0] k;
    reg [4:0] i;
    
    cnt_bitrev
    u0(
            .clk(clk),
            .rst(rst),
            .en(en),
            .out_num(counter)
            );
    pip
    u1(
            .counter(counter),
            .addr(addr),
            .ping_wrt(ping_wrt),
            .pong_wrt(pong_wrt),
            .ping_rd(ping_rd),
            .pong_rd(pong_rd)
            );
    
    always@(posedge clk)begin
        if(rst) begin
            ping_load <= 5'd0;
            pong_load <= 5'd0;
        end else
        if (ping_wrt == 1) begin
            ping_buf_real[addr] <= in_real;
            ping_buf_imag[addr] <= in_imag;
            ping_load <= ping_load + 5'd1;
        end else if(pong_wrt == 1) begin
            pong_buf_real[addr] <= in_real;
            pong_buf_imag[addr] <= in_imag;
            pong_load <= pong_load + 5'd1;
        end else begin
            ping_load <= ping_load;
            pong_load <= pong_load;
        end 
    end
    
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            k <= 5'd0;
            i <= 5'd0;
            out_real <= 0;
        end else if (ping_rd == 1) begin
            out_real <= ping_buf_real[k];
            out_imag <= ping_buf_imag[k];
            k <= k + 5'd1;
        end else if (pong_rd == 1) begin
            out_real <= pong_buf_real[i];
            out_imag <= pong_buf_imag[i];
            i <= i + 5'd1;
        end  
//       else if (k == 5'd16 || i == 5'd16) 
//        begin
//            k <= 5'd0;
//            i <= 5'd0;
//        end
    end
    
endmodule
