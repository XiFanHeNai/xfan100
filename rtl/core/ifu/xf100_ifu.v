/////////////////////////////////////////////////////
// ifu module definition.
// description: 
//   ifu module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_ifu 
(
  output [`XF100_INSTR_SIZE-1:0] ifu_o_instr,
  output [`XF100_PC_SIZE-1:0]    ifu_o_pc,

  input clk,
  input rst_n
);
  wire [`XF100_INSTR_SIZE-1:0] instr;
  wire [`XF100_PC_SIZE-1:0]    pc;

  assign ifu_o_instr = instr;
  assign ifu_o_pc    = pc;



  //TODO:here we need a ram for all instructions.

endmodule



