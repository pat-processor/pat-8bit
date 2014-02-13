`timescale 1ns / 1ns
module patternbuf(pattern, sclk, ssel, sin, sout, fieldp, field_byte) ;

parameter buffer_width = 8 ;
parameter buffer_size = 32 ;

input ssel ;
input sin ;
input sclk ;
input [4:0] fieldp ;

output [buffer_width-1:0] field_byte ;
output [buffer_width-1:0] pattern [buffer_size] ;
output sout ;


// array as a collection of 
reg [buffer_width-1:0] pattern [buffer_size] ;

assign sout = pattern[buffer_size-1][buffer_width-1] ;


//assign field_byte = pattern[fieldp] ;


/* The below maps to physical cells and works, but synthesis optimisation
* removes and replaces with combinatoral logic.
	*/
genvar g ;
generate for (g = 0 ; g < buffer_width ; g = g+1)
 begin
	 
   // 1st level MUXs
   wire mux1_1_out ;
   wire mux1_2_out ;
   wire mux1_3_out ;
   wire mux1_4_out ;
   wire mux1_5_out ;
   wire mux1_6_out ;
   wire mux1_7_out ;
   wire mux1_8_out ;

   MUX4X1_HV mux1_1(.A (pattern[0][g]), .B (pattern[1][g]), .C(pattern[2][g]), .D(pattern[3][g]), .S0 (fieldp[0]), .S1 (fieldp[1]), .Q (mux1_1_out)) ;
   MUX4X1_HV mux1_2(.A (pattern[4][g]), .B (pattern[5][g]), .C(pattern[6][g]), .D(pattern[7][g]), .S0 (fieldp[0]), .S1 (fieldp[1]), .Q (mux1_2_out)) ;
   MUX4X1_HV mux1_3(.A (pattern[8][g]), .B (pattern[9][g]), .C(pattern[10][g]), .D(pattern[11][g]), .S0 (fieldp[0]), .S1 (fieldp[1]), .Q (mux1_3_out)) ;
   MUX4X1_HV mux1_4(.A (pattern[12][g]), .B (pattern[13][g]), .C(pattern[14][g]), .D(pattern[15][g]), .S0 (fieldp[0]), .S1 (fieldp[1]), .Q (mux1_4_out)) ;

   MUX4X1_HV mux1_5(.A (pattern[16][g]), .B (pattern[17][g]), .C(pattern[18][g]), .D(pattern[19][g]), .S0 (fieldp[0]), .S1 (fieldp[1]), .Q (mux1_5_out)) ;
   MUX4X1_HV mux1_6(.A (pattern[20][g]), .B (pattern[21][g]), .C(pattern[22][g]), .D(pattern[23][g]), .S0 (fieldp[0]), .S1 (fieldp[1]), .Q (mux1_6_out)) ;
   MUX4X1_HV mux1_7(.A (pattern[24][g]), .B (pattern[25][g]), .C(pattern[26][g]), .D(pattern[27][g]), .S0 (fieldp[0]), .S1 (fieldp[1]), .Q (mux1_7_out)) ;
   MUX4X1_HV mux1_8(.A (pattern[28][g]), .B (pattern[29][g]), .C(pattern[30][g]), .D(pattern[31][g]), .S0 (fieldp[0]), .S1 (fieldp[1]), .Q (mux1_8_out)) ;

   // 2nd level MUXs
   wire mux2_1_out ;
   wire mux2_2_out ;
   MUX4X1_HV mux2_1(.A (mux1_1_out), .B (mux1_2_out), .C(mux1_3_out), .D(mux1_4_out), .S0 (fieldp[2]), .S1 (fieldp[3]), .Q (mux2_1_out)) ;
   MUX4X1_HV mux2_2(.A (mux1_5_out), .B (mux1_6_out), .C(mux1_7_out), .D(mux1_8_out), .S0 (fieldp[2]), .S1 (fieldp[3]), .Q (mux2_2_out)) ;

   // 3rd level MUX
   MUX2X1_HV mux3_1(.A (mux2_1_out), .B (mux2_2_out), .S (fieldp[4]), .Q (field_byte[g])) ;

   end
endgenerate




integer i ;


always @(posedge sclk)
begin
  // if serial is selected, shift all the buffer left by one 
  // and add in 'sin'
  if (ssel)
    begin
    	pattern[0] <= {pattern[0][buffer_width-2:0], sin} ;
    	for(i=1 ; i<=buffer_size-1 ; i=i+1)
    	begin
      		pattern[i] <= {pattern[i][buffer_width-2:0], pattern[i-1][buffer_width-1]} ;
    	end
	end

end


endmodule 
