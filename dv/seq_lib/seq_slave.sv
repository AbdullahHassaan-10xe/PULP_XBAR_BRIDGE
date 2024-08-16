import env_pkg::*;



class seq_slave extends uvm_sequence #(seq_item_slave);  

    `uvm_object_utils(seq_slave)
    
  
   //fifo_item an instance of our seq_item_slave 
    seq_item_slave fifo_item; 
    
    
    function new(string name = "seq_slave");
            super.new(name);
            //my_event = new();
          
    endfunction 

    
  

endclass 


//slave side sequences for test cases
class address_setup extends seq_slave; 
`uvm_object_utils(address_setup)
  
    function new (string name = "address_setup");
        super.new(name);
    endfunction
    virtual task body();
     
        fifo_item = seq_item_slave::type_id::create("fifo_item");   
        start_item(fifo_item); //first transaction start
            
            //mention all the desired 'START' and 'END' slave addresses once and for all
            fifo_item.START_ADDR[0] = 8'h000000000; 
            fifo_item.END_ADDR[0] = 32'b10000000000000000000000000000000;
            fifo_item.START_ADDR[1] = 8'h000000000; 
            fifo_item.END_ADDR[1] = 32'b10000000000000000000000000000000;
            fifo_item.START_ADDR[2] = 8'h000000000; 
            fifo_item.END_ADDR[2] = 32'b10000000000000000000000000000000;  

            fifo_item.data_gnt_i = 3'b001;
            
            finish_item(fifo_item); //first transaction finish
        

        
    endtask : body
endclass

class test_single_read_r extends seq_slave; 
`uvm_object_utils(test_single_read_r)
  
    function new (string name = "test_single_read_r");
        super.new(name);
    endfunction
    virtual task body();
     
        fifo_item = seq_item_slave::type_id::create("fifo_item");   
        start_item(fifo_item);
            
          
            //fifo_item.data_r_ID_i[0] = 9'b000000001;  //no point of writing it, slave memory bank is selected by algorithm and not by this

            fifo_item.START_ADDR[0] = 8'h000000000; 
            fifo_item.END_ADDR[0] = 32'b10000000000000000000000000000000;
            fifo_item.START_ADDR[1] = 8'h000000000; 
            fifo_item.END_ADDR[1] = 32'b10000000000000000000000000000000;
            fifo_item.START_ADDR[2] = 8'h000000000; 
            fifo_item.END_ADDR[2] = 32'b10000000000000000000000000000000;  

            fifo_item.data_gnt_i = 3'b001;

            fifo_item.data_r_rdata_i[0] = 32'h00000001;   

          
        finish_item(fifo_item);
      
    endtask : body
endclass


class test_cons_read_r extends seq_slave; 
`uvm_object_utils(test_cons_read_r)
  
    function new (string name = "test_cons_read_r");
        super.new(name);
    endfunction
    virtual task body();
     
        fifo_item = seq_item_slave::type_id::create("fifo_item");   
        start_item(fifo_item);
            
            fifo_item.START_ADDR[0] = 8'h000000000; 
            fifo_item.END_ADDR[0] = 32'b10000000000000000000000000000000;
            fifo_item.START_ADDR[1] = 8'h000000000; 
            fifo_item.END_ADDR[1] = 32'b10000000000000000000000000000000;
            fifo_item.START_ADDR[2] = 8'h000000000; 
            fifo_item.END_ADDR[2] = 32'b10000000000000000000000000000000;  

            fifo_item.data_gnt_i = 3'b001;
            
          
            fifo_item.data_r_rdata_i[0] = 32'h00000001;  

          
        finish_item(fifo_item);
        #100ns;

        start_item(fifo_item);
            
          
            fifo_item.data_r_rdata_i[1] = 32'h00000002;   

          
        finish_item(fifo_item);
        
    endtask : body
endclass


class test_aux_read_data_r extends seq_slave; 
`uvm_object_utils(test_aux_read_data_r)
  
    function new (string name = "test_aux_read_data_r");
        super.new(name);
    endfunction
    virtual task body();
     
        fifo_item = seq_item_slave::type_id::create("fifo_item");   
        start_item(fifo_item);
            
         
            fifo_item.START_ADDR[0] = 8'h000000000; 
            fifo_item.END_ADDR[0] = 32'b10000000000000000000000000000000;
            fifo_item.START_ADDR[1] = 8'h000000000; 
            fifo_item.END_ADDR[1] = 32'b10000000000000000000000000000000;
            fifo_item.START_ADDR[2] = 8'h000000000; 
            fifo_item.END_ADDR[2] = 32'b10000000000000000000000000000000;  

            //fifo_item.data_r_aux_i[0] = 32'h00000001;    //checking at 1st slave
            fifo_item.data_r_aux_i[1] = 32'h00000001;    //checking at 2nd slave

            //test fails for 2nd and 3rd slave and passes just for 1st one slave(in short test fails generically)

          
        finish_item(fifo_item);
        //#400ns; //this delay not needed when running test
        
    endtask : body
endclass




