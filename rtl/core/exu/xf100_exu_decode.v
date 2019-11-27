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

  output [`XF100_XLEN-1:0]  dec_o_imm ,
  // the decode is a combination logic and doesn't need clk and rst.
  // here we just use it for placeholder.
  input clk,
  input rst_n

);


  wire [`XF100_INSTR_SIZE-1:0] instr = dec_i_instr;


  // extract opcode form instr.
  wire [6:0] opcode = instr[6:0];

  wire opcode_0110011 = (opcode == 7'b0110011);// ALU-R Type
  wire opcode_0010011 = (opcode == 7'b0010011);// ALU-I Type

  wire opcode_0110111 = (opcode == 7'b0110111);// LUI OP, Classified into ALU-I Type

  // extract funct3 form instr.
  wire [2:0] funct3 = instr[14:12];

  wire funct3_000 = (funct3 == 3'b000);
  wire funct3_001 = (funct3 == 3'b001);
  wire funct3_010 = (funct3 == 3'b010);
  wire funct3_011 = (funct3 == 3'b011);
  wire funct3_100 = (funct3 == 3'b100);
  wire funct3_101 = (funct3 == 3'b101);
  wire funct3_110 = (funct3 == 3'b110);
  wire funct3_111 = (funct3 == 3'b111);

  // extract rs and rd field form instr.
  wire [4:0] rd_idx  = instr[11:7];
  wire [4:0] rs1_idx = instr[19:15];
  wire [4:0] rs2_idx = instr[24:20];
   
  wire [`XF100_XLEN-1:0] imm = {instr[31:12],12'h0};
  
  // extract funct7 form instr.
  wire [6:0] funct7 = instr[31:25];

  wire funct7_0000000 = (funct7 == 7'b0000000);
  wire funct7_0100000 = (funct7 == 7'b0100000);
  
  wire lui_op = (opcode_0110111);


  wire add_op  = (funct7_0000000 & funct3_000 & opcode_0110011);
  wire sub_op  = (funct7_0100000 & funct3_000 & opcode_0110011);
  wire sll_op  = (funct7_0000000 & funct3_001 & opcode_0110011);
  wire slt_op  = (funct7_0000000 & funct3_010 & opcode_0110011);
  wire sltu_op = (funct7_0000000 & funct3_011 & opcode_0110011);
  wire xor_op  = (funct7_0000000 & funct3_100 & opcode_0110011);
  wire srl_op  = (funct7_0000000 & funct3_101 & opcode_0110011);
  wire sra_op  = (funct7_0100000 & funct3_101 & opcode_0110011);
  wire or_op   = (funct7_0000000 & funct3_110 & opcode_0110011);
  wire and_op  = (funct7_0000000 & funct3_111 & opcode_0110011);

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
                 | lui_op
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
                   | sub_op 
                   | sll_op 				   
                   | slt_op 
                   | sltu_op
                   | xor_op 
                   | srl_op 
                   | sra_op 
                   | or_op  
                   | and_op 
				 )
				 ;

  wire alu_op = 1'b0
               | lui_op
			   | add_op
               | sub_op 
               | sll_op 				   
               | slt_op 
               | sltu_op
               | xor_op 
               | srl_op 
               | sra_op 
               | or_op  
               | and_op 
			  ;
  wire [`ALU_INFO_WIDTH-1:0] alu_info;
  assign alu_info[`ALU_INFO_DEF_ADD]  = add_op ;
  assign alu_info[`ALU_INFO_DEF_SUB]  = sub_op ;
  assign alu_info[`ALU_INFO_DEF_SLL]  = sll_op ;
  assign alu_info[`ALU_INFO_DEF_SLT]  = slt_op ;
  assign alu_info[`ALU_INFO_DEF_SLTU] = sltu_op;
  assign alu_info[`ALU_INFO_DEF_XOR]  = xor_op ;
  assign alu_info[`ALU_INFO_DEF_SRL]  = srl_op ;
  assign alu_info[`ALU_INFO_DEF_SRA]  = sra_op ;
  assign alu_info[`ALU_INFO_DEF_OR ]  = or_op  ;
  assign alu_info[`ALU_INFO_DEF_AND]  = and_op ;
  assign alu_info[`ALU_INFO_DEF_LUI]  = lui_op ;


  assign dec_o_alu_op = alu_op; 				 
  assign dec_o_alu_info = alu_info;

  assign dec_o_rd_en = rd_en;
  assign dec_o_rs1_en = rs1_en;
  assign dec_o_rs2_en = rs2_en;
  assign dec_o_rd_idx = rd_idx;
  assign dec_o_rs1_idx = rs1_idx;
  assign dec_o_rs2_idx = rs2_idx;

  assign dec_o_imm  = imm;


endmodule



