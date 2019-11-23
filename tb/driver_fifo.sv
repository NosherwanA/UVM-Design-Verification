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

        driver_if.reset_n <= 1;
        fork
            forever begin
                seq_item_port.get_next_item(req);

                case(req.command)

                    Reset: begin
                        // Pull reset signal down for 3 clk cycles and release the reset
                        #1
                        driver_if.re <= 0;
                        driver_if.we <= 0;
                        driver_if.reset_n <= req.reset_n;
                        repeat(3) @(posedge driver_if.clk) #1;
                        driver_if.reset_n <= 1;
                        @(posedge driver_if.clk) #1 
                    end
                    Write: begin
                        // Writing Data to Fifo
                        driver_if.we <= req.we;
                        driver_if.data_in <= req.data_in;
                        @(posedge driver_if.clk) #1;
                        driver_if.we <= 0;
                    end
                    Read: begin
                        // Reading Data from Fifo
                        driver_if.re <= req.re;
                        @(posedge driver_if.clk) #1;
                        driver_if.re <= 0;
                    end
                    Full: begin
                        // Checking if the full signal from fifo is asserted
                        if (driver_if.full !== req.full) begin
                            resp = new();               // Returning the actual state of full signal of fifo
                            resp.full <= driver_if.full;
                            resp.timestamp = $realtime; 
                        end
                    end
                    Empty: begin
                        // Checking if the empty signal from fifo is asserted
                        if (driver_if.empty !== req.empty) begin
                            resp = new();               // Returning the actual state of empty signal of fifo
                            resp.empty <= driver_if.empty;
                            resp.timestamp = $realtime; 
                        end
                    end

                endcase

                seq_item_port.item_done(); 
            end   
        join
        
    endtask // run_phase

endclass //fifo_driver extends uvm_driver