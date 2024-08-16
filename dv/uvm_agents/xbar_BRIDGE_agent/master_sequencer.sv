class  master_sequencer extends uvm_sequencer #(seq_item_master); 

    `uvm_component_utils(master_sequencer)   

   uvm_tlm_analysis_fifo #(seq_item_master) fifo_export;  
    
    function new(string name ,uvm_component parent);
        super.new(name,parent);
        //analysis fifo constructor
        fifo_export = new("fifo_export", this);
        
    endfunction 
    
endclass 
