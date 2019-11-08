/////////////////////////////////////////////////////
// decode module definition.
// description: 
//   decode module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_exu_decode 
(
  input [`XF100_INSTR_SIZE-1:0] dec_i_instr,

  output dec_o_alu_op  ,
  output [`ALU_INFO_WIDTH-1:0] dec_o_alu_info,
	
  output dec_o_rs1_en,
  output dec_o_rs2_en,
  output dec_o_rd_en ,
  output [`XF100_RFIDX_WIDTH-1:0]  dec_o_rs1_idx,
  output [`XF100_RFIDX_WIDTH-1:0]  dec_o_rs2_idx,
  output [`XF100_RFIDX_WIDTH-1:0]  dec_o_rd_idx ,

  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
  input clk,
  input rst_n

);


  wire [`XF100_INSTR_SIZE-1:0] instr = dec_i_instr;


  // extract opcode form instr.
  wire [6:0] opcode = instr[6:0];

  wire opcode_0110011 = (opcode == 7'b0110011);

  // extract funct3 form instr.
  wire [2:0] funct3 = instr[14:12];

  wire funct3_000 = (funct3 == 3'b000);

  // extract rs and rd field form instr.
  wire [4:0] rd_idx  = instr[11:7];
  wire [4:0] rs1_idx = instr[19:15];
  wire [4:0] rs2_idx = instr[24:20];
   
  
  // extract funct7 form instr.
  wire [6:0] funct7 = instr[31:25];

  wire funct7_0000000 = (funct7 == 7'b0000000);
  


  wire add_op = (funct7_0000000 & funct3_000 & opcode_0110011);

  wire bxx_op = 1'b0; // TODO
   
  wire op_no_rs_rd =  1'b0   // op without rs and rd.
                    ////| fence_op   
				    ////| fence_i_op
				    ////| ecall_op
				    ////| ebreak_op
				    ;

  wire op_no_rd = (rd_idx == 5'b00000)
                | bxx_op
				////| store_op
				////| op_no_rs_rd
				;

  wire rd_en = ~(op_no_rd);

  wire op_no_rs1 = (rs1_idx == 5'b00000)
                 //// | lui_op
				 //// | auipc_op
				 //// | jal_op
				 //// | op_no_rs_rd
				 //// | csrrwi
				 //// | csrrsi
				 //// | csrrci
				 ;
  wire rs1_en = ~(op_no_rs1);


  wire rs2_en = (rs1_idx != 5'b00000)
               & (   bxx_op
				   ////| store_op
				   | add_op
				 )
				 ;

  wire alu_op = 1'b0
              | add_op
			  ;
  wire [`ALU_INFO_WIDTH-1:0] alu_info;
  assign alu_info[`ALU_INFO_DEF_ADD] = add_op;


  assign dec_o_alu_op = alu_op; 				 
  assign dec_o_alu_info = alu_info;

  assign dec_o_rd_en = rd_en;
  assign dec_o_rs1_en = rs1_en;
  assign dec_o_rs2_en = rs2_en;
  assign dec_o_rd_idx = rd_idx;
  assign dec_o_rs1_idx = rs1_idx;
  assign dec_o_rs2_idx = rs2_idx;



endmodule



