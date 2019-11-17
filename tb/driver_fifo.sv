// driver_fifo.v
// UVM driver for fifo module 
// Nosherwan Ahmed
// 17 November 2019

import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_driver extends uvm_driver #(fifo_seq_item);

    `uvm_component_utils(fifo_driver)

    // Class Variables
    fifo_seq_item req, resp;
    virtual fifo_if driver_if;

    function new(string name = "fifo_driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    function void connect_phase(uvm_phase phase);
        //TODO: Needs to be updated when top level module is created
        if (!uvm_config_db #(virtual fifo_if)::get (this, "uvm_test_top", "fifoif", this.driver_if)) begin
			`uvm_error ("NOVIF", "Virtual Interface for FIFO not found!!")
		end
    endfunction //connect_phase

    task run_phase (uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);

            


            seq_item_port.item_done(); 
        end   
    endtask // run_phase

endclass //fifo_driver extends uvm_driver