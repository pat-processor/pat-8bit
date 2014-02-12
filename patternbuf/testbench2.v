`timescale 1ns / 1ns
module testbench(sin, ssel, sclk, sout, current_buffer, pattern_sequence, field_byte) ;
  
input sin, sclk, ssel ;
reg [2:0] saddr ;
reg [2:0] bufp ;
reg [4:0] fieldp ;
output sout ;
output [7:0] field_byte ;


output [7:0] current_buffer [31:0] ;
output [7:0] pattern_sequence [2:0] ;

buffers theBuffers(sclk, sin, sout, ssel, saddr, bufp, current_buffer, fieldp, pattern_sequence, field_byte) ;

/*
initial
begin
	sin = 1 ;
	fieldp = 0 ;
	sclk = 0 ;
	bufp = 0 ;
	ssel = 1 ;
	saddr = 0 ;
  // forever #1 sclk != sclk ;
end 

always #1 sclk = ~sclk;
*/

always @(posedge sclk)
begin
 bufp <= bufp + 1 ;
 fieldp <= fieldp + 1 ;
 saddr <= 0 ;
end
  
  
endmodule
