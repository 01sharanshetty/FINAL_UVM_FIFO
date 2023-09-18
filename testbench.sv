import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface_fifo.sv"
`include "test_fifo.sv"



module testbench;
  
  
bit clk;
bit rstn;
  
always #5 clk = ~clk;
  
initial 
begin
    clk = 1;
    rstn = 0;
    #5;
    rstn = 1;
end
  
interface_fifo intf(clk, rstn);
  
SYN_FIFO dut(.clk(intf.clk),
               .rst(intf.rstn),
               .data_in(intf.i_wrdata),
               .write_en(intf.i_wren),
               .read_en(intf.i_rden),
               .full(intf.o_full),
               .empty(intf.o_empty),
               .data_out(intf.o_rddata),
               .almost_full(intf.o_alm_full), .almost_empty(intf.o_alm_empty));
  
initial begin
    uvm_config_db#(virtual interface_fifo)::set(null, "", "vif",intf);
    $dumpfile("dump.vcd"); 
    $dumpvars;
    run_test("test_fifo");
end
  
endmodule
