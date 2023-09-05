`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/02 15:26:52
// Design Name: 
// Module Name: transposed_form_tb
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


module transposed_form_tb();
    reg clk, rst;
    reg enable;
    reg signed [18:0] input_x [0:124];
    wire signed [19:0] output_y;
    
    integer fp_r, fp_w;
    integer cnt, i;
    integer count;
    
    transposed_form T1( .clk(clk), .rst(rst), .input_x(input_x[count]), .output_y(output_y) );
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 0;
        rst = 0;
        enable = 0;
        
        #90; rst = 1; #15; rst=0;
        // read file
        i = 0;
        fp_r = $fopen("trans_input_x.txt", "r");
        if(fp_r == 0) begin
            $display("file open is failed");
        end else begin
            while(!$feof(fp_r)) begin
                cnt = $fscanf(fp_r, "%d", input_x[i]);
                i = i + 1;
            end
            $fclose(fp_r);   
            fp_w = $fopen("output_y.txt", "w");                    
        end
                
//        #10 rst = 1;
//        #5 rst = 0;
        #30  enable = 1;
        #2500  $finish;
    end
    
    always@(posedge clk or posedge rst) begin
       if(rst == 1) begin
	       count <= 0;
	   end else
	       #10 count <= count + 1;     
    end
         
    always@( posedge clk ) begin
        if( enable == 1 )
            $fwrite(fp_w, "%d\n", output_y);
    end
endmodule
