`timescale 1ns / 1ns
`define buffersize 27
module patternbuf(pattern, sclk, ssel, sin, sout) ;


input ssel ;
input sin ;
input sclk ;

output [7:0] pattern [`buffersize-1:0] ;
output sout ;


// array as a collection of 
reg [7:0] pattern [`buffersize-1:0] ;

assign sout = pattern[`buffersize-1][7] ;

integer i ;


always @(posedge sclk)
begin
  // if serial is selected, shift all the buffer left by one 
  // and add in 'sin'
  if (ssel)
    begin
    	pattern[0] <= {pattern[0][6:0], sin} ;
    	for(i=1 ; i<=`buffersize-1 ; i=i+1)
    	begin
      		pattern[i] <= {pattern[i][6:0], pattern[i-1][7]} ;
    	end
	end

end


endmodule 