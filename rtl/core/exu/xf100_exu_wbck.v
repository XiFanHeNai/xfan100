/////////////////////////////////////////////////////
// alu module definition.
// description: 
//   alu module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_exu_wbck 
(

  input                           wbck_i_wbck_en0,
  input [`XF100_XLEN-1:0]         wbck_i_wbck_data0,
  input [`XF100_RFIDX_WIDTH-1:0]  wbck_i_wbck_rdidx0,

  input                           wbck_i_wbck_en1,
  input [`XF100_XLEN-1:0]         wbck_i_wbck_data1,
  input [`XF100_RFIDX_WIDTH-1:0]  wbck_i_wbck_rdidx1,

  output                          wbck_o_wbck_en,
  output [`XF100_XLEN-1:0]        wbck_o_wbck_data,
  output [`XF100_RFIDX_WIDTH-1:0] wbck_o_wbck_rdidx,


  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
  input clk,
  input rst_n

);

  assign wbck_o_wbck_en    = wbck_i_wbck_en0    
                           | wbck_i_wbck_en1   ;
  assign wbck_o_wbck_data  = wbck_i_wbck_data0 
                           | wbck_i_wbck_data1 ;
  assign wbck_o_wbck_rdidx = wbck_i_wbck_rdidx0 
                           | wbck_i_wbck_rdidx1;

endmodule



