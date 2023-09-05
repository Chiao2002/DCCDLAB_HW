`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/17 16:48:52
// Design Name: 
// Module Name: parabolicINTERPOLATOR_tb
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


module parabolicINTERPOLATOR_tb();
    reg clk, rst;
//    wire enable;
    reg signed [12:0] input_x [0:43];
    reg signed [12:0] in ;
    wire [12:0] mu;
    wire signed [12:0] output_y;
    
    integer fp_r, fp_w;
    integer cnt, i, k;
    integer count_mu;
    
    parabolicINTERPOLATOR P1( 
                            .clk(clk),
                            .rst(rst),
                            .output_y(output_y),
                            .input_x(in),
                            .mu(mu)
                            );
    
    always #15 clk = ~clk;
    
    
    initial begin
        clk = 0;
        rst = 0;
        
        #105 rst = 1; in = input_x[3];
        #15  rst=0; //enable = 1;
        #165 in = input_x[4];
        for(k=5; k<44; k=k+1) begin
            #180 in = input_x[k];
        end
     end
     initial begin   
        // read file
        i = 0;
        fp_r = $fopen("input_x.txt", "r");
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
        #8000  $finish;
    end
    
    
    always@(posedge clk or posedge rst) begin
       if(rst == 1)
	       count_mu <= 0;
	   else if (count_mu == 5)
	       count_mu <= 0;
	   else
	       count_mu <= count_mu + 1;
    end
    
    assign mu = (count_mu == 0)? 0 : (count_mu == 1)? 341 : (count_mu == 2)? 682 : (count_mu == 3)? 1024 : (count_mu == 4)? 1365 : 1706;
    
    always@( posedge clk or posedge rst ) begin
            $fwrite(fp_w, "%d\n", output_y);
    end
    
endmodule
