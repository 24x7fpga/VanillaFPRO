module mcs_top_vanilla #(parameter BRG_BASE = 32'hc000_0000) (/*AUTOARG*/
   // Outputs
   led, tx,
   // Inputs
   clk, rst, sw, rx, btn
   );
   input  logic clk; // 125MHz
   input  logic rst;
   // switches and leds
   input  logic [3:0] sw;
   output logic [3:0] led;
   input  logic [2:0] btn;
   //uart
   input  logic 	     rx;
   output logic 	     tx;


   // MCS IO bus
   logic 		     io_addr_strobe;
   logic 		     io_read_strobe;
   logic 		     io_write_strobe;
   logic [3:0] 		     io_byte_enable;
   logic [31:0] 	     io_address;
   logic [31:0] 	     io_write_data;
   logic [31:0] 	     io_read_data;
   // FPRO Bus
   logic 		     fp_mmio_cs;
   logic 		     fp_wr;
   logic 		     fp_rd;
   logic [20:0] 	     fp_addr;
   logic [31:0] 	     fp_wr_data;
   logic [31:0] 	     fp_rd_data;



   //initantiate uBlaze MCS
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
cpu MAIN_CPU (
  .Clk(clk),                          // input wire Clk
  .Reset(rst),                        // input wire Reset
  .IO_addr_strobe(io_addr_strobe),    // output wire IO_addr_strobe
  .IO_address(io_address),            // output wire [31 : 0] IO_address
  .IO_byte_enable(io_byte_enable),    // output wire [3 : 0] IO_byte_enable
  .IO_read_data(io_read_data),        // input wire [31 : 0] IO_read_data
  .IO_read_strobe(io_read_strobe),    // output wire IO_read_strobe
  .IO_ready(io_ready),                // input wire IO_ready
  .IO_write_data(io_write_data),      // output wire [31 : 0] IO_write_data
  .IO_write_strobe(io_write_strobe)   // output wire IO_write_strobe
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

   // instantiate bridge
   chu_mcs_bridge #(/*AUTOINSTPARAM*/
		    // Parameters
		    .BRG_BASE		(BRG_BASE)) BRIDGE_UNIT (/*AUTOINST*/
								 // Outputs
								 .io_read_data		(io_read_data[31:0]),
								 .io_ready		(io_ready),
								 .fp_video_cs		(fp_video_cs),
								 .fp_mmio_cs		(fp_mmio_cs),
								 .fp_wr			(fp_wr),
								 .fp_rd			(fp_rd),
								 .fp_addr		(fp_addr[20:0]),
								 .fp_wr_data		(fp_wr_data[31:0]),
								 // Inputs
								 .io_addr_strobe	(io_addr_strobe),
								 .io_read_strobe	(io_read_strobe),
								 .io_write_strobe	(io_write_strobe),
								 .io_byte_enable	(io_byte_enable[3:0]),
								 .io_address		(io_address[31:0]),
								 .io_write_data		(io_write_data[31:0]),
								 .fp_rd_data		(fp_rd_data[31:0]));

   // instantiate i/0 subsystem
   mmio_sys_vanilla #(// hard core the parameter here:
		      // Parameters
		      .N_SW		(4),
		      .N_LED		(4),
		      .N_BTN		(3)) MMIO_UNIT (
							    // Outputs
							    .mmio_rd_data	(fp_rd_data[31:0]),
							    .led		(led),
							    .tx			(tx),
							    // Inputs
							    .clk		(clk),
							    .rst		(rst),
							    .mmio_cs		(fp_mmio_cs),
							    .mmio_wr		(fp_wr),
							    .mmio_rd		(fp_rd),
							    .mmio_addr		(fp_addr[20:0]),
							    .mmio_wr_data	(fp_wr_data[31:0]),
							    .btn        (btn),
							    .sw			(sw),
							    .rx			(rx));

endmodule // mcs_top_vanilla
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/VanillaFPRO/*")
// End:

     
   
