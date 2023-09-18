`include "transactions_fifo.sv"
`include "driver_fifo.sv"
`include "sequencer_fifo.sv"
`include "monitor_fifo.sv"
`include "sequence_fifo.sv"

class agent_fifo extends uvm_agent;
  sequencer_fifo sequencer;
  driver_fifo driver;
  monitor_fifo monitor;
  `uvm_component_utils(agent_fifo)
  
function new(string name = "agent_fifo", uvm_component parent);
    super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      sequencer = sequencer_fifo::type_id::create("sequencer", this);
      driver = driver_fifo::type_id::create("driver", this);
    end
      monitor = monitor_fifo::type_id::create("monitor", this);
endfunction
  
virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction
    
endclass
