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


module cordic2_tb();
    reg clk;
    reg signed [11:0] x;
    reg signed [11:0] y;
    reg signed [11:0] theda;
    wire signed [11:0] x_out;
    wire signed [11:0] y_out;
    wire signed [11:0] theda_out;

    integer i, k;
    integer cnt;
    integer fp_r, fp_wX, fp_wY, fp_wTheda;
    reg signed [11:0] x_data [0:11];
    reg signed [11:0] y_data [0:11];
    reg signed [11:0] theda_data [0:11];
    
    cordic2 C2( .clk(clk), .x( x ), .y( y ), .theda( theda ), .x_out( x_out ), .y_out( y_out ), .theda_out( theda_out ) );
    
    always #20 clk = ~clk;
    initial begin
        clk = 1;
        
        #105;
        
        // read file
        i = 0;
        k=0;
        fp_r = $fopen("input_data.txt", "r");
        if(fp_r == 0) begin
            $display("File open is failed");
        end else begin
            while(!$feof(fp_r)) begin
                cnt = $fscanf(fp_r, "%d %d %d", x_data[i], y_data[i], theda_data[i]);
                i = i + 1;
            end
            $fclose(fp_r);
            // write file
            fp_wX = $fopen("Q10_output_x.txt", "w");
            fp_wY = $fopen("Q10_output_y.txt", "w");
            fp_wTheda = $fopen("Q10_output_theda.txt", "w");
        end
        
    end
    
    always@(posedge clk) begin
        x <= x_data[k];
        y <= y_data[k];
        theda <= theda_data[k];
        # 40 k <= k + 1;
    end
    
    always@(posedge clk) begin
        $fwrite(fp_wX, "%d\n", x_out);
        $fwrite(fp_wY, "%d\n", y_out);
        $fwrite(fp_wTheda, "%d\n", theda_out);
    end
    
endmodule
