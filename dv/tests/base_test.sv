import env_pkg::*;
import seq_pkg::*;
import uvm_pkg::*;    //added for questa support
`include "uvm_macros.svh"

class base_test extends uvm_test;
    
    `uvm_component_utils(base_test);

    //tests instances
    test_gnt_single_bit_high gnt_single_high;
    test_gnt_single_bit_low gnt_single_low;
    test_gnt_multiple_bits gnt_multiple; 
    test_single_write single_write;
    test_cons_write cons_write; 
    test_be_lsb be_lsb;
    test_be_msb be_msb;
    test_single_read single_read;
    test_cons_read cons_read;
    test_aux aux;
    test_aux_read_data aux_read;
    

    test_single_read_r single_read_r;
    test_cons_read_r cons_read_r;
    test_aux_read_data_r aux_read_r; 
    

    address_setup addr_setup;


    
    //constructor
    function new(string name = "base_test" , uvm_component parent = null);
        super.new(name , parent);  
    endfunction 
    
    //p_seq instance for test
    p_seq seq_inst;
    
    //environment instance for test
    lint_env  env_instance;
    

    virtual master_intf master_if;
    
    
    virtual slave_intf slave_if; 

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
    
        
        if(!uvm_config_db #(virtual master_intf):: get(this, "", "master_if", master_if)) 
        begin
            `uvm_fatal("base_test", "base_test::Failed to get master_if")
        end
        
        if(!uvm_config_db #(virtual slave_intf ):: get(this, "", "slave_if", slave_if)) 
        begin
            `uvm_fatal("base_test", "base_test::Failed to get slave_if")
        end 

        
        gnt_single_high = test_gnt_single_bit_high:: type_id::create("gnt_single_high",this);
        gnt_single_low = test_gnt_single_bit_low:: type_id :: create ("gnt_single_low");
        gnt_multiple = test_gnt_multiple_bits:: type_id :: create ("gnt_multiple");
        single_write = test_single_write:: type_id :: create ("single_write");
        cons_write = test_cons_write:: type_id :: create ("cons_write");
        be_lsb = test_be_lsb:: type_id :: create ("be_lsb");
        be_msb = test_be_msb:: type_id :: create ("be_msb");
        single_read = test_single_read:: type_id :: create ("single_read");
        cons_read = test_cons_read:: type_id :: create ("cons_read");
        aux = test_aux :: type_id :: create ("aux");
        aux_read = test_aux_read_data :: type_id :: create ("aux_read");


        single_read_r = test_single_read_r :: type_id :: create ("single_read_r");
        cons_read_r = test_cons_read_r :: type_id :: create ("cons_read_r");
        aux_read_r = test_aux_read_data_r :: type_id :: create ("aux_read_r"); 
        

        addr_setup = address_setup :: type_id :: create ("addr_setup");
        
        seq_inst = p_seq:: type_id::create("seq_inst",this); 
        
        env_instance = lint_env::type_id::create("env_instance",this);
        
    endfunction: build_phase
    
    function void end_of_elaboration_phase(uvm_phase phase);
        $display("Topology Report");
        uvm_top.print_topology();
        $display("Topology Done!");
    endfunction

    

    

endclass


class single_bit_high_gnt_test extends base_test; 
    `uvm_component_utils(single_bit_high_gnt_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
        gnt_single_high.start(env_instance.lint_agent_inst.seqr);
        addr_setup.start(env_instance.lint_agent_1_inst.r_seqr);
        join
        #500;
      
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
        
      endtask

endclass


class single_bit_low_gnt_test extends base_test; 
    `uvm_component_utils(single_bit_low_gnt_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
        gnt_single_low.start(env_instance.lint_agent_inst.seqr); 
        addr_setup.start(env_instance.lint_agent_1_inst.r_seqr);
        join
        
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass

class multiple_bits_gnt_test extends base_test; 
    `uvm_component_utils(multiple_bits_gnt_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");

        fork
        gnt_multiple.start(env_instance.lint_agent_inst.seqr);
        addr_setup.start(env_instance.lint_agent_1_inst.r_seqr);
        join
        
        
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass

class single_write_test extends base_test; 
    `uvm_component_utils(single_write_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
        single_write.start(env_instance.lint_agent_inst.seqr);
        addr_setup.start(env_instance.lint_agent_1_inst.r_seqr);
        join
        
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass


class cons_write_test extends base_test; 
    `uvm_component_utils(cons_write_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
        cons_write.start(env_instance.lint_agent_inst.seqr); 
        addr_setup.start(env_instance.lint_agent_1_inst.r_seqr);
        join
        
    
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass

class be_lsb_test extends base_test; 
    `uvm_component_utils(be_lsb_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");

        fork
        be_lsb.start(env_instance.lint_agent_inst.seqr); 
        addr_setup.start(env_instance.lint_agent_1_inst.r_seqr);
        join
      
       
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass

class be_msb_test extends base_test; 
    `uvm_component_utils(be_msb_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        
        fork
        be_msb.start(env_instance.lint_agent_inst.seqr);   
        addr_setup.start(env_instance.lint_agent_1_inst.r_seqr);
        join

        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass


class single_read_test extends base_test; 
    `uvm_component_utils(single_read_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
    
        single_read.start(env_instance.lint_agent_inst.seqr); 
        single_read_r.start(env_instance.lint_agent_1_inst.r_seqr);     //r_seqr here   
        //addr_setup.start(env_instance.lint_agent_inst.r_seqr); //not to be used separately here
        
        join
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!");   
      
    endtask

endclass


class cons_read_test extends base_test;   
    `uvm_component_utils(cons_read_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
      
        cons_read.start(env_instance.lint_agent_inst.seqr); 
        cons_read_r.start(env_instance.lint_agent_1_inst.r_seqr);     //r_seqr here     
        //addr_setup.start(env_instance.lint_agent_inst.r_seqr);  //not to be used separately here
        
        join
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass


class aux_test extends base_test;   
    `uvm_component_utils(aux_test)

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
      
        aux.start(env_instance.lint_agent_inst.seqr);     
        addr_setup.start(env_instance.lint_agent_1_inst.r_seqr);  
        
        join
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!"); 
      
    endtask

endclass


class aux_data_read_test extends base_test;   
    `uvm_component_utils(aux_data_read_test)  

    function new(string name, uvm_component parent);
            super.new(name, parent);
    endfunction : new

    virtual task run_phase (uvm_phase phase);
      
        super.run_phase(phase);
        $display("Run Phase Started!");
        
        phase.raise_objection(this);
        $display("Objection Started!");
        fork
      
        aux_read.start(env_instance.lint_agent_inst.seqr); 
        aux_read_r.start(env_instance.lint_agent_1_inst.r_seqr);     //r_seqr here         
        //addr_setup.start(env_instance.lint_agent_inst.r_seqr);  //not to be used separately here

        join
      
        #500ns;
        
        $display("Sequence started!"); 
      
        phase.drop_objection(this);
        $display("Objection Dropped!");   
      
    endtask
 
endclass


