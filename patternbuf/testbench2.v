`timescale 1ns / 1ns
module testbench(sin, ssel, saddr, sclk, sout, pattern_out, field_byte_out, clk, incbufp, incfieldp) ;
  
input sin, sclk, ssel ;
input clk ; 
input [2:0] saddr ;
output sout ;
output [7:0] field_byte_out ;

output [7:0] pattern_out [32] ;

reg [2:0] bufp ;
reg [4:0] fieldp ;
reg [7:0] pattern_out [32] ;
reg [7:0] field_byte_out ;

wire [7:0] field_byte ;
wire [7:0] current_buffer [32] ;



// debug
input incbufp ;
input incfieldp ;

buffers theBuffers(sclk, sin, sout, ssel, saddr, bufp, current_buffer, fieldp, field_byte) ;


/*
initial
begin
	sin = 1 ;
	fieldp = 0 ;
	sclk = 0 ;
	bufp = 0 ;
	ssel = 1 ;
	saddr = 0 ;
	counter = 0 ;
  // forever #1 sclk != sclk ;
end 
*/

//always #1 sclk = ~sclk;


//always #1 clk = ~clk ;
//

always @(posedge clk)
begin
 if (incbufp) bufp <= bufp + 1 ;
 if (incfieldp) fieldp <= fieldp + 1 ;
 pattern_out <= current_buffer ;
 field_byte_out <= field_byte ;
end

  
  
endmodule
