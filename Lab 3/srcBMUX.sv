`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 10:57:38 PM
// Design Name: 
// Module Name: srcBMUX
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


module srcBMUX(
    input srcB_SEL,                             //Originally 3 bits now 1
    input [31:0] Zero,
    input [31:0] One,
    input [31:0] Two,
    input [31:0] Three,
    output logic [31:0] ALU_srcB
    );
    
    always_comb begin
        case (srcB_SEL)
            1'b0:
                ALU_srcB = Zero;
            1'b1:
                ALU_srcB = One;
            /*3'b010:
                ALU_srcB = Two;
            3'b011:
                ALU_srcB = Three;*/
            default:
                ALU_srcB = 32'h0badbad0;
        endcase
   end
endmodule