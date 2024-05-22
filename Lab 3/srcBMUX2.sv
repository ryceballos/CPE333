`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO - CPE 333
// Engineer: Ryan Ceballos, Yexelle Nash Segovia, Carlos Vidal, Eduardo Gallegos
// 
// Create Date: 02/24/2024 10:57:38 PM
// Design Name: OTTER Pipelined Processor with Control Hazards
// Module Name: srcBMUX2
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module srcBMUX2(
    input ALUSrcE,
    input [31:0] Zero,
    input [31:0] One,
    output logic [31:0] ALU_srcB
    );
    
    always_comb begin
        case (ALUSrcE)
            1'b0:
                ALU_srcB = Zero;
            1'b1:
                ALU_srcB = One;
            default:
                ALU_srcB = 32'h0badbad0;
        endcase
   end
endmodule
