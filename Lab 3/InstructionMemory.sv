`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 07:03:12 AM
// Design Name: 
// Module Name: InstructionMemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Logic found at verilogDetails.pdf pg. 5
// 
//////////////////////////////////////////////////////////////////////////////////


module InstructionMemory(
  input MEM_reset,
  input [31:0] A,
  output [31:0] RD
  );

    reg [31:0] mem [63:0];
  
    assign RD = mem[A[31:2]];

    initial begin
        $readmemh("Lab2.mem",mem);
    end
  
endmodule
