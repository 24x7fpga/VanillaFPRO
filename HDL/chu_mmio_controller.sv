module chu_mmio_controller (/*AUTOARG*/
   // Outputs
   slot_cs_array, slot_mem_rd_array, slot_mem_wr_array,
   slot_reg_addr_array, slot_wr_data_array,
   // Inputs
   clk, rst, mmio_cs, mmio_wr, mmio_rd, mmio_addr, mmio_wr_data,
   mmio_rd_data, slot_rd_data_array
   );
   // FPRO bus
   input  logic clk;
   input  logic rst;
   input  logic mmio_cs;
   input  logic mmio_wr;
   input  logic mmio_rd;
   input  logic [20:0] mmio_addr;
   input  logic [31:0] mmio_wr_data;
   output logic [31:0] mmio_rd_data;
   // slot interface
   output logic [63:0] slot_cs_array;
   output logic [63:0] slot_mem_rd_array;
   output logic [63:0] slot_mem_wr_array;
   output logic [4 :0] slot_reg_addr_array [63:0];
   input  logic [31:0] slot_rd_data_array [63:0];
   output logic [31:0] slot_wr_data_array [63:0];

   // declaration
   logic [5:0] 	       slot_addr;
   logic [4:0] 	       reg_addr;

   assign slot_addr = mmio_addr[10:5];
   assign reg_addr  = mmio_addr[ 4:0];

   //address decoding
   always_comb begin
      slot_cs_array = 0;
      if(mmio_cs)
	slot_cs_array[slot_addr] = 1;
   end

   // broadcast all slots
   generate
      genvar i;
      for(i = 0; i < 64; i = i+1)
	begin: slot_signal_gen
	   assign slot_mem_rd_array[i]   = mmio_rd;
	   assign slot_mem_wr_array[i]   = mmio_wr;
	   assign slot_wr_data_array[i]  = mmio_wr_data;
	   assign slot_reg_addr_array[i] = reg_addr;
	end
      endgenerate

   // mux for read data
   assign mmio_rd_data = slot_rd_data_array[slot_addr];

endmodule // chu_mmio_controller
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/VanillaFPRO/*")
// End:
   
