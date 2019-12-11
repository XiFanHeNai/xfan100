
///////////////////  CORE_DEFINE /////////////////////////
`define XF100_INSTR_SIZE     32
`define XF100_PC_SIZE        32
`define XF100_RFIDX_WIDTH    5
`define XF100_XLEN           32
`define XF100_ADDR_SIZE      32



`define XF100_DATA_RAM_AW    16
`define XF100_DATA_RAM_DW    32
`define XF100_DATA_RAM_DP    16384


///////////////////  DECODE_DEFINE /////////////////////////
// ALU INFO DEFINE
`define ALU_INFO_DEF_BASE  0
`define ALU_INFO_DEF_HAS_IMM    `ALU_INFO_DEF_BASE
`define ALU_INFO_DEF_ADD_LSB    `ALU_INFO_DEF_HAS_IMM+1
`define ALU_INFO_DEF_ADD_MSB    `ALU_INFO_DEF_ADD_LSB+1-1
`define ALU_INFO_DEF_ADD        `ALU_INFO_DEF_ADD_MSB:`ALU_INFO_DEF_ADD_LSB
`define ALU_INFO_DEF_SUB_LSB    `ALU_INFO_DEF_ADD_MSB+1
`define ALU_INFO_DEF_SUB_MSB    `ALU_INFO_DEF_SUB_LSB+1-1
`define ALU_INFO_DEF_SUB        `ALU_INFO_DEF_SUB_MSB:`ALU_INFO_DEF_SUB_LSB
`define ALU_INFO_DEF_SLL_LSB    `ALU_INFO_DEF_SUB_MSB+1
`define ALU_INFO_DEF_SLL_MSB    `ALU_INFO_DEF_SLL_LSB+1-1
`define ALU_INFO_DEF_SLL        `ALU_INFO_DEF_SLL_MSB:`ALU_INFO_DEF_SLL_LSB
`define ALU_INFO_DEF_SLT_LSB    `ALU_INFO_DEF_SLL_MSB+1
`define ALU_INFO_DEF_SLT_MSB    `ALU_INFO_DEF_SLT_LSB+1-1
`define ALU_INFO_DEF_SLT        `ALU_INFO_DEF_SLT_MSB:`ALU_INFO_DEF_SLT_LSB
`define ALU_INFO_DEF_SLTU_LSB   `ALU_INFO_DEF_SLT_MSB+1
`define ALU_INFO_DEF_SLTU_MSB   `ALU_INFO_DEF_SLTU_LSB+1-1
`define ALU_INFO_DEF_SLTU       `ALU_INFO_DEF_SLTU_MSB:`ALU_INFO_DEF_SLTU_LSB
`define ALU_INFO_DEF_XOR_LSB    `ALU_INFO_DEF_SLTU_MSB+1
`define ALU_INFO_DEF_XOR_MSB    `ALU_INFO_DEF_XOR_LSB+1-1
`define ALU_INFO_DEF_XOR        `ALU_INFO_DEF_XOR_MSB:`ALU_INFO_DEF_XOR_LSB
`define ALU_INFO_DEF_SRL_LSB    `ALU_INFO_DEF_XOR_MSB+1
`define ALU_INFO_DEF_SRL_MSB    `ALU_INFO_DEF_SRL_LSB+1-1
`define ALU_INFO_DEF_SRL        `ALU_INFO_DEF_SRL_MSB:`ALU_INFO_DEF_SRL_LSB
`define ALU_INFO_DEF_SRA_LSB    `ALU_INFO_DEF_SRL_MSB+1
`define ALU_INFO_DEF_SRA_MSB    `ALU_INFO_DEF_SRA_LSB+1-1
`define ALU_INFO_DEF_SRA        `ALU_INFO_DEF_SRA_MSB:`ALU_INFO_DEF_SRA_LSB
`define ALU_INFO_DEF_OR_LSB     `ALU_INFO_DEF_SRA_MSB+1
`define ALU_INFO_DEF_OR_MSB     `ALU_INFO_DEF_OR_LSB+1-1
`define ALU_INFO_DEF_OR         `ALU_INFO_DEF_OR_MSB:`ALU_INFO_DEF_OR_LSB
`define ALU_INFO_DEF_AND_LSB    `ALU_INFO_DEF_OR_MSB+1
`define ALU_INFO_DEF_AND_MSB    `ALU_INFO_DEF_AND_LSB+1-1
`define ALU_INFO_DEF_AND        `ALU_INFO_DEF_AND_MSB:`ALU_INFO_DEF_AND_LSB
`define ALU_INFO_DEF_LUI_LSB    `ALU_INFO_DEF_AND_MSB+1
`define ALU_INFO_DEF_LUI_MSB    `ALU_INFO_DEF_LUI_LSB+1-1
`define ALU_INFO_DEF_LUI        `ALU_INFO_DEF_LUI_MSB:`ALU_INFO_DEF_LUI_LSB

`define ALU_INFO_WIDTH  `ALU_INFO_DEF_LUI_MSB+1

// AGU INFO DEFINE
`define AGU_INFO_DEF_BASE  0
`define AGU_INFO_DEF_HAS_IMM    `AGU_INFO_DEF_BASE
`define AGU_INFO_DEF_LB_LSB     `AGU_INFO_DEF_HAS_IMM+1
`define AGU_INFO_DEF_LB_MSB     `AGU_INFO_DEF_LB_LSB+1-1
`define AGU_INFO_DEF_LB         `AGU_INFO_DEF_LB_MSB:`AGU_INFO_DEF_LB_LSB
`define AGU_INFO_DEF_LH_LSB     `AGU_INFO_DEF_LB_MSB+1
`define AGU_INFO_DEF_LH_MSB     `AGU_INFO_DEF_LH_LSB+1-1
`define AGU_INFO_DEF_LH         `AGU_INFO_DEF_LH_MSB:`AGU_INFO_DEF_LH_LSB
`define AGU_INFO_DEF_LW_LSB     `AGU_INFO_DEF_LH_MSB+1
`define AGU_INFO_DEF_LW_MSB     `AGU_INFO_DEF_LW_LSB+1-1
`define AGU_INFO_DEF_LW         `AGU_INFO_DEF_LW_MSB:`AGU_INFO_DEF_LW_LSB
`define AGU_INFO_DEF_LBU_LSB    `AGU_INFO_DEF_LW_MSB+1
`define AGU_INFO_DEF_LBU_MSB    `AGU_INFO_DEF_LBU_LSB+1-1
`define AGU_INFO_DEF_LBU        `AGU_INFO_DEF_LBU_MSB:`AGU_INFO_DEF_LBU_LSB
`define AGU_INFO_DEF_LHU_LSB    `AGU_INFO_DEF_LBU_MSB+1
`define AGU_INFO_DEF_LHU_MSB    `AGU_INFO_DEF_LHU_LSB+1-1
`define AGU_INFO_DEF_LHU        `AGU_INFO_DEF_LHU_MSB:`AGU_INFO_DEF_LHU_LSB
`define AGU_INFO_DEF_SB_LSB     `AGU_INFO_DEF_LHU_MSB+1
`define AGU_INFO_DEF_SB_MSB     `AGU_INFO_DEF_SB_LSB+1-1
`define AGU_INFO_DEF_SB         `AGU_INFO_DEF_SB_MSB:`AGU_INFO_DEF_SB_LSB
`define AGU_INFO_DEF_SH_LSB     `AGU_INFO_DEF_SB_MSB+1
`define AGU_INFO_DEF_SH_MSB     `AGU_INFO_DEF_SH_LSB+1-1
`define AGU_INFO_DEF_SH         `AGU_INFO_DEF_SH_MSB:`AGU_INFO_DEF_SH_LSB
`define AGU_INFO_DEF_SW_LSB     `AGU_INFO_DEF_SH_MSB+1
`define AGU_INFO_DEF_SW_MSB     `AGU_INFO_DEF_SW_LSB+1-1
`define AGU_INFO_DEF_SW         `AGU_INFO_DEF_SW_MSB:`AGU_INFO_DEF_SW_LSB
`define AGU_INFO_WIDTH          `AGU_INFO_DEF_SW_MSB+1


