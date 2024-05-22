`include "chu_io_map.svh"
module mmio_sys_vanilla #(parameter N_SW = 4, parameter N_LED = 4, parameter N_BTN = 3) (/*AUTOARG*/
   // Outputs
   mmio_rd_data, led, tx,
   // Inputs
   clk, rst, mmio_cs, mmio_wr, mmio_rd, mmio_addr, mmio_wr_data, sw, btn,
   rx
   );
   input  logic clk;
   input  logic rst;
   // FPRO Bus
   input logic mmio_cs;
   input  logic mmio_wr;
   input  logic mmio_rd;
   input  logic [20:0] mmio_addr;
   input  logic [31:0] mmio_wr_data;
   output logic [31:0] mmio_rd_data;
   // switches 
   input  logic [N_SW-1:0] sw;
   // push buttons
   input  logic [N_BTN-1:0] btn;
   // leds
   output logic [N_LED-1:0] led;

   

   
   /*AUTOREG*/

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   logic [63:0]		slot_cs_array;		// From CTRL_UNIT of chu_mmio_controller.v
   logic [63:0]		slot_mem_rd_array;	// From CTRL_UNIT of chu_mmio_controller.v
   logic [63:0]		slot_mem_wr_array;	// From CTRL_UNIT of chu_mmio_controller.v
   logic [4:0]		slot_reg_addr_array [63:0];// From CTRL_UNIT of chu_mmio_controller.v
   logic [31:0]		slot_wr_data_array [63:0];// From CTRL_UNIT of chu_mmio_controller.v
   // End of automatics

  
   logic [31:0]		slot_rd_data_array [63:0];// From CTRL_UNIT of chu_mmio_controller.v
   
   // intantiat mmio controller
   chu_mmio_controller CTRL_UNIT (/*AUTOINST*/
				  // Outputs
				  .mmio_rd_data		(mmio_rd_data[31:0]),
				  .slot_cs_array	(slot_cs_array[63:0]),
				  .slot_mem_rd_array	(slot_mem_rd_array[63:0]),
				  .slot_mem_wr_array	(slot_mem_wr_array[63:0]),
				  .slot_reg_addr_array	(slot_reg_addr_array/*[4:0].[63:0]*/),
				  .slot_wr_data_array	(slot_wr_data_array/*[31:0].[63:0]*/),
				  // Inputs
				  .clk			 (clk),
				  .rst			 (rst),
				  .mmio_cs		 (mmio_cs),
				  .mmio_wr		 (mmio_wr),
				  .mmio_rd		 (mmio_rd),
				  .mmio_addr		 (mmio_addr[20:0]),
				  .mmio_wr_data		 (mmio_wr_data[31:0]),
				  .slot_rd_data_array	 (slot_rd_data_array/*[31:0].[63:0]*/));


   // slot0: system time
   chu_timer TIMER_SLOT0 (
			  // Outputs
			  .rd_data		(slot_rd_data_array[`S0_SYS_TIMER]),
			  // Inputs
			  .clk			(clk),
			  .rst			(rst),
			  .cs			(slot_cs_array[`S0_SYS_TIMER]),
			  .read			(slot_mem_rd_array[`S0_SYS_TIMER]),
			  .write		(slot_mem_wr_array[`S0_SYS_TIMER]),
			  .addr			(slot_reg_addr_array[`S0_SYS_TIMER]),
			  .wr_data		(slot_wr_data_array[`S0_SYS_TIMER]));


   // slot1: uart
   // chu_uart UART_SLOT1 (/*AUTOINST*/);


   // slot2: gpo (leds)
   chu_gpo #(/*AUTOINSTPARAM*/
	     // Parameters
	     .N_LED			(N_LED)) GPO_SLOT2 (
							    // Outputs
							    .dout		(led),
							    .rd_data		(slot_rd_data_array[`S2_LED]),
							    // Inputs
							    .clk		(clk),
							    .rst		(rst),
							    .cs			(slot_cs_array[`S2_LED]),
							    .read		(slot_mem_rd_array[`S2_LED]),
							    .write		(slot_mem_wr_array[`S2_LED]),
							    .addr		(slot_reg_addr_array[`S2_LED]),
							    .wr_data	        (slot_wr_data_array[`S2_LED]));


   // slot3: gpi1(switches)
   chu_gpi #(/*AUTOINSTPARAM*/
	     // Parameters
	     .N_SW			(N_SW)) GPI_SLOT3 (
							   // Outputs
							   .rd_data		(slot_rd_data_array[`S3_SW]),
							   // Inputs
							   .clk			(clk),
							   .rst			(rst),
							   .cs			(slot_cs_array[`S3_SW]),
							   .read		(slot_mem_rd_array[`S3_SW]),
							   .write		(slot_mem_wr_array[`S3_SW]),
							   .addr		(slot_reg_addr_array[`S3_SW]),
							   .wr_data		(slot_wr_data_array[`S3_SW]),
							   .din			(sw));


   // slot : push button
   chu_gpi #(/*AUTOINSTPARAM*/  
	      // Parameters
	      .N_SW			(N_BTN)) GPI_PUSH_BTN (
							       // Outputs
							       .rd_data		(slot_rd_data_array[`S4_BTN]),
							       // Inputs
							       .clk		(clk),
							       .rst		(rst),
							       .cs		slot_cs_array[`S4_BTN]),
							       .read		(slot_mem_rd_array[`S4_BTN]),
							       .write		(slot_mem_wr_array[`S4_BTN]),
							       .addr		(slot_reg_addr_array[`S4_BTN]),
							       .wr_data		(slot_wr_data_array[`S4_BTN]),
							       .din		(btn));
   

  
   generate
      genvar 		    i;
      for(i = 5; i < 64; i = i+1)
	begin: unused_slot_gen
	   assign slot_rd_data_array[i] = 32'h00000000;//ffffffff;
	end
      endgenerate

endmodule // mmio_sys_vanilla
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/VanillaFPRO/*")
// End:

   
