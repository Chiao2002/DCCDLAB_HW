`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2021 09:52:20 PM
// Design Name: 
// Module Name: pip
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


module pip( counter, addr, ping_wrt, pong_wrt, ping_rd, pong_rd );
    
    input [6:0] counter;
    output addr;
    output ping_wrt, pong_wrt;
    output ping_rd, pong_rd;

    reg [4:0] addr;
    reg ping_wrt, pong_wrt;
    reg ping_rd, pong_rd;
    
    
    always@(*) begin
        case(counter)
            7'd43:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 0;
            end
            7'd44:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 0;
            end
            7'd45:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 8;
            end
            7'd46:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 8;
            end
            7'd47:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 4;
            end
            7'd48:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 4;
            end
            7'd49:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 12;
            end
            7'd50:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 12;
            end
            7'd51:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 2;
            end
            7'd52:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 2;
            end
            7'd53:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 10;
            end
            7'd54:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 10;
            end
            7'd55:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 6;
            end
            7'd56:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 6;
            end
            7'd57:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 14;
            end
            7'd58:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 14;
            end
            7'd59:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 1;
            end
            7'd60:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 1;
            end
            7'd61:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 9;
            end
            7'd62:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 9;
            end
            7'd63:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 5;
            end
            7'd64:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 5;
            end
            7'd65:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 13;
            end
            7'd66:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 13;
            end
            7'd67:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 3;
            end
            7'd68:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 3;
            end
            7'd69:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 11;
            end
            7'd70:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 11;
            end
            7'd71:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 7;
            end
            7'd72:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 7;
            end
            7'd73:begin
                ping_wrt = 1;
                pong_wrt = 0;
                addr = 15;
            end
            7'd74:begin
                ping_wrt = 0;
                pong_wrt = 1;
                addr = 15;
            end
            // ping read
            7'd75:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd76:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd77:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd78:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd79:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd80:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd81:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd82:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd83:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd84:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd85:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd86:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd87:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd88:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd89:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            7'd90:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 1;
                pong_rd = 0;
            end
            // pong read
            7'd91:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd92:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd93:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd94:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd95:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd96:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd97:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd98:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd99:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd100:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd101:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd102:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd103:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd104:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd105:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            7'd106:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 1;
            end
            
//            7'd44:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 0;
//            end
//            7'd45:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 0;
//            end
//            7'd46:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 8;
//            end
//            7'd47:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 8;
//            end
//            7'd48:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 4;
//            end
//            7'd49:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 4;
//            end
//            7'd50:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 12;
//            end
//            7'd51:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 12;
//            end
//            7'd52:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 2;
//            end
//            7'd53:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 2;
//            end
//            7'd54:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 10;
//            end
//            7'd55:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 10;
//            end
//            7'd56:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 6;
//            end
//            7'd57:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 6;
//            end
//            7'd58:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 14;
//            end
//            7'd59:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 14;
//            end
//            7'd60:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 1;
//            end
//            7'd61:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 1;
//            end
//            7'd62:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 9;
//            end
//            7'd63:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 9;
//            end
//            7'd64:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 5;
//            end
//            7'd65:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 5;
//            end
//            7'd66:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 13;
//            end
//            7'd67:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 13;
//            end
//            7'd68:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 3;
//            end
//            7'd69:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 3;
//            end
//            7'd70:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 11;
//            end
//            7'd71:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 11;
//            end
//            7'd72:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 7;
//            end
//            7'd73:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 7;
//            end
//            7'd74:begin
//                ping_wrt = 1;
//                pong_wrt = 0;
//                addr = 15;
//            end
//            7'd75:begin
//                ping_wrt = 0;
//                pong_wrt = 1;
//                addr = 15;
//            end
//            // ping read
//            7'd76:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd77:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd78:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd79:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd80:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd81:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd82:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd83:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd84:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd85:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd86:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd87:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd88:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd89:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd90:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            7'd91:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 1;
//                pong_rd = 0;
//            end
//            // pong read
//            7'd92:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd93:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd94:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd95:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd96:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd97:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd98:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd99:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd100:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd101:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd102:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd103:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd104:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd105:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd106:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
//            7'd107:begin
//                ping_wrt = 0;
//                pong_wrt = 0;
//                ping_rd = 0;
//                pong_rd = 1;
//            end
            
            default:begin
                ping_wrt = 0;
                pong_wrt = 0;
                ping_rd = 0;
                pong_rd = 0;
            end
            
        endcase
    end
    

endmodule
