`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO - CPE 333
// Engineer: Ryan Ceballos, Yexelle Nash Segovia, Carlos Vidal, Eduardo Gallegos
// 
// Create Date: 05/01/2024 04:28:09 PM
// Design Name: OTTER Pipelined Processor with Control Hazards
// Module Name: WriteBackStage
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////


module WriteBackStage(
    input CLK,
    input RESET,
    input RegWriteM,
    input [1:0] ResultSrcW,
    input [4:0] RdW,
    input [31:0] PCPlus4W, ReadDataW, ALUResultW,
    output RegWriteWH, RegWriteW, 
    output [4:0] RdWH,
    output [31:0] ResultW
    );
    
    //Declaring Wires   
        
    //Pipeline Registers 
    
    //Initialization of Modules
    
    //Pipeline Logic
    
    //Pipeline Registers to Output
    assign ResultW = (ResultSrcW == 2'b00) ? ALUResultW :
                     (ResultSrcW == 2'b01) ? ReadDataW : PCPlus4W;
    assign RdWH = RdW;
    assign RegWriteWH = RegWriteW;
    
endmodule
