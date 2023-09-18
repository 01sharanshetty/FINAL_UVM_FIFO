class sequencer_fifo extends uvm_sequencer#(transactions_fifo);
  `uvm_component_utils(sequencer_fifo)
  
  function new(string name = "sequencer_fifo", uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass 
