/////////////////////////////////////////////////////
// tb_top
// description: the first version of tb top.  
/////////////////////////////////////////////////////

`include "tb_defines.v" 

module tb_top;


reg sys_clk;
reg sys_rst_n;

reg [31:0] cycle_cnt;
always @(posedge sys_clk or negedge sys_rst_n) begin
if( sys_rst_n == 1'b0)
      cycle_cnt <= 32'b0;
  else 
      cycle_cnt <= cycle_cnt+1;
end

always @(posedge sys_clk) begin
     if(cycle_cnt == 32'h800) begin
         $display ("Hit max cycle count.. stopping");
         $finish;
     end
end





initial
begin
	$fsdbDumpfile("tb_top.fsdb");
	$fsdbDumpvars(0,tb_top,"+mda");
end

initial begin
  sys_clk <= 1'b0;
  sys_rst_n <= 1'b0;
  #2000 sys_rst_n <= 1'b1;
  //// TODO: another reset during the simulation.
end

always begin
  #10 sys_clk <= ~sys_clk;
end

wire [`INSTR_SIZE-1:0] instr;
tb_mem_init u_tb_mem_init(
  .instr(instr),
  .sys_clk(sys_clk),
  .sys_rst_n(sys_rst_n)
);



endmodule

