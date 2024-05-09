`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly SLO
// Engineer: Ryan Ceballos
// 
// Create Date: 02/22/2024 02:03:57 AM
// Module Name: PC_Plus4
// Project Name: Program Counter
//////////////////////////////////////////////////////////////////////////////////


module PCPlus4(
    input [31:0] PC,
    output logic [31:0] PCPlus
    );
    
    assign PCPlus = PC + 4;
    
endmodule

