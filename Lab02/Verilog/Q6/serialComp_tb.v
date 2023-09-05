`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/17 15:49:27
// Design Name: 
// Module Name: serialComp_tb
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


module serialComp_tb();
    reg clock, reset;
    reg signed [10:0] data_in;
    wire [10:0] min;
    wire signed[5:0] min_value;
    wire [4:0] index;
    assign min_value = min[10:5];
    assign index = min[4:0];
//    reg [4:0] i;
//    reg [4:0] dataIndex;
//    integer fp_r, status;

    serialComp sc(.clk(clock), .rstn(reset), .data_in(data_in), .sc_out(min));
    initial begin
        clock = 0;
        reset = 0;
        /*  Read file */
//        i = 0;
//        fp_r = $fopen("dataIn.txt","r");
//        while(!$feof(fp_r)) begin
//            status = $fscanf(fp_r, "%d %d\n", data_in[i][10:5], data_in[i][4:0]);
//            i = i + 1;
//        end
//        $fclose(fp_r);
        
        #105; reset = 1;#5;reset=0;@(negedge clock);
        
        data_in[10:5] = 6'd4; data_in[4:0] = 5'd1;#40
        data_in[10:5] = -6'd2; data_in[4:0] = 5'd2;#40
        data_in[10:5] = -6'd32; data_in[4:0] = 5'd3;#40
        data_in[10:5] = -6'd11; data_in[4:0] = 5'd4;#40
        data_in[10:5] = -6'd22; data_in[4:0] = 5'd5;#40
        data_in[10:5] = 6'd18; data_in[4:0] = 5'd6;#40
        data_in[10:5] = -6'd13; data_in[4:0] = 5'd7;#40
        data_in[10:5] = 6'd1; data_in[4:0] = 5'd8;#40
        data_in[10:5] = -6'd22; data_in[4:0] = 5'd9;#40
        data_in[10:5] = 6'd6; data_in[4:0] = 5'd10;#40
        data_in[10:5] = -6'd16; data_in[4:0] = 5'd11;#40
        data_in[10:5] = 6'd9; data_in[4:0] = 5'd12;#40
        data_in[10:5] = 6'd12; data_in[4:0] = 5'd13;#40
        data_in[10:5] = 6'd15; data_in[4:0] = 5'd14;#40
        data_in[10:5] = -6'd4; data_in[4:0] = 5'd15;#40
        data_in[10:5] = -6'd27; data_in[4:0] = 5'd16;#40
        data_in[10:5] = -6'd18; data_in[4:0] = 5'd17;#40
        data_in[10:5] = 6'd26; data_in[4:0] = 5'd18;#40
        data_in[10:5] = -6'd23; data_in[4:0] = 5'd19;#40
        data_in[10:5] = 6'd20; data_in[4:0] = 5'd20;#40
        data_in[10:5] = 6'd2; data_in[4:0] = 5'd21;#40
        data_in[10:5] = 6'd31; data_in[4:0] = 5'd22;#40
        data_in[10:5] = -6'd27; data_in[4:0] = 5'd23;#40
        data_in[10:5] = -6'd4; data_in[4:0] = 5'd24;#40
        

        #40 reset = 0;
//           enable = 1;
        #1500 $stop;
    end
    always #20 clock = ~clock;   
    /*  
    always@(posedge clock or posedge reset) begin
        if (reset == 1) begin
            dataIndex <= 5'b0_0000;
        end else if (enable == 1) begin
            dataIndex <= dataIndex + 1;
        end else begin
            dataIndex <= 0;
        end
    end*/
    
endmodule
