// scoreboard_fifo.v
// UVM scoreboard for fifo module 
// Nosherwan Ahmed
// 23 November 2019

import uvm_pkg::*;
`include "uvm_macros.svh"

class fifo_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(fifo_scoreboard)

    // Class Variables
    uvm_analysis_port #(fifo_seq_item) input_anlys_port;
    uvm_analysis_port #(fifo_seq_item) resp_anlys_port;

    fifo_seq_item req,resp;
    int count = 0;

    function new(string name = "fifo_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        begin
            input_anlys_port = new("input_anlys_port", this);
            resp_anlys_port = new("resp_anlys_port", this);
        end
    endfunction //build_phase()

    task run_phase(uvm_phase phase);
        fork
            forever begin
                input_anlys_port.get(req);
                resp_anlys_port.get(resp);

                if (req.we == 1 && req.full != 1) begin
                    count++;
                    `uvm_info("Write",$sformatf("Write: Count increased to %d",count),UVM_LOW)
                end
                `uvm_info("Information", $sformatf("Write Enable: %h Empty: %h",req.we,req.empty),UVM_MEDIUM)

                if (resp.re == 1 && resp.empty != 1) begin
                    count--;
                    `uvm_info("Write",$sformatf("Read: Count decreased to %d",count),UVM_LOW)
                end
                `uvm_info("Information", $sformatf("Write Enable: %h Empty: %h",req.we,req.empty),UVM_MEDIUM)
            end
        join_none
    endtask //run_phase()

endclass //fifo_scoreboard extends uvm_scoreboard