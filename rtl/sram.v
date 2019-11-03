// sram.v
// Basic memory model for synchronous SRAM 
// Nosherwan Ahmed
// 2 November 2019

module sram(
    clk,                                    // Input Clock
    addr,                                   // Input Address
    cs,                                     // Input Chip Select
    rwb,                                    // Input Read Write Bit
    data_i,                                 // Input Data
    data_o                                  // Output Data
);
    // Parameters
    parameter ADDR_WIDTH = 8;               // Address Bus Width
    parameter DATA_WIDTH = 32;              // Data Bus Width
    parameter DEPTH = 1 << ADDR_WIDTH;      // SRAM Depth

    // Input Ports
    input wire clk;                         // Clock
    input wire [ADDR_WIDTH-1:0] addr;       // Address
    input wire cs;                          // Chip Select
    input wire rwb;                         // Read Write Bit
    input wire [DATA_WIDTH-1:0] data_i;     // Input Data

    // Output Ports
    output reg [DATA_WIDTH-1:0] data_o;    // Output Data       


    // Memory Array
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1]; 

    always@(posedge clk)
    begin
        if (cs) begin
            if (rwb) begin
                mem[addr] <= data_i;
            end
            else begin
                data_o <= mem[addr];
            end
        end
    end
endmodule // sram