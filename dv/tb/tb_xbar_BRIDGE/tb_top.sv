import uvm_pkg::*;     //added for questa support
`include "uvm_macros.svh"


`include "base_test.sv";

module tb_top;


    //clk and reset	
    logic clk,reset;   

    initial begin
        clk=0;

        //setting the reset
        reset = 1;
        #20; // Wait 
        reset = 0;



    end



    //Generate a clock
    always begin
        #10 clk = ~clk;
    end
    
/*     //for gtkwave
    initial 
        begin
        $dumpfile("sim.vcd");
        $dumpvars; 
        end   

    //for verdi

    initial 
        begin
            $fsdbDumpfile("waves.fsdb");
            $fsdbDumpvars(0, "+struct", "+packedmda", "+mda", "+all");
        end
    
*/   
    //wb interface instance
    master_intf master_if(.clk(clk));
    
    //response interface
    slave_intf slave_if(.clk(clk)); 

    
    //config_db 
    initial begin
    
    
        uvm_config_db#(virtual master_intf ) :: set(null,"*","master_if",master_if); 
        
        uvm_config_db#(virtual slave_intf ) :: set(null,"*","slave_if",slave_if);
        
        
        run_test("base_test");
    end

//parameters
    
    parameter N_CH0          = 5; //--> CH0
    parameter N_CH1          = 4;  //--> CH1
    parameter N_SLAVE        = 3;
    parameter ID_WIDTH       = N_CH0+N_CH1;
    parameter AUX_WIDTH      = 8;

    parameter ADDR_WIDTH     = 32;
    parameter DATA_WIDTH     = 32;
    parameter BE_WIDTH       = DATA_WIDTH/8;

    XBAR_BRIDGE
    #(
        .N_CH0 (N_CH0),           
        .N_CH1  (N_CH1),            
        .N_SLAVE    (N_SLAVE),
        .ID_WIDTH   (ID_WIDTH),
        .AUX_WIDTH   (AUX_WIDTH),
        .ADDR_WIDTH  (ADDR_WIDTH),
        .DATA_WIDTH  (DATA_WIDTH),
        .BE_WIDTH    (BE_WIDTH)
    )
    DUT_i 
    (
        // ---------------- MASTER CH0+CH1 SIDE  --------------------------
        // Req
    .data_req_i(master_if.data_req_i),             // Data request
    .data_add_i(master_if.data_add_i),             // Data request Address {memory ROW , BANK}
    .data_wen_i(master_if.data_wen_i),             // Data request wen : 0--> Store, 1 --> Load
    .data_wdata_i(master_if.data_wdata_i),           // Data request Write data
    .data_be_i(master_if.data_be_i),              // Data request Byte enable
    .data_aux_i(master_if.data_aux_i),
    .data_gnt_o(master_if.data_gnt_o),             // Data request Grant
        // Resp
    .data_r_valid_o(master_if.data_r_valid_o),         // Data Response Valid (For LOAD/STORE commands)
    .data_r_rdata_o(master_if.data_r_rdata_o),         // Data Response DATA (For LOAD commands)
    .data_r_opc_o(master_if.data_r_opc_o),
    .data_r_aux_o(master_if.data_r_aux_o),

        // ---------------- MM_SIDE (Interleaved) --------------------------
        // Req --> to Mem
    .data_req_o(slave_if.data_req_o),             // Data request
    .data_add_o(slave_if.data_add_o),             // Data request Address
    .data_wen_o(slave_if.data_wen_o) ,            // Data request wen : 0--> Store, 1 --> Load
    .data_wdata_o(slave_if.data_wdata_o),           // Data request Wrire data
    .data_be_o(slave_if.data_be_o),              // Data request Byte enable
    .data_ID_o(slave_if.data_ID_o),
    .data_aux_o(slave_if.data_aux_o),
    .data_gnt_i(slave_if.data_gnt_i),

    // Resp --> From Mem
    .data_r_rdata_i(slave_if.data_r_rdata_i),         // Data Response DATA (For LOAD commands)
    .data_r_valid_i(slave_if.data_r_valid_i),         // Data Response: Command is Committed
    .data_r_ID_i(slave_if.data_r_ID_i),              // Data Response ID: To backroute Response
    .data_r_opc_i(slave_if.data_r_opc_i),
    .data_r_aux_i(slave_if.data_r_aux_i),

    .clk(clk),                    // Clock
    .rst_n(reset),                   // Active Low Reset

    .START_ADDR(slave_if.START_ADDR),    //set the start and end address otherwise requests will not be granted!!!
    .END_ADDR(slave_if.END_ADDR)  //wasn't working correct written in hex (idkw) so added it in binary form    

    );
    

    

endmodule:tb_top
