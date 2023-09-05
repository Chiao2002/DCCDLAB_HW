`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2021 02:19:47 PM
// Design Name: 
// Module Name: adder
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


module adder( inA, inB, outC );
    input signed [11:0] inA;
    input signed [11:0] inB;
    output reg signed [11:0] outC;
    
    always@(inA or inB) begin
        outC <= inA + inB;
    end    
endmodule
