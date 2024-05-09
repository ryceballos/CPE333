`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2024 09:00:20 PM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(
    input PC_reset,
    //input PC_WE,
    input [31:0] PC_IN,
    input CLK,
    output logic [31:0] PC_OUT
    );
    
    always_ff@ (posedge CLK) begin
        if (PC_reset) begin             //To reset the current value back to 0
            PC_OUT <= 0;
        end else begin                  //Output the current value
            PC_OUT <= PC_IN;
        end
    end
endmodule