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
  
my_fifo dut(.clk(intf.clk),
               .rstn(intf.rstn),
               .i_wrdata(intf.i_wrdata),
               .i_wren(intf.i_wren),
               .i_rden(intf.i_rden),
               .o_full(intf.o_full),
            .o_empty(intf.o_empty),
               .o_rddata(intf.o_rddata),
               .o_alm_full(intf.o_alm_full), .o_alm_empty(intf.o_alm_empty));
  
initial begin
    uvm_config_db#(virtual interface_fifo)::set(null, "", "vif",intf);
    $dumpfile("dump.vcd"); 
    $dumpvars;
    run_test("test_fifo");
end
  
endmodule
