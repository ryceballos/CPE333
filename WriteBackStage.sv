`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2024 04:28:09 PM
// Design Name: 
// Module Name: WriteBackStage
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


module WriteBackStage(
    input CLK,
    input RESET,
    input RegWriteM,
    input [1:0] ResultSrcW,
    input [4:0] RdW,
    input [31:0] PCPlus4W, ReadDataW, ALUResultW,
    output RegWriteW, 
    output [31:0] ResultW
    );
    
    //Declaring Wires   
        
    //Pipeline Registers 
    
    //Initialization of Modules
    
    //Pipeline Logic
    
    //Pipeline Registers to Output
    assign ResultW = (ResultSrcW == 2'b00) ? ALUResultW :
                     (ResultSrcW == 2'b01) ? ReadDataW : PCPlus4W;
    
endmodule
