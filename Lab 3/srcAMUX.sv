`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO - CPE 333
// Engineer: Ryan Ceballos, Yexelle Nash Segovia, Carlos Vidal, Eduardo Gallegos
//
// Create Date: 02/24/2024 10:57:38 PM
// Design Name: OTTER Pipelined Processor with Control Hazards
// Module Name: srcAMUX
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module srcAMUX(
    input [1:0] ForwardAE,
    input [31:0] RD1E,
    input [31:0] ResultW,
    input [31:0] ALUResultM,
    output logic [31:0] SrcAE
    );
    
    always_comb begin
        case (ForwardAE)
            2'b00:
                SrcAE = RD1E;
            2'b01:
                SrcAE = ResultW;                //Forward from Writeback Stage
            2'b10:
                SrcAE = ALUResultM;             //Forward from Memory Stage
            default:
                SrcAE = 32'h0badbad0;
        endcase
   end
endmodule