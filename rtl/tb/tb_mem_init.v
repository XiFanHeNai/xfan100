/////////////////////////////////////////////////////
// tb_mem_init
// description: 
//   init the instruction mem. 
// version: 1.0
/////////////////////////////////////////////////////

`include "tb_defines.v" 

module tb_mem_init 
(
  output [`INSTR_SIZE-1:0] instr,

  input sys_clk,
  input sys_rst_n
);

localparam [31:0] INST_MEM_DP = 32'd16384;

reg [7:0] mem [0:INST_MEM_DP-1];
initial begin
  $readmemh("/home/baicai/__working/project/XFAN/xfan100/testcases/riscv-tests/isa/generated/rv32ui-p-add.verilog",mem);
end


reg [31:0] addr;
always @ (posedge sys_clk or negedge sys_rst_n) begin
  if (sys_rst_n == 1'b0) begin
	  addr <= 32'b0;
  end else begin
      addr <= addr + 4;
  end
end

assign `IFU.instr[7 : 0] = mem [addr];
assign `IFU.instr[15: 8] = mem [addr+1];
assign `IFU.instr[23:16] = mem [addr+2];
assign `IFU.instr[31:24] = mem [addr+3];

endmodule



