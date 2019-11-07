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

  xf100_ifu u_xf100_ifu (
  .ifu_o_instr(ifu_instr),
  .ifu_o_pc   (ifu_pc   ),

  .clk  (clk  ),
  .rst_n(rst_n)

  );



endmodule



