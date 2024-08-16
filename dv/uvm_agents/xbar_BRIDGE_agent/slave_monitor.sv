//`include "seq_item_master.v"


`define MON_IF slave_if.slave_monitor_cb

class slave_monitor extends uvm_monitor;

    `uvm_component_utils(slave_monitor)
      
      //virtual interface
    virtual slave_intf slave_if;
      
    uvm_analysis_port #(seq_item_slave) port_item;


    //uvm_analysis_export #(seq_item_master) port_item_adr;
  
    seq_item_slave inst;

   
    function new (string name, uvm_component parent);
        super.new(name, parent);
       
    endfunction

    function void build_phase (uvm_phase phase); 
        super.build_phase(phase);
        $display("Into the slave_monitor build phase!");
      
        if(!uvm_config_db#(virtual slave_intf)::get(this,"","slave_if",slave_if))begin
          `uvm_fatal("NOMEM_IF",{"Virtual interface must be set for:",get_full_name(),".slave_if"});
        end


    
        port_item = new("port_item",this); 
        //port_item_adr = new("port_item_adr",this);

    endfunction
 
    virtual task run_phase(uvm_phase phase); 
        inst = seq_item_slave:: type_id :: create("inst", this);

     
        forever begin 
          
            inst.data_req_o    = `MON_IF.data_req_o;
            inst.data_add_o = `MON_IF.data_add_o;
            inst.data_wen_o    = `MON_IF.data_wen_o;
            inst.data_wdata_o = `MON_IF.data_wdata_o;
            inst.data_be_o = `MON_IF.data_be_o;   
            inst.data_ID_o = `MON_IF.data_ID_o;
            inst.data_aux_o = `MON_IF.data_aux_o;   
            inst.data_gnt_i = `MON_IF.data_gnt_i;
            inst.data_r_rdata_i = `MON_IF.data_r_rdata_i;
            inst.data_r_valid_i = `MON_IF.data_r_valid_i;
            inst.data_r_ID_i = `MON_IF.data_r_ID_i;
            inst.data_r_opc_i = `MON_IF.data_r_opc_i;
            inst.data_r_aux_i = `MON_IF.data_r_aux_i;
            inst.START_ADDR = `MON_IF.START_ADDR;
            inst.END_ADDR = `MON_IF.END_ADDR; 

            port_item.write(inst);  //writing the data to be used in scoreboard

          

            @(`MON_IF);   
       
        end
    
    endtask
  
  endclass 