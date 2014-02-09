`timescale 1ns / 1ns
`define buffersize 26
`define nobufs 8
module buffers(sclk, sin, sout, ssel, saddr, bufselect, current_buffer, bufp) ;


input sclk, sin, ssel ;
input [2:0] saddr ;
input [2:0] bufselect ;
input [4:0] bufp ; 
output sout ;

output [7:0] current_buffer [`buffersize:0] ;

wire [7:0] bufs [`nobufs-1:0][`buffersize:0] ;

wire [7:0] buf1 [`buffersize:0] ;
wire [7:0] buf2 [`buffersize:0] ;
wire [7:0] buf3 [`buffersize:0] ;
wire [7:0] buf4 [`buffersize:0] ;
wire [7:0] buf5 [`buffersize:0] ;
wire [7:0] buf6 [`buffersize:0] ;
wire [7:0] buf7 [`buffersize:0] ;
wire [7:0] buf8 [`buffersize:0] ;

wire ssel1 ;
wire ssel2 ;
wire ssel3 ;
wire ssel4 ;
wire ssel5 ;
wire ssel6 ;
wire ssel7 ;
wire ssel8 ;


wire [7:0] patternbyte ;

assign bufs[0] = buf1 ;
assign bufs[1] = buf2 ;
assign bufs[2] = buf3 ;
assign bufs[3] = buf4 ;
assign bufs[4] = buf5 ;
assign bufs[5] = buf6 ;
assign bufs[6] = buf7 ;
assign bufs[7] = buf8 ;

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


assign current_buffer = bufs[bufselect] ;

assign patternbyte = current_buffer[bufp] ;



patternbuf buffer1(buf1, sclk, ssel1, sin, sout) ;
patternbuf buffer2(buf2, sclk, ssel2, sin, sout) ;
patternbuf buffer3(buf3, sclk, ssel3, sin, sout) ;
patternbuf buffer4(buf4, sclk, ssel4, sin, sout) ;
patternbuf buffer5(buf5, sclk, ssel5, sin, sout) ;
patternbuf buffer6(buf6, sclk, ssel6, sin, sout) ;
patternbuf buffer7(buf7, sclk, ssel7, sin, sout) ;
patternbuf buffer8(buf8, sclk, ssel8, sin, sout) ;




endmodule