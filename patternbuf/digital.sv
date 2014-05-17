module digital(clk, reset, inputs, imem_write_adr, imem_write, imem_in, outputs, acc_out) ;

parameter d_width = 8 ;
parameter i_adr_width = 10 ;
parameter i_width = 20 ; // instruction width
parameter i_buffer_size = 2 ;
parameter bufp_width = 3 ;
parameter fieldp_width = 5 ;

input clk ;
input reset ;
input [d_width-1:0] inputs ;
input [i_adr_width-1:0] imem_write_adr ;
input imem_write ;
input [(i_buffer_size*i_width)-1:0] imem_in ;
output [d_width-1:0] outputs ;
output [d_width-1:0] acc_out ;

wire [d_width-1:0] field_in ;
wire [(fieldp_width+bufp_width)-1:0] buf_fieldp ;
wire [(fieldp_width+bufp_width)-1:0] buf_fieldwp ;
wire field_write_en_low ;
wire field_write_en_high ;
wire [d_width-1:0] field_out_low ;
wire [d_width-1:0] field_out_high ;
wire [bufp_width-1:0] bufp ;
wire [fieldp_width-1:0] fieldp ;
wire [fieldp_width-1:0] fieldwp ;

assign buf_fieldp = {bufp, fieldp} ;
assign buf_fieldwp = {bufp, fieldwp} ;

wire [i_adr_width-1:0] pc ;
wire jump ;
wire [i_width-1:0] instruction ;


//inst_mem iMem(pc, imem_write_adr, imem_write, imem_in, instruction) ;
instruction_buffer iBuffer(clk, reset, pc, instruction, imem_write_adr, imem_write, imem_in, jump) ;

patternbuffer dummyPatBufLow(buf_fieldp, buf_fieldwp, field_write_en_low, field_in, field_out_low) ;
patternbuffer dummyPatBufHigh(buf_fieldp, buf_fieldwp, field_write_en_high, field_in, field_out_high) ;

pat thePAT(clk, reset, pc, jump, bufp, fieldp, fieldwp, field_write_en_low, field_write_en_high, field_out, instruction, field_out_low, field_out_high, acc_out, inputs, outputs) ;

endmodule


module patternbuffer(buf_fieldp, buf_fieldwp, field_write_en, field_out, field_in) ;
parameter bufp_width = 3 ;
parameter fieldp_width = 5 ;
parameter d_width = 8 ;

input [d_width-1:0] field_in ;
input [(fieldp_width+bufp_width)-1:0] buf_fieldp ;
input [(fieldp_width+bufp_width)-1:0] buf_fieldwp ;
input field_write_en ;
output [d_width-1:0] field_out ;

// dummy module


endmodule 
