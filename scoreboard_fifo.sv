

class scoreboard_fifo extends uvm_scoreboard;
  uvm_analysis_imp#(transactions_fifo, scoreboard_fifo) analysis_p;

  `uvm_component_utils(scoreboard_fifo)

function new(string name = "scoreboard_fifo", uvm_component parent);
  super.new(name, parent);
   analysis_p = new("analysis_p", this);

endfunction

   
virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction


  
bit [DATA_W - 1 : 0] queue[$];
int count;
bit check_full;
bit check_empty;
bit check_almost_full;
bit check_almost_empty;
int temp_count;
int wrcnt;
int rdcnt;

  
  
function void write(input transactions_fifo req1);
   
  bit [127:0] data;
    
   if ((req1.i_wren == 1) && (req1.i_rden == 0))
     		  begin
                wrcnt=1;
      				queue.push_back(req1.i_wrdata);
      				count = count + 1;
                `uvm_info(get_type_name(), $sformatf("******** Write Operation ********"), UVM_LOW)             
                
 `uvm_info("Write enable is high and Read enable is low", $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d count: %0d o_full: %0b o_empty: %0b o_alm_full: %0b o_alm_empty: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata, count, req1.o_full,req1.o_empty,req1.o_alm_full,req1.o_alm_empty), UVM_LOW);
                
                
                 if(count==0)
       					 check_empty = 1;
                       
          			 if(req1.o_empty==1 && check_empty==1)
            			$display("FIFO EMPTY TEST CASE PASS");
         			else
          				 $display("FIFO EMPTY TEST CASE FAIL");
      
                if(count<LOW_TH)   				 			                                check_almost_empty=1;
                       
          			if(req1.o_alm_empty==1 && check_almost_empty==1)
                      $display("FIFO ALMOST EMPTY TEST CASE PASS");
          			else
                      $display("FIFO ALMOST EMPTY TEST CASE FAIL");
                
                
                
                
                if(count>UPP_TH)
       					  check_almost_full=1;
                
                if((req1.o_alm_full==1) && (check_almost_full==1))
                        $display("FIFO ALMOST FULL TEST CASE PASS");
         	    else
                        $display("FIFO ALMOST FULL TEST CASE FAIL"); 
                      
                
                if(count==DEPTH) 
      					 check_full = 1;
                if((req1.o_full==1) && (check_full==1))
       					 $display("FIFO FULL TEST CASE PASS");
      			else
      					 $display("FIFO FULL TEST CASE FAIL");
   				
     	      end
        
        
    else if (req1.i_rden == 1 && req1.i_wren == 0)
        begin
          rdcnt=1;

     		 if(queue.size() >= 1)
                begin
                  $display("Queue:%0p",queue);
       			data = queue.pop_front();
       			count = count - 1;
                  
                  `uvm_info(get_type_name(), $sformatf("******** Read Operation ********"), UVM_LOW)                
        `uvm_info("Write enable is low and Read enable is high", $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d o_rddata: %0d count: %0d o_full: %0b o_empty: %0b o_alm_full: %0b o_alm_empty: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata,req1.o_rddata, count, req1.o_full,req1.o_empty,req1.o_alm_full,req1.o_alm_empty), UVM_LOW);
      
                  $display("POPPED DATA: %0d",data);
                	 if(count==0)
       					 check_empty = 1;
                       
          			 if(req1.o_empty==1 && check_empty==1)
            			$display("FIFO EMPTY TEST CASE PASS");
         			else
          				 $display("FIFO EMPTY TEST CASE FAIL");
      
        			if(count<LOW_TH) 
        				 check_almost_empty=1;
                       
          			if(req1.o_alm_empty==1 && check_almost_empty==1)
                      $display("FIFO ALMOST EMPTY TEST CASE PASS");
          			else
                      $display("FIFO ALMOST EMPTY TEST CASE FAIL");
                  
                  
                  
                  
                	  if(count>UPP_TH)
       					  check_almost_full=1;
                
              		  if((req1.o_alm_full==1) && (check_almost_full==1))
                        $display("FIFO ALMOST FULL TEST CASE PASS");
         	   		 else
                        $display("FIFO ALMOST FULL TEST CASE FAIL"); 
                      
                
             		   if(count==DEPTH) 
      					 check_full = 1;
               			 if((req1.o_full==1) && (check_full==1))
       					 $display("FIFO FULL TEST CASE PASS");
      					else
      					 $display("FIFO FULL TEST CASE FAIL");
                  
                  
                  
        
       				 if(data == req1.o_rddata)
          				$display("INPUT DATA and OUTPUT DATA MATCH");
       				 else 
         				 $display("INPUT DATA and OUTPUT DATA MISMATCH");
     			   end
     
  			else
    			begin
      					check_empty = 1;
     					 if(req1.o_empty==1 && check_empty==1)
            					$display("FIFO EMPTY TEST CASE PASS");
         				 else
             					$display("FIFO EMPTY TEST CASE FAIL");
   				 end
          
          
              if(wrcnt==1 && rdcnt==1)
         begin
        
           if (req1.i_wrdata==req1.o_rddata)
            $display("Alternate read and write test pass");
       
      
   		   end
    
          end
    
   else if (req1.i_rden == 1 && req1.i_wren == 1)begin
      
            temp_count=count;
            queue.push_back(req1.i_wrdata);
            count = count + 1;
             
    		  if(queue.size() >= 'd1)begin
                  $display("Queue:%0p",queue);
                data = queue.pop_front();
                
                $display("POPPED DATA: %0d",data);
                count = count - 1; end
      
     `uvm_info(get_type_name(), $sformatf("******** Write and Read Operation ********"), UVM_LOW)      
     
       `uvm_info("Write and Read enable is high",  $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d o_rddata: %0d count: %0d o_full: %0b o_empty: %0b o_alm_full: %0b o_alm_empty: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata,req1.o_rddata, count, req1.o_full,req1.o_empty,req1.o_alm_full,req1.o_alm_empty), UVM_LOW);
      if(count==temp_count && req1.i_wrdata==req1.o_rddata) begin
        		$display("INPUT DATA and OUTPUT DATA MATCH");
        $display("Simulataneous write and read test pass"); end
      		  else
                begin
                 $display("INPUT DATA and OUTPUT DATA MISMATCH");
        		  $display("Simulataneous write and read test fail");
                end
      end
      
      
    
   else if (req1.i_rden == 0 && req1.i_wren == 0)
      begin
        
        `uvm_info(get_type_name(), $sformatf("******** No Write and Read Operation ********"), UVM_LOW)
        
       `uvm_info("No write and read operation",  $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d o_rddata: %0d count: %0d o_full: %0b o_empty: %0b o_alm_full: %0b o_alm_empty: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata,req1.o_rddata, count, req1.o_full,req1.o_empty,req1.o_alm_full,req1.o_alm_empty), UVM_LOW);
        if(req1.i_wrdata && !req1.o_rddata)
                $display("No write and read test pass");
         
      end
    
endfunction
      
endclass
