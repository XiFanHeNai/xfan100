/////////////////////////////////////////////////////
// ifu module definition.
// description: 
//   exu module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_exu 
(
  output [`XF100_INSTR_SIZE-1:0] exu_i_instr,
  output [`XF100_PC_SIZE-1:0]    exu_i_pc,

  input clk,
  input rst_n
);



  // the first step is decode.
  wire                       dec_alu_op  ;
  wire [`ALU_INFO_WIDTH-1:0] dec_alu_info;
	
  wire    dec_rs1_en ;
  wire    dec_rs2_en ;
  wire    dec_rd_en  ;
  wire  [`XF100_RFIDX_WIDTH-1:0]   dec_rs1_idx;
  wire  [`XF100_RFIDX_WIDTH-1:0]   dec_rs2_idx;
  wire  [`XF100_RFIDX_WIDTH-1:0]   dec_rd_idx ;


  xf100_exu_decode u_xf100_exu_decode
  (
    .dec_i_instr(exu_i_instr),

	.dec_o_alu_op  (dec_alu_op),
	.dec_o_alu_info(dec_alu_info),
	
	.dec_o_rs1_en  (dec_rs1_en),
	.dec_o_rs2_en  (dec_rs2_en),
	.dec_o_rd_en   (dec_rd_en),
	.dec_o_rs1_idx (dec_rs1_idx),
	.dec_o_rs2_idx (dec_rs2_idx),
	.dec_o_rd_idx  (dec_rd_idx),

    .clk  (clk  ),
    .rst_n(rst_n)
  );

  // step 2: alu op pipeline.
  

  // step 3. agu op pipeline.

  // step 4. wbck 

  // step 5. commit.


endmodule



