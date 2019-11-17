/////////////////////////////////////////////////////
// regfile module definition.
// description: 
//   regfile module, two read ports and one write port. 
// version: 1.0
/////////////////////////////////////////////////////

`include "xf100_defines.v" 

module xf100_exu_regfile 
(
  // read port
  input                            rf_i_read_en1,
  input [`XF100_RFIDX_WIDTH-1:0]   rf_i_read_rsidx1,
  output [`XF100_XLEN-1:0]         rf_o_read_data1,

  input                            rf_i_read_en2,
  input  [`XF100_RFIDX_WIDTH-1:0]  rf_i_read_rsidx2,
  output [`XF100_XLEN-1:0]         rf_o_read_data2,

  //write port
  input                            rf_i_wr_en,
  input [`XF100_XLEN-1:0]          rf_i_wr_data,
  input [`XF100_RFIDX_WIDTH-1:0]   rf_i_wr_rdidx,


  input clk,
  input rst_n

);

  wire [`XF100_XLEN-1 :0] rf_r [31:0];

  wire                            wr_en    = rf_i_wr_en    ;
  wire [`XF100_XLEN-1:0]          wr_data  = rf_i_wr_data  ;
  wire [`XF100_RFIDX_WIDTH-1:0]   wr_idx = rf_i_wr_rdidx ;

  wire                           read_en1    = rf_i_read_en1    ;
  wire [`XF100_RFIDX_WIDTH-1:0]  read_rsidx1 = rf_i_read_rsidx1 ;
  wire                           read_en2    = rf_i_read_en2    ;
  wire [`XF100_RFIDX_WIDTH-1:0]  read_rsidx2 = rf_i_read_rsidx2 ;



  wire [31:0] rf_wen;
  wire [`XF100_XLEN-1 :0] rf_wdat [31:0];
  wire [`XF100_XLEN-1 :0] rf_rs1 ;
  wire [`XF100_XLEN-1 :0] rf_rs2 ;
  genvar i;
  generate
    for (i=0; i<32; i=i+1) begin:rf
	  // write rd
      assign rf_wen[i]  = wr_en & (i[`XF100_RFIDX_WIDTH-1:0] == wr_idx);
	  assign rf_wdat[i] = wr_data;
	  
	  xf100_dfflr #(`XF100_XLEN) rf_dfflr(rf_wen[i], rf_wdat[i], rf_r[i], clk, rst_n); 
	end
  endgenerate

  // read rs
  assign rf_rs1 = {`XF100_XLEN{read_en1}} & rf_r[read_rsidx1]; 
  assign rf_rs2 = {`XF100_XLEN{read_en2}} & rf_r[read_rsidx2]; 

  assign  rf_o_read_data1  =  rf_rs1; 
  assign  rf_o_read_data2  =  rf_rs2; 
endmodule



