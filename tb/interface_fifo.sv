// interface_fifo.v
// Interface for fifo module 
// Nosherwan Ahmed
// 17 November 2019

interface fifo_if;
    logic clk, reset_n, re, we, full, empty;
    logic [`FIFO_DATA_WIDTH-1:0] data_in, data_out;
endinterface //fifo_if
