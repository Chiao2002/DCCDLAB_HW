`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2021 06:39:07 PM
// Design Name: 
// Module Name: cordic2
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


module cordic2( clk, x, y, theda, x_out, y_out, theda_out );
    input clk;
    input signed [11:0] x;
    input signed [11:0] y;
    input signed [11:0] theda;
    output reg signed [11:0] x_out;
    output reg signed [11:0] y_out;
    output reg signed [11:0] theda_out;
    
    reg signed [11:0] inX_reg;
    reg signed [11:0] inY_reg;
    reg signed [11:0] inTheda_reg;
    wire signed [11:0] outX_reg;
    wire signed [11:0] outY_reg;
    wire signed [11:0] outTheda_reg;
    wire signed [11:0] x0, x1, x2, x3, x4, x5, x6, x7, x8;
    wire signed [11:0] y0, y1, y2, y3, y4, y5, y6, y7, y8;
    wire signed [11:0] theda0, theda1, theda2, theda3, theda4, theda5;
    
    always@(posedge clk) begin
        inX_reg <= x;
        inY_reg <= y;
        inTheda_reg <= theda;
    end
    
    always@(posedge clk) begin
        x_out <= outX_reg;
        y_out <= outY_reg;
        theda_out <= outTheda_reg;
    end
    
    initialStage iniS( .x( inX_reg ), .y( inY_reg ), .theda( inTheda_reg ), .x0( x0 ), .y0( y0 ), .theda0( theda0 ) );
    stage0 S0( .x_i( x0 ), .y_i( y0 ), .theda_i( theda0 ), .x_i1( x1 ), .y_i1( y1 ), .theda_i1( theda1 ) );
    stage1 S1( .x_i( x1 ), .y_i( y1 ), .theda_i( theda1 ), .x_i1( x2 ), .y_i1( y2 ), .theda_i1( theda2 ) );
    stage2 S2( .x_i( x2 ), .y_i( y2 ), .theda_i( theda2 ), .x_i1( x3 ), .y_i1( y3 ), .theda_i1( theda3 ) );
    stage3 S3( .x_i( x3 ), .y_i( y3 ), .theda_i( theda3 ), .x_i1( x4 ), .y_i1( y4 ), .theda_i1( theda4 ) );
    stage4 S4( .x_i( x4 ), .y_i( y4 ), .theda_i( theda4 ), .x_i1( x5 ), .y_i1( outY_reg ), .theda_i1( outTheda_reg ) );
    shift_and_add SA( .scallingIN( x5 ), .scallingOUT( outX_reg ) );
endmodule
