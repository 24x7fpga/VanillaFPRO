module chu_gpo #(parameter N_LED = 4) (/*AUTOARG*/
   // Outputs
   dout, rd_data,
   // Inputs
   clk, rst, cs, read, write, addr, wr_data
   );
   input logic clk;
   input logic rst;
   // slot interface
   input logic cs;
   input logic read;
   input logic write;
   input logic [4:0] addr;
   input logic [31:0] wr_data;
   //external logic
   output logic [N_LED-1:0] dout;
   output logic [31:0] rd_data;


   /*AUTOREG*/

   /*AUTO_WIRE*/
   
   // signal declaration

   logic [N_LED-1:0] 	buf_reg;
   logic 		wr_en;

   // body; output buffer register
   always_ff@(posedge clk, posedge rst)
     if(rst)
       buf_reg <= 0;
     else
       if(wr_en)
	 buf_reg <= wr_data[N_LED-1:0];

   // decoding logic
   // data is written when MMIO is selected
   // and write signal is asserted
   assign wr_en = cs && write;

   // slot read interface
   // since this an external interface
   // read data is set to zero
   // this will be optimized during sythesis
   assign rd_data = 0;

   // external output
   assign dout = buf_reg;

endmodule // chu_gpo
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/VanillaFPRO/*")
// End:
