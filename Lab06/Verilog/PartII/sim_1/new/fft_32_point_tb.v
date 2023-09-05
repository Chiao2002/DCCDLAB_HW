`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 11:09:10 AM
// Design Name: 
// Module Name: fft_32_point_tb
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


module fft_32_point_tb();
    reg clk;
    reg rst;
    reg cnt_en;
    reg signed [11:0] in_real;   // 12 bits input
    reg signed [11:0] in_imag;
    wire signed [16:0] out_real; // 17 bits output after S5
    wire signed [16:0] out_imag;
    
    reg signed [11:0] in_data_real [0:64];
    reg signed [11:0] in_data_imag [0:64];
    
    
    integer k;
    integer i;
    integer cnt;
    integer fp_r, fp_w_out_real, fp_w_out_imag;
    
    fft_32_point
    TOP (
             .clk(clk),
             .rst(rst),
             .cnt_en(cnt_en),
             .in_real(in_real),
             .in_imag(in_imag),
             .out_real(out_real),
             .out_imag(out_imag)
             );

    
    always #10 clk = ~clk;

    initial begin
        clk = 1;
        rst = 0;
        cnt_en = 0;
        #110;
        #10 rst = 1;
        #5  rst = 0;
        #10 cnt_en = 1; 
        
        // read file
        i = 0;
        k=0;
        fp_r = $fopen("inData.txt", "r");
        if( fp_r == 0 ) begin
            $display("File open is failed");
        end else begin
            while(!$feof(fp_r)) begin
                cnt = $fscanf(fp_r, "%d %d", in_data_real[i], in_data_imag[i]);
                i = i + 1;
            end
            $fclose(fp_r);
            // write file
            fp_w_out_real = $fopen("output_real.txt", "w");
            fp_w_out_imag = $fopen("output_imag.txt", "w");
        end

        #2400 $finish;
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
