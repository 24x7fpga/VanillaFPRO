module chu_gpi #(parameter N_SW = 4) (/*AUTOARG*/
   // Outputs
   rd_data,
   // Inputs
   clk, rst, cs, read, write, addr, wr_data, din
   );

   input logic clk;
   input logic rst;
   // slot interface
   input logic cs;
   input logic read;
   input logic write;
   input logic [4:0] addr;
   input logic [31:0] wr_data;
   //external signal
   input logic [N_SW-1:0] din;

   output logic [31:0] rd_data;


   /*AUTOREG*/

   /*AUTON_SWIRE*/

   // signal declaration

   logic [N_SW-1:0]       rd_data_reg;

   always_ff@(posedge clk, posedge rst)
     if(rst)
       rd_data_reg <= 0;
     else
       rd_data_reg <= din;

   assign rd_data[N_SW-1:0] = rd_data_reg;

   assign rd_data[31:N_SW]  = 0;

endmodule // chu_gpi
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/VanillaFPRO/*")
// End:
