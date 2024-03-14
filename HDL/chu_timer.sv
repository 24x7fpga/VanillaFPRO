module chu_timer (/*AUTOARG*/
   // Outputs
   rd_data,
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
   
   output logic [31:0] rd_data;

   // signal declaration
   logic [47:0]        count_reg;         // lower + upper => 32 + 16 = 48-bits
   logic 	       ctrl_reg;          // control register
   logic 	       wr_en, clear, go;

   // counter
   always_ff@(posedge clk, posedge rst)
     if(rst)
       count_reg <= 0;
     else
       if(clear)
	 count_reg <= 0;
       else if(go)
	 count_reg <= count_reg + 1;

   // control register
   always_ff@(posedge clk, posedge rst)
     if(rst)
       ctrl_reg <= 0;
     else
       if(wr_en)
	 ctrl_reg <= wr_data[0];

   // decoding logic
   assign wr_en = write && cs && (addr[1:0] == 2'b10);
   assign clear = wr_en && wr_data[1];
   assign go    = ctrl_reg;

   // slot read interface
   assign rd_data = (addr[0] == 0) ? count_reg[31:0] : {16'h0000, count_reg[47:32]};

endmodule // chu_timer
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/VanillaFPRO/*")
// End:
   
   
