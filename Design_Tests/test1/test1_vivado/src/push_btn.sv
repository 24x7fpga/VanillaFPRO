// 4th push button is used as the global reset. 
// Hence, only the lower 3 push button are available 
// for the user
module push_btn #(parameter N_BTN = 3) (/*AUTOARG*/
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
   // external signal
   input logic [N_BTN-1:0] din;

   output logic [31:0] 	   rd_data;


   /*AUTOREG*/

   /*AUTOWIRE*/

   // signal declaration

   logic [N_BTN-1:0] 	   rd_data_reg;

   always_ff@(posedge clk, posedge rst)
     if(rst)
       rd_data_reg <= 0;
     else
       rd_data_reg <= din;

   assign rd_data[N_BTN-1:0] = cs ? rd_data_reg : 'hz;

   assign rd_data[31:N_BTN] = cs ? 0 : 'hz;

endmodule // push_btn
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/VanillaFPRO/*")
// End:
