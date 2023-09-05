`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2021 03:34:40 PM
// Design Name: 
// Module Name: stage
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


module stage0( x_i, y_i, theda_i, x_i1, y_i1, theda_i1 );
    input signed [11:0] x_i;
    input signed [11:0] y_i;
    input signed [11:0] theda_i;
    output signed [11:0] x_i1;
    output signed [11:0] y_i1;
    output signed [11:0] theda_i1;
    
    wire signed [11:0] x_i1, y_i1;
    wire signed [11:0] theda_i1;
    wire signed [11:0] x_shift;
    wire signed [11:0] y_shift;
    
    // micro-rotation
    // if y == '+', mu = -1; if y == '-', mu = 1;
    assign x_i1 = (y_i[11]==0)? x_i + y_i : x_i - y_i;
    assign y_i1 = (y_i[11]==0)? -x_i + y_i : x_i + y_i;
//    assign x_shift = x_i >>> 1;
//    assign y_shift = y_i >>> 1;
    
    // phase accumulation
    assign theda_i1 = (y_i[11]==0)? theda_i + 12'd804 :  theda_i - 12'd804;
    
endmodule
