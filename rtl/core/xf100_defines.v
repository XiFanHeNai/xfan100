
///////////////////  CORE_DEFINE /////////////////////////
`define XF100_INSTR_SIZE     32
`define XF100_PC_SIZE        32
`define XF100_RFIDX_WIDTH    5
`define XF100_XLEN           32



///////////////////  DECODE_DEFINE /////////////////////////
`define ALU_INFO_DEF_BASE  0
`define ALU_INFO_DEF_ADD_LSB   `ALU_INFO_DEF_BASE
`define ALU_INFO_DEF_ADD_MSB   `ALU_INFO_DEF_ADD_LSB+1-1
`define ALU_INFO_DEF_ADD       `ALU_INFO_DEF_ADD_MSB:`ALU_INFO_DEF_ADD_LSB

`define ALU_INFO_WIDTH  `ALU_INFO_DEF_ADD_MSB

