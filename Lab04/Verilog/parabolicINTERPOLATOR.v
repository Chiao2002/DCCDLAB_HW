`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 16:48:25
// Design Name: 
// Module Name: parabolicINTERPOLATOR
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


module parabolicINTERPOLATOR(
    clk, 
    rst, 
    output_y,
    input_x,
    mu
    );
    input clk, rst;
    output signed [12:0] output_y;
    input signed [12:0] input_x;
    input signed [12:0] mu;
    
    wire enable;
    wire signed [12:0] output_y;
    reg signed [12:0] output_y_ans;
    reg signed [12:0] v2_reg [0:3];
    reg signed [12:0] v1_reg [0:3];
    reg signed [12:0] v0_reg [0:3];

    wire signed [12:0] v2_alpha1,
                       v2_alpha2,
                       v2_alpha3,
                       v2_alpha4;
    wire signed [12:0] v1_alpha1,
                       v1_alpha2,
                       v1_alpha3,
                       v1_alpha4,
                       v1_alpha5;
    wire signed [12:0] v0_alpha1,
                       v0_alpha2,
                       v0_alpha3,
                       v0_alpha4;
    wire signed [12:0] v2_out;
    wire signed [12:0] v1_out;
    wire signed [12:0] v0_out;
    wire signed [25:0] w11, w33;
    wire signed [12:0] w1, w2, w3;
    integer count;
    
    //  v(2)
    assign v2_alpha1 = v2_reg[3]>>>1;
    assign v2_alpha2 = v2_reg[2]>>>1;
    assign v2_alpha3 = v2_reg[1]>>>1;
    assign v2_alpha4 = v2_reg[0]>>>1;    
    assign v2_out = v2_alpha1 - v2_alpha2 - v2_alpha3 + v2_alpha4;
    
    //  v(1)
    assign v1_alpha1 = v1_reg[3]>>>1;   
    assign v1_alpha5 = v1_reg[2]>>>1;
    assign v1_alpha2 = v1_alpha5 + v1_reg[2];
    assign v1_alpha3 = v1_reg[1]>>>1;
    assign v1_alpha4 = v1_reg[0]>>>1;
    assign v1_out =  v1_alpha2 - v1_alpha1  - v1_alpha3 - v1_alpha4;
      
    //  v(0)
    assign v0_out = v0_reg[1];
    
    assign w11 = v2_out * mu;
    assign w1 = w11[23:11];
    assign w2 = v1_out + w1;
    assign w33 = w2 * mu;
    assign w3 = w33[23:11];
 
    always@(posedge clk or posedge rst) begin
       if(rst == 1)
            output_y_ans <= 0;
       else
            output_y_ans = w3 + v0_out;
    end
    assign output_y = output_y_ans;
    
    always@(posedge clk or posedge rst) begin
       if(rst == 1)
	       count <= 0;
	   else if (count == 6)
	       count <= 1;
	   else
	       count <= count + 1;
    end
    assign enable = (count == 5)? 1:0;
    
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            v2_reg[0] <= -321;
            v2_reg[1] <= -1657;
            v2_reg[2] <= -2023;
            v2_reg[3] <= input_x;          
            v1_reg[0] <= -321;
            v1_reg[1] <= -1657;
            v1_reg[2] <= -2023;
            v1_reg[3] <= input_x;
            v0_reg[0] <= -321;
            v0_reg[1] <= -1657;
            v0_reg[2] <= -2023;
            v0_reg[3] <= input_x;          
        end else if (enable == 1) begin
            v2_reg[0] <= v2_reg[1];
            v2_reg[1] <= v2_reg[2];
            v2_reg[2] <= v2_reg[3];
            v2_reg[3] <= input_x;
            v1_reg[0] <= v1_reg[1];
            v1_reg[1] <= v1_reg[2];
            v1_reg[2] <= v1_reg[3];
            v1_reg[3] <= input_x;
            v0_reg[0] <= v0_reg[1];
            v0_reg[1] <= v0_reg[2];
            v0_reg[2] <= v0_reg[3];
            v0_reg[3] <= input_x;            
        end 
    end

endmodule
