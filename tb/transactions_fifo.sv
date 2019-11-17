// transactions_fifo.v
// UVM sequence items for fifo module 
// Nosherwan Ahmed
// 17 November 2019

class fifo_data_transaction extends uvm_sequence_item;

    rand logic [`FIFO_DATA_WIDTH-1:0] data;
    rand logic re;
    rand logic we;

    function new(string name = "fifo_data_transaction");
        super.new(name);
    endfunction //new()

    `uvm_object_utils_begin(fifo_data_transaction)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(re, UVM_ALL_ON)
        `uvm_field_int(we, UVM_ALL_ON)
    `uvm_object_utils_end

endclass //fifo_data_transaction extends uvm_sequence_item

class fifo_reset_transaction extends uvm_sequence_item;

    logic reset_n;

    function new(string name = "fifo_reset_transaction");
        super.new(name);
    endfunction //new()
    `uvm_object_utils_begin(fifo_data_transaction)
        `uvm_field_int(reset_n, UVM_ALL_ON)
    `uvm_object_utils_end

endclass //fifo_reset_transaction extends uvm_sequence_item
