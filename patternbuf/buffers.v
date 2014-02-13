`timescale 1ns / 1ns
`define SEQ1ADR 0 // address of globally visible sequence buffer (1)
`define SEQ2ADR 1 // address of globally visible sequence buffer (2)
`define SEQCTRLADR 2 // address of globally visible sequence control
module buffers(sclk, sin, sout, ssel, saddr, bufp, current_buffer, fieldp, field_byte, field_in, field_write, clk) ;

parameter buffer_size = 32 ; // bytes
parameter buffer_width = 8 ; // bits
parameter no_bufs = 8 ;      // patternbuf instances


input sclk, sin, ssel ;
input [2:0] saddr ;
input [2:0] bufp ;
input [4:0] fieldp ; 
input clk ;
input [buffer_width-1:0] field_in ;
input field_write ;
output sout ;
output [buffer_width-1:0] field_byte ;

output [buffer_width-1:0] current_buffer [buffer_size] ; // FIXME: Don't output scratch (decrease size by 2 bytes)


wire [buffer_width-1:0] bufs [no_bufs][buffer_size] ;

wire [buffer_width-1:0] buf1 [buffer_size] ;
wire [buffer_width-1:0] buf2 [buffer_size] ;
wire [buffer_width-1:0] buf3 [buffer_size] ;
wire [buffer_width-1:0] buf4 [buffer_size] ;
wire [buffer_width-1:0] buf5 [buffer_size] ;
wire [buffer_width-1:0] buf6 [buffer_size] ;
wire [buffer_width-1:0] buf7 [buffer_size] ;
wire [buffer_width-1:0] buf8 [buffer_size] ;

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


// assign the scan chain outputs
// tri-state if disabled.
wire souts[8] ;
//assign sout = ssel ? souts[saddr] : 1'bz ;
assign sout = souts[0] ;


/*
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
*/

/*
assign bufmux1_1out = bufmux1_1in[bufp[1:0]] ;
assign bufmux1_2out = bufmux1_2in[bufp[1:0]] ;


wire bufmux2_1out ;
assign bufmux2_1out = bufp[2] ? bufmux1_1out : bufmux1_2out ;
assign current_buffer[0] = bufmux2_1out ; 
*/

assign current_buffer = bufs[bufp] ;


genvar i ;
/*
generate for (i = 0 ; i < buffer_size ; i = i+1)
 begin 
   assign current_buffer[0] 
 end
endgenerate
*/


// assign the patternbyte to the relevant
// buffer,
//
//assign field_byte = field_bytes[bufp] ;



assign field_byte = current_buffer[fieldp] ;


wire field_write1 ;
wire field_write2 ;
wire field_write3 ;
wire field_write4 ;
wire field_write5 ;
wire field_write6 ;
wire field_write7 ;
wire field_write8 ;

assign field_write1 = (fieldp == 0 && field_write) ;
assign field_write2 = (fieldp == 1 && field_write) ;
assign field_write3 = (fieldp == 2 && field_write) ;
assign field_write4 = (fieldp == 3 && field_write) ;
assign field_write5 = (fieldp == 4 && field_write) ;
assign field_write6 = (fieldp == 5 && field_write) ;
assign field_write7 = (fieldp == 6 && field_write) ;
assign field_write8 = (fieldp == 7 && field_write) ;


defparam buffer1.buffer_width = buffer_width ;
defparam buffer1.buffer_size = buffer_size ;
defparam buffer2.buffer_width = buffer_width ;
defparam buffer2.buffer_size = buffer_size ;
defparam buffer3.buffer_width = buffer_width ;
defparam buffer3.buffer_size = buffer_size ;
defparam buffer4.buffer_width = buffer_width ;
defparam buffer4.buffer_size = buffer_size ;
defparam buffer5.buffer_width = buffer_width ;
defparam buffer5.buffer_size = buffer_size ;
defparam buffer6.buffer_width = buffer_width ;
defparam buffer6.buffer_size = buffer_size ;
defparam buffer7.buffer_width = buffer_width ;
defparam buffer7.buffer_size = buffer_size ;
defparam buffer8.buffer_width = buffer_width ;
defparam buffer8.buffer_size = buffer_size ;

patternbuf buffer1(buf1, sclk, ssel1, sin, souts[0], fieldp, field_byte1, field_in, field_write1, clk) ;
patternbuf buffer2(buf2, sclk, ssel2, sin, souts[1], fieldp, field_byte2, field_in, field_write2, clk) ;
patternbuf buffer3(buf3, sclk, ssel3, sin, souts[2], fieldp, field_byte3, field_in, field_write3, clk) ;
patternbuf buffer4(buf4, sclk, ssel4, sin, souts[3], fieldp, field_byte4, field_in, field_write4, clk) ;
patternbuf buffer5(buf5, sclk, ssel5, sin, souts[4], fieldp, field_byte5, field_in, field_write5, clk) ;
patternbuf buffer6(buf6, sclk, ssel6, sin, souts[5], fieldp, field_byte6, field_in, field_write6, clk) ;
patternbuf buffer7(buf7, sclk, ssel7, sin, souts[6], fieldp, field_byte7, field_in, field_write7, clk) ;
patternbuf buffer8(buf8, sclk, ssel8, sin, souts[7], fieldp, field_byte8, field_in, field_write8, clk) ;




endmodule
