/////////////////////////////////////////////////////
// alu module definition.
// description: 
//   alu module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_exu_alu 
(

  input                       alu_i_alu_op  ,
  input [`ALU_INFO_WIDTH-1:0] alu_i_alu_info,
	
  input                           alu_i_rs1_en,
  input                           alu_i_rs2_en,
  input                           alu_i_rd_en ,
  input [`XF100_XLEN-1:0]         alu_i_rs1,
  input [`XF100_XLEN-1:0]         alu_i_rs2,
  input [`XF100_RFIDX_WIDTH-1:0]  alu_i_rdidx,


  output                           alu_o_wbck_en,
  output [`XF100_XLEN-1:0]         alu_o_wbck_data,
  output [`XF100_RFIDX_WIDTH-1:0]  alu_o_wbck_rdidx,


  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
  input clk,
  input rst_n

);


  wire add_op = alu_i_alu_info[`ALU_INFO_DEF_ADD];

  wire [`XF100_XLEN-1:0]  alu_op1 = alu_i_rs1;
  wire [`XF100_XLEN-1:0]  alu_op2 = alu_i_rs2;


  wire [`XF100_XLEN-1:0] adder_res = alu_op1 + alu_op2; // TODO: sub?


  assign alu_o_wbck_data = {`XF100_XLEN{add_op}} & adder_res;
  assign alu_o_wbck_en = alu_i_rd_en;
  assign alu_o_wbck_rdidx = alu_i_rdidx;

endmodule



