`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO - CPE 333
// Engineer: Ryan Ceballos, Yexelle Nash Segovia, Carlos Vidal, Eduardo Gallegos
// 
// Create Date: 05/09/2024 08:34:50 PM
// Design Name: OTTER Pipelined Processor with Control Hazards
// Module Name: HazardUnit.sv
// Project Name: OTTER
//////////////////////////////////////////////////////////////////////////////////

module HazardUnit(
    input RegWriteM, RegWriteW, PCSrcE, ResultSrcE,
    input [4:0] RdM, RdW, RS1E, RS2E, RdE, Rs1D, Rs2D,
    output [1:0] ForwardAE, ForwardBE,
    output StallF, StallD, FlushD, FlushE // Bus Size???
    );

    logic lwStall; // BUS SIZE ???

    // Data Hazard Logic
    assign ForwardAE = (((RS1E == RdM) && RegWriteM) && RS1E != 5'b00000)  ? 2'b10 :
                       (((RS1E == RdW) && RegWriteW) && RS1E != 5'b00000) ? 2'b01 : 2'b00;

    assign ForwardBE = (((RS2E == RdM) && RegWriteM) && RS2E != 5'b00000) ? 2'b10 :
                       (((RS2E == RdW) && RegWriteW) && RS2E != 5'b00000) ? 2'b01 : 2'b00;

    // Load Word Stall Logic
    assign lwStall = ((Rs1D == RdE) || (Rs2D == RdE)) && ResultSrcE;
    assign StallF = lwStall;
    assign StallD = lwStall;
    assign StallF = lwStall;

    // Control Hazard Flush Logic
    assign FlushD = PCSrcE;
    assign FlushE = lwStall || PCSrcE; 

endmodule
