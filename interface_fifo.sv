interface interface_fifo(input clk,rstn);
  parameter DATA_W   = 128;    
  parameter DEPTH    = 1024;  
  parameter UPP_TH   = 4;     
  parameter LOW_TH   = 2;    

  logic i_wren,i_rden,o_full,o_empty,o_alm_full,o_alm_empty;
  logic  [DATA_W - 1 : 0] i_wrdata;
  logic  [DATA_W - 1 : 0] o_rddata;


//driver clocking block
  clocking clk_b_driver @(posedge clk);
  default input #0 output #0;
  output  i_wrdata;
  output i_wren,i_rden;
endclocking : clk_b_driver

// monitor clocking block
  clocking clk_b_monitor @(posedge clk);
  default input #0 output #0;
  input  i_wrdata;
  input i_wren,i_rden;
   input  o_rddata;
  input o_full,o_empty,o_alm_full,o_alm_empty; 
endclocking : clk_b_monitor



//declare modport
modport mp_driver (input clk, rstn, clocking clk_b_driver);
modport mp_monitor (input clk, rstn, clocking clk_b_monitor);

endinterface
