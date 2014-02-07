`timescale 1ns / 1ns
`define buffersize 26
module patternbuf(pattern, patternbyte, sclk, ssel, sin, sout, saddr, bufp) ;
/*
typedef struct {reg [7:0] delay; reg [7:0] pstrength; reg [7:0] nstrength;} dparams ;

typedef struct { 
	dparams driverparams; 
	dparams tweakparams0; 
	dparams tweakparams1; 
	dparams tweakparams2; 
	dparams tweakparams3;
	dparams tweakparams4;
	dparams tweakparams5;
	dparams tweakparams6;
	dparams tweakparams7;
} apattern ;
*/

input ssel ;
//input sclk ;
//input sin ;
input [2:0] saddr ;
//input [4:0] bufp ;

output [7:0] pattern [`buffersize:0] ;
output [7:0] patternbyte ;
output sout ;

//debug
output sin ;
output bufp ;
output sclk ; 

//dparams dbuf ;

// array as a collection of 
reg [7:0] pattern [`buffersize:0] ;

assign sout = pattern[`buffersize][7] ;
assign patternbyte = pattern[bufp] ;

integer i ;

// for debug
reg sin ;
reg [4:0] bufp ;
reg sclk ;



initial
begin
	sin = 0 ;
	bufp = 0 ;
	sclk = 0 ;
  // forever #1 sclk != sclk ;
end 

always #1 sclk = ~sclk;

always @(posedge sclk)
begin
	sin <= 1 ;
	bufp <= bufp + 1 ;

	pattern[0] <= {pattern[0][6:0], sin} ;
	for(i=1 ; i<=`buffersize ; i=i+1)
	begin
		pattern[i] <= {pattern[i][6:0], pattern[i-1][7]} ;
	end

end


endmodule 