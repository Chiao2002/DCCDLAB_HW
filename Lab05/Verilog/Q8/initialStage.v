`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2021 02:34:27 PM
// Design Name: 
// Module Name: initialStage
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


module initialStage( x, y, theda, x0, y0, theda0 );
    input signed [11:0] x;
    input signed [11:0] y;
    input signed [11:0] theda;
    output signed [11:0] x0;
    output signed [11:0] y0;
    output signed [11:0] theda0;
    
    wire signed [11:0] x, y, theda;
    wire signed [11:0] x0, y0, theda0;
    
    assign x0 = (x[11]==1)? -x : x;
    assign y0 = y;
    assign theda0 = theda;
endmodule
