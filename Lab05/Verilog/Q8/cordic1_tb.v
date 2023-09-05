`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/29 18:49:02
// Design Name: 
// Module Name: cordic1_tb
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


module cordic1_tb();
    reg clk;
    reg signed [11:0] x;
    reg signed [11:0] y;
    reg signed [11:0] theda;
    wire signed [11:0] x_out;
    wire signed [11:0] y_out;
    wire signed [11:0] theda_out;

    integer i;
    integer cnt;
    integer fp_r, fp_w;
    cordic1 C1( .x( x ), .y( y ), .theda( theda ), .x_out( x_out ), .y_out( y_out ), .theda_out( theda_out ) );
    
    always #20 clk = ~clk;
    initial begin
        clk = 0;
        // read file
//        i = 0;
        fp_r = $fopen("input_data.txt", "r");
        if(fp_r == 0) begin
            $display("File open is failed");
        end else begin
            while(!$feof(fp_r)) begin
                cnt = $fscanf(fp_r, "%d %d", x, y);
//                i = i + 1;
            end
            $fclose(fp_r);
            
        end
        
    end
    
endmodule
