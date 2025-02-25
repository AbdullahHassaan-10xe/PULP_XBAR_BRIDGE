
  
interface master_intf(input clk);


        bit [8:0]                             data_req_i;             // Data request 
        bit [8:0][31:0]                       data_add_i;                   // Data request Address {memory ROW , BANK} 
        bit [8:0]                             data_wen_i;             // Data request wen : 0--> Store, 1 --> Load
        bit [8:0][31:0]                     data_wdata_i;           // Data request Write data
        bit [8:0][3:0]                         data_be_i;              // Data request Byte enable
        bit [8:0][7:0]                        data_aux_i;
        bit [8:0]                             data_gnt_o;             // Data request Grant
        // Resp
        bit [8:0]                         data_r_valid_o;         // Data Response Valid (For LOAD/STORE commands)
        bit [8:0][31:0]                   data_r_rdata_o;         // Data Response DATA (For LOAD commands)   
        bit [8:0][7:0]                      data_r_opc_o;
        bit [8:0][7:0]                      data_r_aux_o;          


        //master_driver clocking block
        clocking master_driver_cb@(posedge clk);

        default input #1ns output # 1ns;

        output data_req_i;
        output data_add_i;
        output data_wen_i;
        output data_wdata_i;
        output data_be_i;
        output data_aux_i;
        input data_gnt_o;
        input data_r_valid_o;
        input data_r_rdata_o;
        input data_r_opc_o;
        input data_r_aux_o;


        endclocking

        //master_monitor clocking block
        clocking master_monitor_cb@(posedge clk);


        default input #1ns output # 1ns;
        input data_req_i;
        input data_add_i;
        input data_wen_i;
        input data_wdata_i;
        input data_be_i;
        input data_aux_i;
        input data_gnt_o;
        input data_r_valid_o;
        input data_r_rdata_o;
        input data_r_opc_o;
        input data_r_aux_o; 
            


        endclocking



endinterface
 