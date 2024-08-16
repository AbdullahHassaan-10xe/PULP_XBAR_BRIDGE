  interface slave_intf(input clk);


      // Req --> to Mem
        bit [2:0]                             data_req_o;             // Data request
        bit [2:0][31:0]                       data_add_o;             // Data request Address
        bit [2:0]                             data_wen_o;            // Data request wen : 0--> Store, 1 --> Load
        bit [2:0][31:0]                     data_wdata_o;           // Data request Wrire data
        bit [2:0][3:0]                         data_be_o;              // Data request Byte enable
        bit [2:0][8:0]                         data_ID_o;
        bit [2:0][7:0]                        data_aux_o;
        bit [2:0]                             data_gnt_i;
        // Resp --> From Mem
        bit [2:0][31:0]                   data_r_rdata_i;         // Data Response DATA (For LOAD commands)
        bit [2:0]                         data_r_valid_i;         // Data Response: Command is Committed
        bit [2:0][8:0]                       data_r_ID_i;            // Data Response ID: To backroute Response    
        bit [2:0]                           data_r_opc_i;
        bit [2:0][7:0]                      data_r_aux_i;
        bit [2:0][31:0]                       START_ADDR;
        bit [2:0][31:0]                         END_ADDR;

 



        //slave_monitor clocking block
        clocking slave_monitor_cb@(posedge clk);

            default input #1ns output # 1ns;  
            input data_req_o;
            input data_add_o;
            input data_wen_o;
            input data_wdata_o;
            input data_be_o;
            input data_ID_o;
            input data_aux_o;
            input data_gnt_i;
            input data_r_rdata_i;
            input data_r_valid_i;  
            input data_r_ID_i;
            input data_r_opc_i;
            input data_r_aux_i;
            input START_ADDR;
            input END_ADDR;  


                
                

        endclocking  

        //slave_driver clocking block
        clocking slave_driver_cb@(posedge clk);


            default input #1ns output # 1ns;
            input data_req_o;
            input data_add_o;
            input data_wen_o;
            input data_wdata_o;
            input data_be_o;
            input data_ID_o;
            input data_aux_o;
            output data_gnt_i;
            output data_r_rdata_i;
            output data_r_valid_i;
            output data_r_ID_i;
            output data_r_opc_i; 
            output data_r_aux_i;
            output START_ADDR; 
            output END_ADDR;    
                


        endclocking




  endinterface
