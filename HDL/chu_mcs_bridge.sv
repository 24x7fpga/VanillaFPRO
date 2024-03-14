/////////////////////////////////////////////////////////////////////////////////
//		MCS I/O BUS				FPRO BUS
//-------------------------------------------------------------------------------
//	1. io_addr_strobe (not used)			  -
//	2. io_read_strobe		 		fp_rd
//	3. io_write_strobe				fp_wr
//	4. io_byte_enable(not used)			  -
//	5. io_address					fp_addr
//	6. io_write_data				fp_wr_data
//	7. io_read_data					fp_rd_data
//	8. io_ready					1 = set to one
/////////////////////////////////////////////////////////////////////////////////

module chu_mcs_bridge #(parameter BRG_BASE = 32'hc000_0000) (/*AUTOARG*/
   // Outputs
   io_read_data, io_ready, fp_video_cs, fp_mmio_cs, fp_wr, fp_rd,
   fp_addr, fp_wr_data,
   // Inputs
   io_addr_strobe, io_read_strobe, io_write_strobe, io_byte_enable,
   io_address, io_write_data, fp_rd_data
   );

   // uBLaze MCS I/O bus
   input  logic io_addr_strobe;                 // master to slave
   input  logic io_read_strobe;			// master to slave
   input  logic io_write_strobe;		// master to slave
   input  logic [3:0] io_byte_enable;		// master to slave
   input  logic [31:0] io_address;		// master to slave
   input  logic [31:0] io_write_data;		// master to slave
   output logic [31:0] io_read_data;		// slave to master
   output logic 	      io_ready;		// slave to master
   
   // FPRO bus
   output logic 	      fp_video_cs;
   output logic 	      fp_mmio_cs;
   output logic 	      fp_wr;
   output logic 	      fp_rd;
   output logic [20:0] 	      fp_addr;
   output logic [31:0] 	      fp_wr_data;
   input  logic [31:0] 	      fp_rd_data;

   // signal declaration
   logic 		      mcs_bridge_en;
   logic [29:0] 	      word_addr;

   // address translation and decoding
   // 2 LSBs are "00" due to word alignment
   // MCS is byte addressable and the design is word addressable
   assign word_addr     = io_address[31:2];
   assign mcs_bridge_en = (io_address[31:24] == BRG_BASE[31:24]);	// 0xc000_0000
   assign fp_video_cs   = (mcs_bridge_en && io_address[23] == 1);	// selects video subsytem
   assign fp_mmio_cs    = (mcs_bridge_en && io_address[23] == 0);	// selects MMIO subsystem
   assign fp_addr       = word_addr[20:0];				// word addressable address => 2^6 = 64 slots and 2^5 = i/o registers 
   //  control line conversion 
   assign fp_wr        = io_write_strobe;
   assign fp_rd        = io_read_strobe;
   assign io_ready     = 1;   			// not used ; transaction done in 1 clock
   // data line conversion
   assign fp_wr_data   = io_write_data;
   assign io_read_data = fp_rd_data; 

endmodule // chu_mcs_bridge
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/VanillaFPRO/*")
// End:
