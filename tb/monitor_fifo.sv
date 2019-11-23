// monitor_fifo.v
// UVM monitors for fifo module 
// Nosherwan Ahmed
// 23 November 2019

import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_tx_monitor extends uvm_monitor;

    `uvm_component_utils(fifo_tx_monitor)
    
    // Class Variables
    virtual fifo_if tx_mon_if; 
    uvm_analysis_port #(fifo_seq_item) anlys_port;
    fifo_seq_item req;

    function new(string name = "fifo_tx_monitor", uvm_component parent = null);
        super.new(name, parent)
    endfunction //new()

    function void build_phase(uvm_phase phase);
        begin
            anlys_port = new("tx_mon_anlys_port",this)
        end
        
    endfunction //build_phase

    function void connect_phase(uvm_phase phase);
        //TODO: Needs to be updated when top level module is created
        if (!uvm_config_db #(virtual fifo_if)::get (this, "uvm_test_top", "fifo_if", this.tx_mon_if)) begin
			`uvm_error ("NOVIF", "Virtual Interface for FIFO not found!!")
		end
    endfunction //connect_phase

    task run_phase(uvm_phase phase);

        fork
            forever begin @(posedge tx_mon_if.clk)
                req = new()
                
                if (~ tx_mon_if.reset_n) begin
                    req.reset_n = tx_mon_if.reset_n;
                    req.data_in = tx_mon_if.data_in;
                end

                if (tx_mon_if.we == 1 && tx_mon_if.full != 1) begin
                    req.data_in = tx_mon_if.data_in;
                    req.we = tx_mon_if.we
                    req.full = tx_mon_if.full;
                    tx_mon_anlys_port.write(req)
                end
            end
        join_none
        
    endtask //run_phase

endclass //fifo_tx_monito extends uvm_monitor

class fifo_rx_monitor extends uvm_monitor;

    `uvm_component_utils(fifo_rx_monitor)
    
    // Class Variables
    virtual fifo_if rx_mon_if; 
    uvm_analysis_port #(fifo_seq_item) anlys_port;
    fifo_seq_item req;

    function new(string name = "fifo_rx_monitor", uvm_component parent = null);
        super.new(name, parent)
    endfunction //new()

    function void build_phase(uvm_phase phase);
        begin
            anlys_port = new("rx_mon_anlys_port",this)
        end
        
    endfunction //build_phase

    function void connect_phase(uvm_phase phase);
        //TODO: Needs to be updated when top level module is created
        if (!uvm_config_db #(virtual fifo_if)::get (this, "uvm_test_top", "fifo_if", this.rx_mon_if)) begin
			`uvm_error ("NOVIF", "Virtual Interface for FIFO not found!!")
		end
    endfunction //connect_phase

    task run_phase(uvm_phase phase);

        fork
            forever begin @(posedge rx_mon_if.clk)
                req = new()
                
                if (rx_mon_if.re == 1 && rx_mon_if.empty != 1) begin
                    req.data_out = rx_mon_if.data_out;
                    req.re = rx_mon_if.re
                    req.full = rx_mon_if.full;
                    req.empty = rx_mon_if.empty;
                    rx_mon_anlys_port.write(req)
                end
            end
        join_none
        
    endtask //run_phase

endclass //fifo_rx_monito extends uvm_monitor