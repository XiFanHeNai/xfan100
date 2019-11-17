/////////////////////////////////////////////////////
// alu module definition.
// description: 
//   alu module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_exu_wbck 
(

  input                           wbck_i_wbck_en,
  input [`XF100_XLEN-1:0]         wbck_i_wbck_data,
  input [`XF100_RFIDX_WIDTH-1:0]  wbck_i_wbck_rdidx,

  output                          wbck_o_wbck_en,
  output [`XF100_XLEN-1:0]        wbck_o_wbck_data,
  output [`XF100_RFIDX_WIDTH-1:0] wbck_o_wbck_rdidx,


  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
  input clk,
  input rst_n

);

  assign wbck_o_wbck_en    = wbck_i_wbck_en    ;
  assign wbck_o_wbck_data  = wbck_i_wbck_data ;
  assign wbck_o_wbck_rdidx = wbck_i_wbck_rdidx ;

endmodule



