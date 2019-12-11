/////////////////////////////////////////////////////
// agu module definition.
// description: 
//   agu module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_exu_agu 
(

  input                           agu_i_agu_op  ,
  input [`AGU_INFO_WIDTH-1:0]     agu_i_agu_info,
	
  input                           agu_i_rs1_en,
  input                           agu_i_rs2_en,
  input                           agu_i_rd_en ,
  input [`XF100_XLEN-1:0]         agu_i_rs1,
  input [`XF100_XLEN-1:0]         agu_i_rs2,
  input [`XF100_RFIDX_WIDTH-1:0]  agu_i_rdidx,
  input [`XF100_XLEN-1:0]         agu_i_imm,

  output                          agu_o_ram_cs,
  output                          agu_o_ram_wen,
  output [3:0]                    agu_o_ram_mask,
  output [`XF100_DATA_RAM_AW-1:0] agu_o_ram_addr,
  output [7:0]                    agu_o_ram_wdat0,
  output [7:0]                    agu_o_ram_wdat1,
  output [7:0]                    agu_o_ram_wdat2,
  output [7:0]                    agu_o_ram_wdat3,
  input  [7:0]                    agu_o_ram_rdat0,
  input  [7:0]                    agu_o_ram_rdat1,
  input  [7:0]                    agu_o_ram_rdat2,
  input  [7:0]                    agu_o_ram_rdat3,

  output                           agu_o_wbck_en,
  output [`XF100_XLEN-1:0]         agu_o_wbck_data,
  output [`XF100_RFIDX_WIDTH-1:0]  agu_o_wbck_rdidx,


  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
  input clk,
  input rst_n

);

  wire lb_op  = agu_i_agu_info[`AGU_INFO_DEF_LB ];
  wire lh_op  = agu_i_agu_info[`AGU_INFO_DEF_LH ];
  wire lw_op  = agu_i_agu_info[`AGU_INFO_DEF_LW ];				   
  wire lbu_op = agu_i_agu_info[`AGU_INFO_DEF_LBU];
  wire lhu_op = agu_i_agu_info[`AGU_INFO_DEF_LHU];
  wire sb_op  = agu_i_agu_info[`AGU_INFO_DEF_SB ];
  wire sh_op  = agu_i_agu_info[`AGU_INFO_DEF_SH ];
  wire sw_op  = agu_i_agu_info[`AGU_INFO_DEF_SW ];

  /////////////////////////////////////////////////////
  // add and sub
  // 1. normal add and sub, these are signed add but its overflow is ommitted.
  // 2. large or small comparesion.
  //
  wire load_op  = lb_op | lh_op | lw_op | lbu_op | lhu_op;
  wire store_op = sb_op | sh_op | sw_op ;
  wire ram_wen = store_op;

  wire [`XF100_XLEN-1:0] dest_addr = agu_i_rs1 + agu_i_imm;
  wire [`XF100_DATA_RAM_AW-1:0] ram_addr = dest_addr[`XF100_DATA_RAM_AW-1:0]; 

  wire ram_cs = agu_i_agu_op;

  wire size_1B = lb_op | sb_op | lbu_op;
  wire size_2B = lh_op | sh_op | lhu_op;
  wire size_4B = lw_op | sw_op;
  
  wire [7:0] ram_wdat0 = agu_i_rs2[7 :0 ];
  wire [7:0] ram_wdat1 = agu_i_rs2[15:8 ];
  wire [7:0] ram_wdat2 = agu_i_rs2[23:16];
  wire [7:0] ram_wdat3 = agu_i_rs2[31:24];

  wire [3:0] ram_mask = {3'b000,size_1B}
                      | {2'b00, size_2B}
					  | {4{size_4B}}
					  ;

  wire unsign_dat_flag = lhu_op | lbu_op; // indicate a unsigned data from mem.

  wire agu_wbck_en = load_op;
  wire [`XF100_RFIDX_WIDTH-1:0] agu_wbck_rdidx = agu_i_rdidx;
  wire [`XF100_XLEN-1:0]  agu_wbck_wdat = 
	                                ({`XF100_XLEN{lb_op }} & {{`XF100_XLEN-8{agu_o_ram_rdat0[7]}},agu_o_ram_rdat0}) 
                                  | ({`XF100_XLEN{lbu_op}} & {{`XF100_XLEN-8{1'b0}},agu_o_ram_rdat0}) 
	                              | ({`XF100_XLEN{lh_op }} & {{`XF100_XLEN-16{agu_o_ram_rdat1[7]}},agu_o_ram_rdat1,agu_o_ram_rdat0}) 
                                  | ({`XF100_XLEN{lhu_op}} & {{`XF100_XLEN-16{1'b0}},agu_o_ram_rdat1,agu_o_ram_rdat0}) 
                                  | ({`XF100_XLEN{lw_op }} & {agu_o_ram_rdat3,agu_o_ram_rdat2,agu_o_ram_rdat1,agu_o_ram_rdat0}) 
								  ;


  assign agu_o_ram_cs     = ram_cs  ;
  assign agu_o_ram_wen    = ram_wen ;
  assign agu_o_ram_addr   = ram_addr;
  assign agu_o_ram_mask   = ram_mask;
  assign agu_o_ram_wdat0  = ram_wdat0;
  assign agu_o_ram_wdat1  = ram_wdat1;
  assign agu_o_ram_wdat2  = ram_wdat2;
  assign agu_o_ram_wdat3  = ram_wdat3;

  assign agu_o_wbck_en    = agu_wbck_en; 
  assign agu_o_wbck_data  = agu_wbck_wdat;
  assign agu_o_wbck_rdidx = agu_wbck_rdidx;


endmodule



