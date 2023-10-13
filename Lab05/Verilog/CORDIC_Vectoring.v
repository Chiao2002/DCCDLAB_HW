`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/12 20:40:54
// Design Name: 
// Module Name: CORDIC_Vectoring
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


module CORDIC_Vectoring(
    input  CLK, RSTN,
    input  Enable,
    input  [11:0] X, Y,
    output [11:0] Amplitude,
    output [13:0] Phase
    );
    parameter iteration=9;
    wire signed [11:0] X_i [0:9], Y_i [0:9];
    wire [13:0] Phase_i [0:9];
    
    /*Scaling Factor*/
    //CSD:0.6074=2^(-1)+2^(-3)-2^(-6)-2^(-9)
    assign Amplitude = (X_i[iteration]>>>1)+(X_i[iteration]>>>3)-(X_i[iteration]>>>6)-(X_i[iteration]>>>9);
    assign Phase = Phase_i[iteration];
    
    Initial_Stage
    Init_S (
        .CLK(CLK), .RSTN(RSTN),
        .Enable(Enable),
        .X(X), 
        .Y(Y),
        .X_init(X_i[0]), 
        .Y_init(Y_i[0]),
        .Phase_out(Phase_i[0])
    );

    genvar i;
    generate
    for(i=0; i<iteration; i=i+1) begin
        Iteration_Stage #(.stage_no(i))
        Iter_S (
            .CLK(CLK), .RSTN(RSTN),
            .Enable(Enable),
            .X(X_i[i]), 
            .Y(Y_i[i]),
            .Phase_in(Phase_i[i]),
            .X_i(X_i[i+1]), 
            .Y_i(Y_i[i+1]),
            .Phase_out(Phase_i[i+1])
        );
    end
    endgenerate
    
endmodule
