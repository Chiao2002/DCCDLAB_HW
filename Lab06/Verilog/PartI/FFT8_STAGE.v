`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/26 23:45:07
// Design Name: 
// Module Name: FFT8_STAGE
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


module FFT8_STAGE #(
    parameter STAGE=3,
    parameter ADDR_WIDTH=2,
    parameter W_WL=13,                         //wordlength of twiddle factor [S1.11]
    parameter DATA_IN_WL=12,                   //wordlength of input data [S0.11]
    parameter DATA_IN_IWL=1,                   //wordlength of integer part of input data
    parameter EXTN_WL=2,                       //number of extension bit
    parameter DATA_OUT_WL=DATA_IN_WL+EXTN_WL,  //wordlength of output data [S2.11]
    parameter DATA_OUT_IWL=DATA_IN_IWL+EXTN_WL //wordlength of integer part of output data
    )( 
    //slave interface
    input                   valid_s,           //valid input
    input  [DATA_IN_WL-1:0] data_s_r,          //real part of input
    input  [DATA_IN_WL-1:0] data_s_i,          //imag part of input
    input  [W_WL-1:0]       twiddle_r,         //real part of twiddle factor
    input  [W_WL-1:0]       twiddle_i,         //imag part of twiddle factor
    //master interface
    output                       valid_m,      //valid output
    output reg [DATA_OUT_WL-1:0] data_m_r,     //real part of output
    output reg [DATA_OUT_WL-1:0] data_m_i,     //imag part of output
    //
    input  [STAGE-1:0] ctrl,        //Control mode signal, bypass or butterfly mode
    input  [ADDR_WIDTH-1:0] addr,   //address of delay register
    input  multi_state,             //
    input  rst_n,                   //Active low reset
    input  clk                      //System clock
    );
    localparam REG_DEPTH=1<<(STAGE-1);
    localparam DELAY_NUM=1;
    integer i;
    wire signed [DATA_IN_WL-1:0]  upper_input_r;
    wire signed [DATA_IN_WL-1:0]  upper_input_i;
    wire signed [DATA_IN_WL-1:0]  lower_input_r;
    wire signed [DATA_IN_WL-1:0]  lower_input_i;
    wire signed [DATA_OUT_WL-1:0] upper_output_r;                //[S2.11]:sign extension after add/dif
    wire signed [DATA_OUT_WL-1:0] upper_output_i;
    wire signed [DATA_OUT_WL-1:0] lower_output_r;
    wire signed [DATA_OUT_WL-1:0] lower_output_i;
    wire signed [DATA_OUT_WL-1:0] multi_out_r;
    wire signed [DATA_OUT_WL-1:0] multi_out_i;
    reg  signed [DATA_IN_WL*2-1:0]  shift_reg [0:REG_DEPTH-1];   //shift delay registers DATA_IN_WL bits*2:due to concat {real, imag}
    reg  signed [DATA_OUT_WL*2-1:0] upper_o_reg [0:REG_DEPTH-1]; //DATA_OUT_WL bits*2:due to concat {real, imag}
    reg  signed [DATA_OUT_WL*2-1:0] lower_o_reg [0:DELAY_NUM];
    reg  valid_delay [0:DELAY_NUM];
    reg  [DELAY_NUM:0] SD;
    wire state;
    
    assign valid_m = valid_delay[DELAY_NUM];
    
    assign state = ctrl[STAGE-1];   //valid=0 :bypass; valid=1 :butterfly;
    assign lower_input_r = data_s_r;
    assign lower_input_i = data_s_i;
    assign upper_input_r = shift_reg[REG_DEPTH-1][DATA_IN_WL*2-1:DATA_IN_WL];
    assign upper_input_i = shift_reg[REG_DEPTH-1][DATA_IN_WL-1:0];
    
    //sign extened than do +/- operation 
    assign upper_output_r = {{EXTN_WL{upper_input_r[DATA_IN_WL-1]}}, upper_input_r}-{{EXTN_WL{lower_input_r[DATA_IN_WL-1]}}, lower_input_r};
    assign lower_output_r = {{EXTN_WL{upper_input_r[DATA_IN_WL-1]}}, upper_input_r}+{{EXTN_WL{lower_input_r[DATA_IN_WL-1]}}, lower_input_r};
    assign upper_output_i = {{EXTN_WL{upper_input_i[DATA_IN_WL-1]}}, upper_input_i}-{{EXTN_WL{lower_input_i[DATA_IN_WL-1]}}, lower_input_i};
    assign lower_output_i = {{EXTN_WL{upper_input_i[DATA_IN_WL-1]}}, upper_input_i}+{{EXTN_WL{lower_input_i[DATA_IN_WL-1]}}, lower_input_i};
    
    
    //assign the output with a pipeline
    always @(posedge clk or negedge rst_n)
        if(~rst_n) begin
            data_m_r <= 0;
            data_m_i <= 0;
        end
        else begin
            if(SD[DELAY_NUM-1]) begin
                data_m_r <= lower_o_reg[DELAY_NUM-1][DATA_OUT_WL*2-1:DATA_OUT_WL];
                data_m_i <= lower_o_reg[DELAY_NUM-1][DATA_OUT_WL-1:0];
            end
            else begin 
                data_m_r <= upper_o_reg[addr][DATA_OUT_WL*2-1:DATA_OUT_WL];
                data_m_i <= upper_o_reg[addr][DATA_OUT_WL-1:0];
            end
        end
    
    //shift delay N
    always @(posedge clk or negedge rst_n)
    if(~rst_n) begin
        //reset all register
        for(i=0; i<=STAGE; i=i+1)
            shift_reg[i] <= 0;
    end
    else begin
        if(valid_s) begin
            //shift delay
            shift_reg[0] <= {lower_input_r, lower_input_i};
            for(i=1; i<=STAGE; i=i+1)
                shift_reg[i] <= shift_reg[i-1];
        end
        else begin
            shift_reg[i] <= shift_reg[i];
        end
    end


    //register array:
    //After multiplying by the twiddle factor, the result is then stored in the register.
    always @(posedge clk or negedge rst_n)
        if(~rst_n) begin
            //reset all register
            for(i=0; i<=STAGE; i=i+1)
                upper_o_reg[i] <= 0;
        end
        else begin
            if(valid_s&SD[DELAY_NUM-1]&multi_state) begin
                //Upper_output*twiddle_factor
                upper_o_reg[addr] <= {multi_out_r, multi_out_i};
            end
            else begin
                upper_o_reg[addr] <= upper_o_reg[addr];
            end
        end
    
    /*
    Because the result of multiplication is stored into a pipeline,
    lower_output also needs to be delayed by a register 
    in order to align the uper_output.
    */
    always @(posedge clk or negedge rst_n)
        if(~rst_n) begin
            for(i=0; i<DELAY_NUM; i=i+1)
                lower_o_reg[i] <= 0;
        end
        else begin
            if(valid_s) begin
                lower_o_reg[0] <= {lower_output_r, lower_output_i};
                for(i=1; i<=DELAY_NUM; i=i+1)
                    lower_o_reg[i] <= lower_o_reg[i-1];
            end
            else begin
                lower_o_reg[i] <= lower_o_reg[i];
            end
        end
    
    always @(posedge clk or negedge rst_n)
        if(~rst_n) begin
            for(i=0; i<DELAY_NUM; i=i+1)
                valid_delay[i] <= 0;
        end
        else begin
            if(valid_s) begin
                valid_delay[0] <= valid_s;
                for(i=1; i<=DELAY_NUM; i=i+1)
                valid_delay[i] <= valid_delay[i-1];
            end
            else begin
                valid_delay[i] <= 0;
            end                
        end
    
    always @(posedge clk or negedge rst_n)
        if(~rst_n) begin
            for(i=0; i<DELAY_NUM; i=i+1)
                SD[i] <= 0;
        end
        else begin
            if(valid_s) begin
                SD[0] <= state;
                for(i=1; i<=DELAY_NUM; i=i+1)
                    SD[i] <= SD[i-1];
            end
            else begin
                SD[DELAY_NUM:0] <= 0;
            end
        end

    Multiplier_Complex #(.W_WL(W_WL), .DATA_WL(DATA_OUT_WL), .DATA_IWL(DATA_OUT_IWL), .WL(DATA_OUT_WL), .IWL(DATA_OUT_IWL))
    multi_complex (
        .data_s_r(upper_output_r), 
        .data_s_i(upper_output_i),
        .w_r(twiddle_r), 
        .w_i(twiddle_i),
        .data_m_r(multi_out_r), 
        .data_m_i(multi_out_i),
        .rst_n(rst_n),
        .clk(clk)
    );

endmodule
