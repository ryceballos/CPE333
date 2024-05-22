`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO - CPE 333
// Engineer: Ryan Ceballos, Yexelle Nash Segovia, Carlos Vidal, Eduardo Gallegos
//
// Create Date: 02/24/2024 10:57:38 PM
// Design Name: OTTER Pipelined Processor with Control Hazards
// Module Name: srcBMUX1
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module srcBMUX(
    input [1:0] ForwardBE,
    input [31:0] RD2E,
    input [31:0] ResultW,
    input [31:0] ALUResultM,
    output logic [31:0] WriteDataE
    );
    
    always_comb begin
        case (ForwardBE)
            2'b00:
                WriteDataE = RD2E;
            2'b01:
                WriteDataE = ResultW;               //Forward from Writeback Stage
            2'b10:
                WriteDataE = ALUResultM;            //Forward from Memory Stage
            default:
                WriteDataE = 32'h0badbad0;
        endcase
   end
endmodule
