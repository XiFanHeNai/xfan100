/////////////////////////////////////////////////////
// gnrl module definition.
// description: 
//   all general module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

////////////////////////////////////////////////////
// dff model with reset and load.
module xf100_dfflr 
#( 
  parameter DW = 8
)
(
  input           en,
  input  [DW-1:0] din,
  output [DW-1:0] qout,

  input clk,
  input rst_n
);
  reg [DW-1:0] qout_r;
  always @ (posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
	  qout_r <= {DW{1'b0}};
	end else begin
	  if (en == 1'b1) begin
		qout_r <= din;
	  end else begin
		qout_r <= qout_r;
	  end
	end
  end
  assign qout = qout_r;
endmodule


////////////////////////////////////////////////////
// ram model.
module xf100_ram 
#( 
  parameter AW = 8,
  parameter DP = 8
)
(
  input            ram_cs   ,
  input            ram_wen  ,
  input   [3:0]    ram_mask ,
  input   [AW-1:0] ram_addr ,
  input   [7:0]    ram_wdat0,
  input   [7:0]    ram_wdat1,
  input   [7:0]    ram_wdat2,
  input   [7:0]    ram_wdat3,
  output  [7:0]    ram_rdat0,
  output  [7:0]    ram_rdat1,
  output  [7:0]    ram_rdat2,
  output  [7:0]    ram_rdat3,

  input clk,
  input rst_n
);

  reg [31:0] mem_r[0:DP-1];
  wire [31:0] tmp_ram_wdat = mem_r[ram_addr];
  /////////////////////////////
  // write ram, new value is valid from the next cycle.
  always @ (posedge clk) begin
	if (ram_cs & ram_wen) begin
	  mem_r[ram_addr] <= {
		                   (ram_mask[0] ? ram_wdat0 : tmp_ram_wdat[7 :0 ]),
		                   (ram_mask[1] ? ram_wdat1 : tmp_ram_wdat[15:8 ]),
		                   (ram_mask[2] ? ram_wdat2 : tmp_ram_wdat[23:16]),
		                   (ram_mask[3] ? ram_wdat3 : tmp_ram_wdat[31:24])
						 };
	end
  end

  /////////////////////////////
  // read ram, new value is valid right now.
  wire [31:0] tmp_ram_rdat = mem_r[ram_addr];
  assign ram_rdat0 = {8{ram_cs & (~ram_wen)}} & tmp_ram_rdat[0];
  assign ram_rdat1 = {8{ram_cs & (~ram_wen)}} & tmp_ram_rdat[1];
  assign ram_rdat2 = {8{ram_cs & (~ram_wen)}} & tmp_ram_rdat[2];
  assign ram_rdat3 = {8{ram_cs & (~ram_wen)}} & tmp_ram_rdat[3];

endmodule



