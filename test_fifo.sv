`include "environment_fifo.sv"

class test_fifo extends uvm_test;
sequence_fifo sequence_1;
environment_fifo env;
  
`uvm_component_utils(test_fifo)

function new(string name = "test_fifo", uvm_component parent);
    super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequence_1 = sequence_fifo::type_id::create("sequence_1", this);
    env = environment_fifo::type_id::create("env", this);
endfunction

virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    sequence_1.start(env.agent_1.sequencer);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this, 100);
endtask
  
endclass
