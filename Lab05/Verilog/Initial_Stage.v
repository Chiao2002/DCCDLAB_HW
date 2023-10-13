`timescale 1ns / 1ps

module Initial_Stage(
    input  CLK, RSTN,
    input  Enable,
    input  [11:0] X, Y,      //S1.10
    output [11:0] X_init, Y_init, //S1.10
    output [13:0] Phase_out //S3.10
    );
    
    reg [11:0] X_reg, Y_reg;
    reg [13:0] Phase_reg;
    
    assign X_init = X_reg;
    assign Y_init = Y_reg;
    assign Phase_out = Phase_reg;
    
    always @(posedge CLK or negedge RSTN) begin
        if(~RSTN) begin
            X_reg <= 0;
            Y_reg <= 0;
            Phase_reg <= 0;
        end 
        else if(Enable) begin
            X_reg <= X[11]? -X:X;
            Y_reg <= X[11]? -Y:Y;
            Phase_reg <= X[11]? 3217:0;  //round(pi*2^(14-4))
        end    
    end
    
endmodule
