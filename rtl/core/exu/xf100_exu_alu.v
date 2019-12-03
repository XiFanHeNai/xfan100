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
  input [`XF100_XLEN-1:0]         alu_i_imm,


  output                           alu_o_wbck_en,
  output [`XF100_XLEN-1:0]         alu_o_wbck_data,
  output [`XF100_RFIDX_WIDTH-1:0]  alu_o_wbck_rdidx,


  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
  input clk,
  input rst_n

);

  wire imm_en  = alu_i_alu_info[`ALU_INFO_DEF_HAS_IMM];

  wire add_op  = alu_i_alu_info[`ALU_INFO_DEF_ADD];
  wire sub_op  = alu_i_alu_info[`ALU_INFO_DEF_SUB];
  wire sll_op  = alu_i_alu_info[`ALU_INFO_DEF_SLL];				   
  wire slt_op  = alu_i_alu_info[`ALU_INFO_DEF_SLT];
  wire sltu_op = alu_i_alu_info[`ALU_INFO_DEF_SLTU];
  wire xor_op  = alu_i_alu_info[`ALU_INFO_DEF_XOR];
  wire srl_op  = alu_i_alu_info[`ALU_INFO_DEF_SRL];
  wire sra_op  = alu_i_alu_info[`ALU_INFO_DEF_SRA];
  wire or_op   = alu_i_alu_info[`ALU_INFO_DEF_OR ];
  wire and_op  = alu_i_alu_info[`ALU_INFO_DEF_AND];
  wire lui_op  = alu_i_alu_info[`ALU_INFO_DEF_LUI];

  /////////////////////////////////////////////////////
  // add and sub
  // 1. normal add and sub, these are signed add but its overflow is ommitted.
  // 2. large or small comparesion.
  //
  wire add = add_op ;
  wire sub = sub_op | slt_op | sltu_op;
  wire addsub = add | sub;
  wire sign_flag = add_op | sub_op | slt_op ;
  wire [`XF100_XLEN-1:0]  imm = alu_i_imm;

  wire [`XF100_XLEN-1:0]  alu_rs1 = alu_i_rs1[`XF100_XLEN-1:0] ;
  wire [`XF100_XLEN-1:0]  alu_rs2 = imm_en ? alu_i_imm : alu_i_rs2 ;


  wire [`XF100_XLEN:0]  misc_op1 = sign_flag ? {alu_rs1[`XF100_XLEN-1],alu_rs1} : {1'b0,alu_rs1} ;
  wire [`XF100_XLEN:0]  misc_op2 = sign_flag ? {alu_rs2[`XF100_XLEN-1],alu_rs2} : {1'b0,alu_rs2} ;

  wire [`XF100_XLEN:0]  add_op1 = misc_op1;
  wire [`XF100_XLEN:0]  add_op2 = sub ? (~misc_op2) : misc_op2;

  wire [`XF100_XLEN:0]  add_ci = {{`XF100_XLEN{1'b0}}, sub}; 
  // TODO: this full adder can be optimize in timing.
  wire [`XF100_XLEN:0] adder_res = add_op1 + add_op2 + add_ci; //  we use a full adder to implement add and sub.

  /////////////////////////////////////////////////////
  // compare.
  wire slt = slt_op | sltu_op;
  wire [`XF100_XLEN-1:0] slt_res = {{`XF100_XLEN-1{1'b0}}, adder_res[`XF100_XLEN]}; 
  /////////////////////////////////////////////////////
  // shift
  // TODO: this can be optimized.
  //// wire [`XF100_XLEN-1:0] shift_op1 = alu_i_rs1;
  //// wire [`XF100_XLEN-1:0] sll_res = alu_i_rs1 << alu_i_rs2[4:0];
  //// wire [`XF100_XLEN-1:0] srl_res = alu_i_rs1 >> alu_i_rs2[4:0];
  //// wire [`XF100_XLEN-1:0] sra_res = ((alu_i_rs1 >> alu_i_rs2[4:0]) & ({`XF100_XLEN{1'b1}} >> alu_i_rs2[4:0]));
  //// wire [`XF100_XLEN-1:0] shift_res = ({`XF100_XLEN{sll_op}} & shift_tmp_res)
  ////                                  | ({`XF100_XLEN{sll_op}} & shift_tmp_res)
  ////                                  | ({`XF100_XLEN{sll_op}} & shift_tmp_res)

  /////////////////////////////////////////////////////
  // logic alu
  wire [`XF100_XLEN-1:0] and_res = alu_rs1 & alu_rs2;
  wire [`XF100_XLEN-1:0] or_res  = alu_rs1 | alu_rs2;
  wire [`XF100_XLEN-1:0] xor_res = alu_rs1 ^ alu_rs2;



  assign alu_o_wbck_data = 
	                       ({`XF100_XLEN{addsub}} & adder_res[`XF100_XLEN-1:0]) 
	                     //// | {`XF100_XLEN{shift_op}} & shift_res; //TODO
	                     | ({`XF100_XLEN{slt   }} & slt_res)
	                     | ({`XF100_XLEN{and_op}} & and_res)
	                     | ({`XF100_XLEN{or_op }} & or_res )
	                     | ({`XF100_XLEN{xor_op}} & xor_res)
	                     | ({`XF100_XLEN{lui_op}} & imm)
						 ;
  assign alu_o_wbck_en = alu_i_rd_en;
  assign alu_o_wbck_rdidx = alu_i_rdidx;

endmodule



