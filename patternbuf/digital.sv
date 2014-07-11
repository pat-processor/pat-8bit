module digital(scan_enable, scan_in, scan_out, clk, reset, inputs, imem_write_adr, imem_write, imem_in, outputs,
bufp, fieldp, fieldwp, field_write_en_low, field_write_en_high, field_fromPAT, field_toPAT_low, field_toPAT_high) ;

parameter d_width = 8 ;
parameter i_adr_width = 10 ;
parameter i_width = 20 ; // instruction width
parameter i_buffer_size = 2 ;
parameter bufp_width = 3 ;
parameter fieldp_width = 5 ;

input scan_enable ;
input scan_in ;
input clk ;
input reset ;
input [d_width-1:0] inputs ;
input [i_adr_width-1:0] imem_write_adr ;
input imem_write ;
input [(i_buffer_size*i_width)-1:0] imem_in ;
input [d_width-1:0] field_toPAT_low ;
input [d_width-1:0] field_toPAT_high ;

output scan_out ;
output [d_width-1:0] outputs ;

output [bufp_width-1:0] bufp ;
output [fieldp_width-1:0] fieldp ;
output [fieldp_width-1:0] fieldwp ;
output field_write_en_low ;
output field_write_en_high ;
output [d_width-1:0] field_fromPAT ;


wire [i_adr_width-1:0] pc ;
wire jump ;
wire [i_width-1:0] instruction ;


//inst_mem iMem(pc, imem_write_adr, imem_write, imem_in, instruction) ;
instruction_buffer iBuffer(clk, reset, pc, instruction, imem_write_adr, imem_write, imem_in, jump) ;

pat thePAT(clk, reset, pc, jump, bufp, fieldp, fieldwp, field_write_en_low, field_write_en_high, field_fromPAT, instruction, field_toPAT_low, field_toPAT_high, inputs, outputs) ;

endmodule
