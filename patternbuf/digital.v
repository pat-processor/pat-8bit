module digital(clk, reset, inputs, imem_write_adr, imem_write, imem_in, field_in, buf_fieldp, buf_fieldwp, field_write_en, field_out, outputs) ;

parameter d_width = 8 ;
parameter i_adr_width = 10 ;
parameter i_width = 20 ; // instruction width
parameter i_buffer_size = 2 ;
parameter bufp_width = 3 ;
parameter fieldp_width = 5 ;

input clk, reset ;
input [d_width-1:0] inputs [8] ;
input [i_adr_width-1:0] imem_write_adr ;
input imem_write ;
input [(i_buffer_size*i_width)-1:0] imem_in ;
input [d_width-1:0] field_in ;

output [(fieldp_width+bufp_width)-1:0] buf_fieldp ;
output [(fieldp_width+bufp_width)-1:0] buf_fieldwp ;
output field_write_en ;
output [d_width-1:0] field_out ;
output [d_width-1:0] outputs [8] ;

wire [bufp_width-1:0] bufp ;
wire [fieldp_width-1:0] fieldp ;
wire [fieldp_width-1:0] fieldwp ;
assign buf_fieldp = {bufp, fieldp} ;
assign buf_fieldwp = {bufp, fieldwp} ;

wire [i_adr_width-1:0] pc ;
wire [i_width-1:0] instruction ;

// outputs[1] set to be accumulator
pat thePAT(clk, reset, pc, bufp, fieldp, fieldwp, field_write_en, field_out, 
	instruction, field_in, outputs[1], inputs, outputs) ;

instruction_buffer iBuffer(clk, reset, pc, instruction, imem_write_adr, imem_write, imem_in) ;


endmodule
