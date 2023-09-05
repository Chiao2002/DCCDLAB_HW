`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/29 23:25:29
// Design Name: 
// Module Name: stage3
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


module stage3( x_i, y_i, theda_i, x_i1, y_i1, theda_i1 );
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
    assign x_i1 = (y_i[11]==0)? x_i + y_shift : x_i - y_shift;
    assign y_i1 = (y_i[11]==0)? -x_shift + y_i : x_shift + y_i;
    assign x_shift = x_i >>> 3;
    assign y_shift = y_i >>> 3;
    
    // phase accumulation
    assign theda_i1 = (y_i[11]==0)? theda_i + 12'd127 :  theda_i - 12'd127;
    
endmodule
