`include "agent_fifo.sv"
`include "scoreboard_fifo.sv"



class environment_fifo extends uvm_env;
  agent_fifo agent_1;
  scoreboard_fifo score_b;
  `uvm_component_utils(environment_fifo)
  
function new(string name = "environment_fifo", uvm_component parent);
    super.new(name, parent);
endfunction
   
virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_1 = agent_fifo::type_id::create("agent_1", this);
    score_b = scoreboard_fifo::type_id::create("score_b", this);   
endfunction
  
virtual function void connect_phase(uvm_phase phase); 
   agent_1.monitor.analysis_p.connect(score_b.analysis_p);
endfunction
  

endclass
