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
  wire  [`XF100_XLEN-1:0       ]   dec_imm ;


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
	.dec_o_imm     (dec_imm   ),

    .clk  (clk  ),
    .rst_n(rst_n)
  );

  // step 2: regfile
  wire                           rf_wbck_en  ;                           
  wire [`XF100_XLEN-1:0]         rf_wbck_data;        
  wire [`XF100_RFIDX_WIDTH-1:0]  rf_wbck_idx ;

  wire [`XF100_XLEN-1:0]         rf_rs1;        
  wire [`XF100_XLEN-1:0]         rf_rs2;        
  xf100_exu_regfile u_xf100_exu_regfile 
  (
    // read port
    .rf_i_read_en1    (dec_rs1_en ),
    .rf_i_read_rsidx1 (dec_rs1_idx),
    .rf_o_read_data1  (rf_rs1),

    .rf_i_read_en2    (dec_rs2_en ),
    .rf_i_read_rsidx2 (dec_rs2_idx),
    .rf_o_read_data2  (rf_rs2),

    //write port
    .rf_i_wr_en       (rf_wbck_en  ),
    .rf_i_wr_data     (rf_wbck_data),
    .rf_i_wr_rdidx    (rf_wbck_idx ),


    .clk  (clk  ),
    .rst_n(rst_n)

);



  // step 2: alu op pipeline.
  wire                           wbck_en;                           
  wire [`XF100_XLEN-1:0]         wbck_data;        
  wire [`XF100_RFIDX_WIDTH-1:0]  wbck_idx ;

  xf100_exu_alu u_xf100_exu_alu
  (

    .alu_i_alu_op     (dec_alu_op      ),
    .alu_i_alu_info   (dec_alu_info    ),
	
    .alu_i_rs1_en     (1'b0            ), // not uesed here. 
    .alu_i_rs2_en     (1'b0            ), // not uesed here.
    .alu_i_rd_en      (dec_rd_en       ),
    .alu_i_rs1        (rf_rs1          ),
    .alu_i_rs2        (rf_rs2          ),
    .alu_i_rdidx      (dec_rd_idx      ),
    .alu_i_imm        (dec_imm         ),


    .alu_o_wbck_en    (wbck_en         ),
    .alu_o_wbck_data  (wbck_data       ),
    .alu_o_wbck_rdidx (wbck_idx        ),


  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
    .clk  (clk  ),
    .rst_n(rst_n)

  );


  // step 3. agu op pipeline.

  // step 4. wbck 

  xf100_exu_wbck u_xf100_exu_wbck 
  (

    .wbck_i_wbck_en   (wbck_en     ),
    .wbck_i_wbck_data (wbck_data   ),
    .wbck_i_wbck_rdidx(wbck_idx    ),

    .wbck_o_wbck_en   (rf_wbck_en  ),
    .wbck_o_wbck_data (rf_wbck_data),
    .wbck_o_wbck_rdidx(rf_wbck_idx ),


  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
    .clk  (clk  ),
    .rst_n(rst_n)

);
  // step 5. commit.


endmodule



