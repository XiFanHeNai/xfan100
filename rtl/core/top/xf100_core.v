/////////////////////////////////////////////////////
// ifu module definition.
// description: 
//   ifu module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_core 
(
  input clk ,
  input rst_n
);
  wire [`XF100_INSTR_SIZE-1:0] ifu_instr;
  wire [`XF100_PC_SIZE-1:0]    ifu_pc   ;

//////////////////// ifu module //////////////////////
  xf100_ifu u_xf100_ifu (
    .ifu_o_instr(ifu_instr),
    .ifu_o_pc   (ifu_pc   ),

    .clk  (clk  ),
    .rst_n(rst_n)

  );

  wire                          data_ram_cs   ;
  wire                          data_ram_wen  ;
  wire [3:0]                    data_ram_mask ;
  wire [`XF100_DATA_RAM_AW-1:0] data_ram_addr ;
  wire [7:0]                    data_ram_wdat0;
  wire [7:0]                    data_ram_wdat1;
  wire [7:0]                    data_ram_wdat2;
  wire [7:0]                    data_ram_wdat3;
  wire [7:0]                    data_ram_rdat0;
  wire [7:0]                    data_ram_rdat1;
  wire [7:0]                    data_ram_rdat2;
  wire [7:0]                    data_ram_rdat3;
//////////////////// exu module //////////////////////
  xf100_exu  u_xf100_exu (
    .exu_i_instr(ifu_instr),
    .exu_i_pc   (ifu_pc   ),
  

    // mem access interface
    .agu_o_ram_cs     (data_ram_cs   ),
    .agu_o_ram_wen    (data_ram_wen  ),
    .agu_o_ram_mask   (data_ram_mask ),
    .agu_o_ram_addr   (data_ram_addr ),
    .agu_o_ram_wdat0  (data_ram_wdat0),
    .agu_o_ram_wdat1  (data_ram_wdat1),
    .agu_o_ram_wdat2  (data_ram_wdat2),
    .agu_o_ram_wdat3  (data_ram_wdat3),
    .agu_o_ram_rdat0  (data_ram_rdat0),
    .agu_o_ram_rdat1  (data_ram_rdat1),
    .agu_o_ram_rdat2  (data_ram_rdat2),
    .agu_o_ram_rdat3  (data_ram_rdat3),




    .clk  (clk  ),
    .rst_n(rst_n)
  );


//////////////////// data ram module //////////////////////
  xf100_ram #(
  .AW(`XF100_DATA_RAM_AW),
  .DP(`XF100_DATA_RAM_DP)
  ) u_xf100_data_ram (
    .ram_cs  (data_ram_cs  ),
    .ram_wen (data_ram_wen ),
    .ram_addr(data_ram_addr),
    .ram_mask(data_ram_mask),
    .ram_wdat0(data_ram_wdat0),
    .ram_wdat1(data_ram_wdat1),
    .ram_wdat2(data_ram_wdat2),
    .ram_wdat3(data_ram_wdat3),
    .ram_rdat0(data_ram_rdat0),
    .ram_rdat1(data_ram_rdat1),
    .ram_rdat2(data_ram_rdat2),
    .ram_rdat3(data_ram_rdat3),

    .clk     (clk),
    .rst_n   (1'b0) // this is not used in ram model.
  );
//
endmodule



