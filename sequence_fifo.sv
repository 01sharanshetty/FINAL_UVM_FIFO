

class sequence_fifo extends uvm_sequence #(transactions_fifo);
  `uvm_object_utils(sequence_fifo) //factory registration
   transactions_fifo fsi;
  function new(string name = "sequence_fifo"); 
    super.new(name);
  endfunction
  
virtual task body();

  repeat(5) begin

    fsi = transactions_fifo::type_id::create("fsi");  //creating sequence_item
    start_item(fsi);
    assert(fsi.randomize()with {fsi.i_wren==1;fsi.i_rden==0;});
    finish_item(fsi);
    end


  repeat(5) begin

     fsi = transactions_fifo::type_id::create("fsi");  //creating sequence_item
    start_item(fsi);
    assert(fsi.randomize()with {fsi.i_wren==0;fsi.i_rden==1;});
    finish_item(fsi);
    end

  
  
  repeat(5) begin

     fsi = transactions_fifo::type_id::create("fsi");  //creating sequence_item
    start_item(fsi);
    assert(fsi.randomize()with {fsi.i_rden==0 ; fsi.i_wren==0;});
    finish_item(fsi);
    end


  
  repeat(5) begin

    fsi = transactions_fifo::type_id::create("fsi");  //creating sequence_item
    start_item(fsi);
    assert(fsi.randomize()with {fsi.i_rden==1 ; fsi.i_wren==1;}); 
    finish_item(fsi);
    end
  
  

  repeat(5) begin

     fsi = transactions_fifo::type_id::create("fsi");  //creating sequence_item
    start_item(fsi);
    assert(fsi.randomize()with {fsi.i_rden==0 ; fsi.i_wren==1;}); //write
    finish_item(fsi);
      fsi = transactions_fifo::type_id::create("fsi");
     start_item(fsi);
    assert(fsi.randomize()with {fsi.i_rden==1 ; fsi.i_wren==0;}); //read
    finish_item(fsi);
    end
  

//    `uvm_info(get_type_name(), $sformatf("******** Generate Random fsi's ********"), UVM_LOW)
//     for(int j=0;j<10;j++) begin

//      fsi = transactions_fifo::type_id::create("fsi");  //creating sequence_item
//     start_item(fsi);
//     assert(fsi.randomize());
//     finish_item(fsi);
//    end 
endtask
endclass 




 

                                       


                                         
                                                                              
                                       
                                       


                                       
                                       
                                       
                                      
                                      
