// sequence_item_fifo.v
// UVM sequence items for fifo module 
// Nosherwan Ahmed
// 17 November 2019

class fifo_seq_item extends uvm_sequence_item;
    
    //Class Variables
    logic clk, reset_n;
    rand logic [`FIFO_DATA_WIDTH-1:0] data_in;
    logic [`FIFO_DATA_WIDTH-1:0] data_out;
    logic re, we;
    logic full, empty;

    function new(string name = "fifo_seq_item");
        super.new(name);
    endfunction //new()

    `uvm_object_utils_begin(fifo_seq_item)
        `uvm_field_int(clk, UVM_ALL_ON|UVM_NOCOMPARE)
        `uvm_field_int(reset_n, UVM_ALL_ON|UVM_NOCOMPARE)
        `uvm_field_int(re, UVM_ALL_ON|UVM_NOCOMPARE)
        `uvm_field_int(we, UVM_ALL_ON|UVM_NOCOMPARE)
        `uvm_field_int(data_in, UVM_ALL_ON|UVM_NOCOMPARE)
        `uvm_field_int(data_out, UVM_ALL_ON)
        `uvm_field_int(full, UVM_ALL_ON)
        `uvm_field_int(empty, UVM_ALL_ON)
    `uvm_object_utils_end
    
endclass //fifo_seq_item extends uvm_sequence_item
