`timescale 1ns / 1ns
module patternbuf(pattern, sclk, ssel, sin, sout, fieldp, field_byte) ;

parameter buffer_width = 8 ;
parameter buffer_size = 32 ;

input ssel ;
input sin ;
input sclk ;
input [4:0] fieldp ;

output [buffer_width-1:0] field_byte ;
output [buffer_width-1:0] pattern [buffer_size-1:0] ;
output sout ;


// array as a collection of 
reg [buffer_width-1:0] pattern [buffer_size-1:0] ;

assign sout = pattern[buffer_size-1][7] ;
assign field_byte = pattern[fieldp] ; // this uses MUXs to select 8 seperate bits of pattern into field-byte.

integer i ;

// a, b, s, q
//MUX2X1_HV mux1(.A (pattern[0][0]), .B (pattern[1][0]), .S (fieldp[0]), .Q (fbit)) ;

//assign fbit = fieldp[0] ? pattern[0][0] : pattern[1][0] ;


always @(posedge sclk)
begin
  // if serial is selected, shift all the buffer left by one 
  // and add in 'sin'
  if (ssel)
    begin
    	pattern[0] <= {pattern[0][6:0], sin} ;
    	for(i=1 ; i<=buffer_size-1 ; i=i+1)
    	begin
      		pattern[i] <= {pattern[i][6:0], pattern[i-1][7]} ;
    	end
	end

end


endmodule 
