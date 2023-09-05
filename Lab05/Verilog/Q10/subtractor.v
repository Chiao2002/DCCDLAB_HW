`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2021 03:05:57 PM
// Design Name: 
// Module Name: subtractor
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


module subtractor( inA, inB, outC );
    input signed [11:0] inA;
    input signed [11:0] inB;
    output reg signed [11:0] outC;
    
    always@(inA or inB) begin
        outC <= inA - inB;
    end    
endmodule
