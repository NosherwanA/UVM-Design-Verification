// fifo.v
// Generic FIFO implementation 
// Nosherwan Ahmed
// 4 November 2019

module FIFO(
    clk,                                        // Input Clock
    reset_n,                                    // Input Active Low Reset
    re,                                         // Input Read Enable
    we,                                         // Input Write Enable                
    data_in,                                    // Input Data     
    data_out,                                   // Output Data    
    full,                                       // Output Full Signal
    empty                                       // Output Empty Signal
);

    // Parameters
    parameter DATA_WIDTH = 32;                  // Data width for the FIFO
    parameter FIFO_DEPTH = 32;                  // Number of elements in the FIFO    
    
    // Input Ports
    input wire clk;                             // Clock input
    input wire reset_n;                         // Active low reset signal (Synchronous)
    input wire re;                              // Enable read operation to FIFO
    input wire we;                              // Enable write operation to FIFO
    input wire [DATA_WIDTH-1:0] data_in;        // Data input to FIFO            

    // Output Ports
    output reg [DATA_WIDTH-1:0] data_out;       // Data ouput from FIFO
    output wire full;                           // Signal indicating if FIFO is full
    output wire empty;                          // Signal indicating if FIFO is empty

    // Internal Declaration
    reg [DATA_WIDTH-1:0] fifo_mem [0:FIFO_DEPTH-1]; // To store the elements in the FIFO
    reg [FIFO_DEPTH-1:0] write_ptr;
    reg [FIFO_DEPTH-1:0] read_ptr;

    // Reset Logic
    always @(posedge clk) begin
        if (~ reset) begin
            write_ptr <= 0;
            read_ptr <= 0;
        end
    end

    // Write Logic
    always @(posedge clk) begin
        if (we) begin
            fifo_mem[write_ptr] <= data_in;
        end
    end




endmodule // FIFO