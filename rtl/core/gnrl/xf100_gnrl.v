/////////////////////////////////////////////////////
// gnrl module definition.
// description: 
//   all general module. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

////////////////////////////////////////////////////
// dff with reset and load function.
module xf100_dfflr 
#( 
  parameter DW = 8
)
(
  input           en,
  input  [DW-1:0] din,
  output reg [DW-1:0] qout,

  input clk,
  input rst_n
);
  always @ (posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
	  qout <= {DW{1'b0}};
	end else begin
	  if (en == 1'b1) begin
		qout <= din;
	  end else begin
		qout <= qout;
	  end
	end
  end
endmodule



