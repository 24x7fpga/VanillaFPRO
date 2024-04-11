`timescale 1ns/1ns
module uart_fifo #(parameter DEPTH = 16, parameter WIDTH = 8) (/*AUTOARG*/
   // Outputs
   full, empty, r_data,
   // Inputs
   clk, rst, wr_data, wr, rd
   );
   input  logic clk;
   input  logic rst;
   input  logic [WIDTH-1:0] wr_data;
   input  logic 	    wr;
   input  logic 	    rd;
   output logic 	    full;
   output logic 	    empty;
   output logic [WIDTH-1:0] r_data;

   logic [$clog2(DEPTH) : 0] 	    wr_ptr_reg, wr_ptr_nxt;
   logic [$clog2(DEPTH) : 0] 	    rd_ptr_reg, rd_ptr_nxt;
  
   logic [WIDTH-1:0] 	    mem_arr[0:DEPTH-1];
   
   // full condition
   assign full = {~wr_ptr_reg[$clog2(DEPTH)],wr_ptr_reg[$clog2(DEPTH)-1:0]} == rd_ptr_reg;

   //empty condition
   assign empty = wr_ptr_reg == rd_ptr_reg;
   
   // write pointer
   always_ff@(posedge clk)
    begin
        if(rst)
            wr_ptr_reg <= 0;
        else
            wr_ptr_reg <= wr_ptr_nxt;
    end
   
   assign wr_ptr_nxt = (wr && ~full) ? wr_ptr_reg + 1 : wr_ptr_reg;
   
   // read pointer
   always_ff@(posedge clk)
    begin
        if(rst)
            rd_ptr_reg <= 0;
        else
            rd_ptr_reg <= rd_ptr_nxt;
    end
   
   assign rd_ptr_nxt = (rd && ~empty) ? rd_ptr_reg + 1 : rd_ptr_reg;
   
   
     always_comb
        begin
            if(wr && ~full)
                mem_arr[wr_ptr_reg[$clog2(DEPTH)-1:0]] = wr_data;
            else
                mem_arr[wr_ptr_reg[$clog2(DEPTH)-1:0]] = 0;
                                

            if(rd && ~empty) 
                r_data  =mem_arr[rd_ptr_reg[$clog2(DEPTH)-1:0]];
            else 
                r_data <= 0;            
    
        end
   


endmodule // fifo
// Local Variables: 
// verilog-library-directories:(".") 
// End:
