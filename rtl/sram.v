// sram.v
// Basic memory model for synchronous SRAM 
// Nosherwan Ahmed
// 2 November 2019

module sram(
    input wire clk,                         // Input Clock
    input wire [ADDR_WIDTH-1:0] addr,       // Input Address
    input wire rwb,                         // Input Read Write Bit
    inout wire [DATA_WIDTH-1:0] data        // Inout Data
);
    // Parameters
    parameter ADDR_WIDTH = 8;               // Address Bus Width
    parameter DATA_WIDTH = 32;              // Data Bus Width
    parameter DEPTH = 1 << ADDR_WIDTH;      // SRAM Depth

    // Memory Array
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1]; 

    always@(posedge clk)
    begin
        if (rwb) begin
            mem[addr] <= data;
        end
        else
            data <= mem[addr];
        end
    end
endmodule // sram