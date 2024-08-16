`define DRIV_IF slave_if.slave_driver_cb  //here comes the clocking block of the req_resp_interface


class slave_driver extends uvm_driver #(seq_item_slave) ;

    `uvm_component_utils(slave_driver);
    
    virtual slave_intf slave_if;
 
    //constructor
    function new(string name , uvm_component parent);    
        super.new(name,parent);
    endfunction: new


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual slave_intf):: get(this,"*","slave_if",slave_if))begin
                `uvm_fatal ("DRIVER","slave_driver:Failed to get slave_if") 
        end

    endfunction:build_phase
            
    virtual task run_phase (uvm_phase phase);
        
        forever begin
            //seq_item instance
            seq_item_slave  inst;
           
            seq_item_port.get_next_item(inst);

            //getting values from sequence   
            `DRIV_IF. data_r_rdata_i<= inst. data_r_rdata_i; 
            `DRIV_IF.data_r_valid_i <= inst.data_r_valid_i;
            `DRIV_IF.data_r_ID_i <= inst.data_r_ID_i; 
            `DRIV_IF.data_gnt_i <= inst.data_gnt_i;
            `DRIV_IF.data_r_opc_i <= inst.data_r_opc_i;
            `DRIV_IF.data_r_aux_i <= inst.data_r_aux_i;
            `DRIV_IF.START_ADDR <= inst.START_ADDR;
            `DRIV_IF.END_ADDR <= inst.END_ADDR;  
                
            
        
            seq_item_port.item_done();
            
            @(`DRIV_IF); 
                    
            end
            
    endtask
        

endclass : slave_driver
