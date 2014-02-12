`timescale 1ns / 1ns
`define SEQ1ADR 0 // address of globally visible sequence buffer (1)
`define SEQ2ADR 1 // address of globally visible sequence buffer (2)
`define SEQCTRLADR 2 // address of globally visible sequence control
module buffers(sclk, sin, sout, ssel, saddr, bufp, current_buffer, fieldp, pattern_sequence, field_byte) ;

parameter buffer_size = 32 ; // bytes
parameter buffer_width = 8 ; // bits
parameter no_bufs = 8 ;      // patternbuf instances


input sclk, sin, ssel ;
input [2:0] saddr ;
input [2:0] bufp ;
input [4:0] fieldp ; 
output sout ;
output [buffer_width-1:0] pattern_sequence [2:0] ;
output [buffer_width-1:0] field_byte ;

output [buffer_width-1:0] current_buffer [buffer_size-1:0] ; // FIXME: Don't output scratch (decrease size by 2 bytes)


wire [buffer_width-1:0] bufs [no_bufs-1:0][buffer_size-1:0] ;

wire [buffer_width-1:0] buf1 [buffer_size-1:0] ;
wire [buffer_width-1:0] buf2 [buffer_size-1:0] ;
wire [buffer_width-1:0] buf3 [buffer_size-1:0] ;
wire [buffer_width-1:0] buf4 [buffer_size-1:0] ;
wire [buffer_width-1:0] buf5 [buffer_size-1:0] ;
wire [buffer_width-1:0] buf6 [buffer_size-1:0] ;
wire [buffer_width-1:0] buf7 [buffer_size-1:0] ;
wire [buffer_width-1:0] buf8 [buffer_size-1:0] ;

wire ssel1 ;
wire ssel2 ;
wire ssel3 ;
wire ssel4 ;
wire ssel5 ;
wire ssel6 ;
wire ssel7 ;
wire ssel8 ;


wire [buffer_width-1:0] field_byte ;

assign bufs[0] = buf1 ;
assign bufs[1] = buf2 ;
assign bufs[2] = buf3 ;
assign bufs[3] = buf4 ;
assign bufs[4] = buf5 ;
assign bufs[5] = buf6 ;
assign bufs[6] = buf7 ;
assign bufs[7] = buf8 ;

wire [buffer_width-1:0] field_bytes [no_bufs] ;

wire [buffer_width-1:0] field_byte1 ;
wire [buffer_width-1:0] field_byte2 ;
wire [buffer_width-1:0] field_byte3 ;
wire [buffer_width-1:0] field_byte4 ;
wire [buffer_width-1:0] field_byte5 ;
wire [buffer_width-1:0] field_byte6 ;
wire [buffer_width-1:0] field_byte7 ;
wire [buffer_width-1:0] field_byte8 ;

assign field_bytes[0] = field_byte1 ;
assign field_bytes[1] = field_byte2 ;
assign field_bytes[2] = field_byte3 ;
assign field_bytes[3] = field_byte4 ;
assign field_bytes[4] = field_byte5 ;
assign field_bytes[5] = field_byte6 ;
assign field_bytes[6] = field_byte7 ;
assign field_bytes[7] = field_byte8 ;


// Select a single buffer for serial
// interfacing, based on the saddr signal.
assign ssel1 = ssel && saddr == 0 ;
assign ssel2 = ssel && saddr == 1 ;
assign ssel3 = ssel && saddr == 2 ;
assign ssel4 = ssel && saddr == 3 ;
assign ssel5 = ssel && saddr == 4 ;
assign ssel6 = ssel && saddr == 5 ;
assign ssel7 = ssel && saddr == 6 ;
assign ssel8 = ssel && saddr == 7 ;



wire [3:0] bufmux1_1in ;
wire [3:0] bufmux1_2in ;
assign bufmux1_1in[0] = buf1[0][0] ;
assign bufmux1_1in[1] = buf2[0][0] ;
assign bufmux1_1in[2] = buf3[0][0] ;
assign bufmux1_1in[3] = buf4[0][0] ;
assign bufmux1_2in[0] = buf5[0][0] ;
assign bufmux1_2in[1] = buf6[0][0] ;
assign bufmux1_2in[2] = buf7[0][0] ;
assign bufmux1_2in[3] = buf8[0][0] ;

wire bufmux1_1out ;
wire bufmux1_2out ;


MUX4X1_HV mux1_1(.A (bufmux1_1in[0]), .B (bufmux1_1in[1]),
	.C (bufmux1_1in[2]), .D (bufmux1_1in[3]),
	.S0 (bufp[0]), .S1 (bufp[1]), .Q( bufmux1_1out)) ;

MUX4X1_HV mux1_2(.A (bufmux1_2in[0]), .B (bufmux1_2in[1]),
	.C (bufmux1_2in[2]), .D (bufmux1_2in[3]),
	.S0 (bufp[0]), .S1 (bufp[1]), .Q( bufmux1_2out)) ;


//assign bufmux1_1out = bufmux1_1in[bufp[1:0]] ;
//assign bufmux1_2out = bufmux1_2in[bufp[1:0]] ;


wire bufmux2_1out ;
assign bufmux2_1out = bufp[2] ? bufmux1_1out : bufmux1_2out ;
assign current_buffer[0] = bufmux2_1out ; 



genvar i ;
/*
generate for (i = 0 ; i < buffer_size ; i = i+1)
 begin 
   assign current_buffer[0] 
 end
endgenerate
*/

// globally visible sequence buffer
reg [buffer_width-1:0] pattern_sequence [2:0] ;

// assign the patternbyte to the relevant
// buffer, unless it's the globally visible
// pattern sequence register
//assign field_byte = field_bytes[bufp] ;

generate for (i = 0 ; i < buffer_width ; i = i+1) 
 assign field_byte[i] = field_bytes[bufp][i] ;
endgenerate


patternbuf buffer1(buf1, sclk, ssel1, sin, sout, fieldp, field_byte1) ;
patternbuf buffer2(buf2, sclk, ssel2, sin, sout, fieldp, field_byte2) ;
patternbuf buffer3(buf3, sclk, ssel3, sin, sout, fieldp, field_byte3) ;
patternbuf buffer4(buf4, sclk, ssel4, sin, sout, fieldp, field_byte4) ;
patternbuf buffer5(buf5, sclk, ssel5, sin, sout, fieldp, field_byte5) ;
patternbuf buffer6(buf6, sclk, ssel6, sin, sout, fieldp, field_byte6) ;
patternbuf buffer7(buf7, sclk, ssel7, sin, sout, fieldp, field_byte7) ;
patternbuf buffer8(buf8, sclk, ssel8, sin, sout, fieldp, field_byte8) ;




endmodule
