`timescale 1ns / 1ns
`define buffersize 26
`define nobufs 7
module buffers(sclk, sin, sout, ssel, saddr, bufs) ;


input sclk, sin, ssel ;
input [2:0] saddr ;
output sout ;
output [7:0] bufs [`nobufs:0][`buffersize:0] ;



wire [7:0] buf1 [`buffersize:0] ;
wire [7:0] buf2 [`buffersize:0] ;
wire [7:0] buf3 [`buffersize:0] ;
wire [7:0] buf4 [`buffersize:0] ;
wire [7:0] buf5 [`buffersize:0] ;
wire [7:0] buf6 [`buffersize:0] ;
wire [7:0] buf7 [`buffersize:0] ;
wire [7:0] buf8 [`buffersize:0] ;

assign bufs[0] = buf1 ;
assign bufs[1] = buf2 ;
assign bufs[2] = buf3 ;
assign bufs[3] = buf4 ;
assign bufs[4] = buf5 ;
assign bufs[5] = buf6 ;
assign bufs[6] = buf7 ;
assign bufs[7] = buf8 ;


wire [4:0] bufp ;
wire [7:0] patternbyte ;

patternbuf buffer1(buf1, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;
patternbuf buffer2(buf2, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;
patternbuf buffer3(buf3, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;
patternbuf buffer4(buf4, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;
patternbuf buffer5(buf5, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;
patternbuf buffer6(buf6, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;
patternbuf buffer7(buf7, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;
patternbuf buffer8(buf8, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;


endmodule