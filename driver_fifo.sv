
class driver_fifo extends uvm_driver #(transactions_fifo);
virtual interface_fifo vif; //interface handle
transactions_fifo fsi; //sequence_item handle
 
`uvm_component_utils(driver_fifo)
 
function new(string name = "driver_fifo", uvm_component parent);
    super.new(name, parent);
endfunction

 // Build Phase
virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   if(!uvm_config_db#(virtual interface_fifo)::get(this, "", "vif", vif))
      `uvm_fatal("Driver: ", "No vif is found!")
endfunction

     
// Run phase  
virtual task run_phase(uvm_phase phase);
    if(vif.mp_driver.rstn==0)
      begin//check for reset
        $display("RESET CONDITION");
    vif.mp_driver.clk_b_driver.i_wren <= 0;
    vif.mp_driver.clk_b_driver.i_rden <= 0;
    vif.mp_driver.clk_b_driver.i_wrdata <= 0;
   
      end
    forever begin
      seq_item_port.get_next_item(fsi);
      
      if(fsi.i_wren == 1 && fsi.i_rden == 0) begin
          @(posedge vif.mp_driver.clk)
    		vif.mp_driver.clk_b_driver.i_wren <= fsi.i_wren;
            vif.mp_driver.clk_b_driver.i_rden <= fsi.i_rden;
   			vif.mp_driver.clk_b_driver.i_wrdata <= fsi.i_wrdata;
    	 @(negedge vif.mp_driver.clk)
            vif.mp_driver.clk_b_driver.i_wren <= 0;
            vif.mp_driver.clk_b_driver.i_rden <=0; end
      
      else if(fsi.i_wren == 0 && fsi.i_rden == 1) begin
        @(posedge vif.mp_driver.clk)
    		vif.mp_driver.clk_b_driver.i_wren <= fsi.i_wren;
            vif.mp_driver.clk_b_driver.i_rden <= fsi.i_rden;
        @(negedge vif.mp_driver.clk)
            vif.mp_driver.clk_b_driver.i_wren <= 0;
            vif.mp_driver.clk_b_driver.i_rden <=0; end
      
     else if(fsi.i_rden == 1 && fsi.i_wren == 1) begin
       @(posedge vif.mp_driver.clk)
    		vif.mp_driver.clk_b_driver.i_wren <= fsi.i_wren;
            vif.mp_driver.clk_b_driver.i_rden <= fsi.i_rden;
    		vif.mp_driver.clk_b_driver.i_wrdata <= fsi.i_wrdata;
       @(negedge vif.mp_driver.clk)
            vif.mp_driver.clk_b_driver.i_wren <= 0;
            vif.mp_driver.clk_b_driver.i_rden <=0; 
     end
      
     else if(fsi.i_rden == 0 && fsi.i_wren == 0) begin
           @(posedge vif.mp_driver.clk)
    		vif.mp_driver.clk_b_driver.i_wren <= fsi.i_wren;
            vif.mp_driver.clk_b_driver.i_rden <= fsi.i_rden; end
      seq_item_port.item_done();
    end
endtask

   
endclass
