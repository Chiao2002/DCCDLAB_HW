`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/10 13:25:53
// Design Name: 
// Module Name: fft_8_sdf_tb
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


module fft_8_sdf_tb();

    reg clk;
    reg rst;
    reg signed [12:0] in_real;
    reg signed [12:0] in_imag;
    wire signed [15:0] out_real;
    wire signed [15:0] out_imag;

    reg signed [12:0] data_real [0:3];
    reg signed [12:0] data_imag [0:3];
    
    reg signed [12:0] in_data_real [0:15];
    reg signed [12:0] in_data_imag [0:15];
    
    
    integer k;
    integer i;
    integer cnt, cnt2;
    integer fp_r1, fp_w_in_real, fp_w_in_imag, fp_w_out_real, fp_w_out_imag;
    
    fft_8_sdf top( .clk(clk),
                   .rst(rst),
                   .in_real(in_real),
                   .in_imag(in_imag),
                   .stage3_out_real(out_real),
                   .stage3_out_imag(out_imag) );

    
    always #15 clk = ~clk;

    initial begin
        clk = 1;
        rst = 0;
        #110;
        #10 rst = 1;
        #5 rst = 0;  
        
        // read file
        i = 0;
        k=0;
        fp_r1 = $fopen("test.txt", "r");
        if( fp_r1 == 0 ) begin
            $display("File open is failed");
        end else begin
            while(!$feof(fp_r1)) begin
                cnt = $fscanf(fp_r1, "%d %d", in_data_real[i], in_data_imag[i]);
                i = i + 1;
            end
            $fclose(fp_r1);
            // write file
            fp_w_in_real = $fopen("in_real.txt", "w");
            fp_w_in_imag = $fopen("in_imag.txt", "w");
            fp_w_out_real = $fopen("output_real.txt", "w");
            fp_w_out_imag = $fopen("output_imag.txt", "w");
        end
        
    end
 
    always@(posedge clk or posedge rst) begin
        if (rst) begin
            #1;
            in_real <= 0;
            in_imag <= 0;
            k <= 0;
        end else begin
            #1;
            in_real <= in_data_real[k];
            in_imag <= in_data_imag[k];
            k <= k + 1;
        end
    end
    
    always@(posedge clk or posedge rst) begin
        $fwrite(fp_w_out_real, "%d\n", out_real);
        $fwrite(fp_w_out_imag, "%d\n", out_imag);
    end
    
endmodule
