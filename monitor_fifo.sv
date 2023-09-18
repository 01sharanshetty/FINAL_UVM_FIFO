class monitor_fifo extends uvm_monitor; 
  virtual interface_fifo vif;
  transactions_fifo fsi_1;
  uvm_analysis_port#(transactions_fifo) analysis_p;
  `uvm_component_utils(monitor_fifo)
  
  function new(string name = "monitor_fifo", uvm_component parent);
    super.new(name, parent);
     analysis_p = new("analysis_port", this);
  endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     fsi_1 = transactions_fifo::type_id::create("fsi_1");
      if(!uvm_config_db#(virtual interface_fifo)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction

   virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.mp_monitor.clk)
      if(vif.mp_monitor.clk_b_monitor.i_wren == 1 && vif.mp_monitor.clk_b_monitor.i_rden == 0)begin
        $display("\nInput Monitor:Write enable is high and Read enable is low");
        fsi_1.i_wrdata = vif.mp_monitor.clk_b_monitor.i_wrdata;
        fsi_1.i_wren = vif.mp_monitor.clk_b_monitor.i_wren;
        fsi_1.i_rden = vif.mp_monitor.clk_b_monitor.i_rden;
        fsi_1.o_rddata = vif.mp_monitor.clk_b_monitor.o_rddata; 
        fsi_1.o_full = vif.mp_monitor.clk_b_monitor.o_full;
        fsi_1.o_alm_full = vif.mp_monitor.clk_b_monitor.o_alm_full;
        fsi_1.o_empty = vif.mp_monitor.clk_b_monitor.o_empty;
        fsi_1.o_alm_empty = vif.mp_monitor.clk_b_monitor.o_alm_empty;
        
        analysis_p.write(fsi_1);
      end   
     else if(vif.mp_monitor.clk_b_monitor.i_wren == 0 && vif.mp_monitor.clk_b_monitor.i_rden == 1)begin
    
        $display("\n Input Monitor: Write enable is low and Read enable is high");
        fsi_1.i_wrdata = vif.mp_monitor.clk_b_monitor.i_wrdata;
        fsi_1.i_wren = vif.mp_monitor.clk_b_monitor.i_wren;
        fsi_1.i_rden = vif.mp_monitor.clk_b_monitor.i_rden;
         fsi_1.o_rddata = vif.mp_monitor.clk_b_monitor.o_rddata; 
        fsi_1.o_full = vif.mp_monitor.clk_b_monitor.o_full;
        fsi_1.o_alm_full = vif.mp_monitor.clk_b_monitor.o_alm_full;
        fsi_1.o_empty = vif.mp_monitor.clk_b_monitor.o_empty;
        fsi_1.o_alm_empty = vif.mp_monitor.clk_b_monitor.o_alm_empty;
        analysis_p.write(fsi_1);
      end 
     else if(vif.mp_monitor.clk_b_monitor.i_wren == 1 && vif.mp_monitor.clk_b_monitor.i_rden == 1)begin
       
        $display("\n Input Monitor :Write and Read enable is high");
        fsi_1.i_wrdata = vif.mp_monitor.clk_b_monitor.i_wrdata;
        fsi_1.i_wren = vif.mp_monitor.clk_b_monitor.i_wren;
        fsi_1.i_rden = vif.mp_monitor.clk_b_monitor.i_rden;
         fsi_1.o_rddata = vif.mp_monitor.clk_b_monitor.o_rddata; 

        fsi_1.o_full = vif.mp_monitor.clk_b_monitor.o_full;
        fsi_1.o_alm_full = vif.mp_monitor.clk_b_monitor.o_alm_full;
        fsi_1.o_empty = vif.mp_monitor.clk_b_monitor.o_empty;
        fsi_1.o_alm_empty = vif.mp_monitor.clk_b_monitor.o_alm_empty;
        analysis_p.write(fsi_1);
       end 
    else  if(vif.mp_monitor.clk_b_monitor.i_wren == 0 && vif.mp_monitor.clk_b_monitor.i_rden == 0)begin
      
        $display("\n Input Monitor: No write and read operation");
        fsi_1.i_wrdata = vif.mp_monitor.clk_b_monitor.i_wrdata;
        fsi_1.i_wren = vif.mp_monitor.clk_b_monitor.i_wren;
        fsi_1.i_rden = vif.mp_monitor.clk_b_monitor.i_rden;
         fsi_1.o_rddata = vif.mp_monitor.clk_b_monitor.o_rddata; 
        fsi_1.o_full = vif.mp_monitor.clk_b_monitor.o_full;
        fsi_1.o_alm_full = vif.mp_monitor.clk_b_monitor.o_alm_full;
        fsi_1.o_empty = vif.mp_monitor.clk_b_monitor.o_empty;
        fsi_1.o_alm_empty = vif.mp_monitor.clk_b_monitor.o_alm_empty;
       analysis_p.write(fsi_1);
     end    
    end
     endtask : run_phase
endclass
