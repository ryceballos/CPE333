`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2024 04:04:19 PM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input CLK, DM_reset,
    input WE,
    input [31:0] A, WD, 
    output [31:0] RD
    );
    
    reg [31:0] mem [1023:0];

    always_ff@ (posedge CLK) begin
        if(WE)
            mem[A] <= WD;
    end

    assign RD = (~DM_reset) ? 32'd0 : mem[A];

    initial begin
        mem[0] = 32'h00000000;
        
    end
endmodule
