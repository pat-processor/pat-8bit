module mux4(y, a, b, c, d, s0, s1) ;

input a, b, c, d, s0, s1 ;
output y ;

/*
wire sel0_0, sel0_1 ;

assign sel0_0 = s0 ? b : a ;
assign sel0_1 = s0 ? d : c ;
assign y = s1 ? sel0_1 : sel0_0 ;
*/
MUX4X1_HV mux4(.Q (y), .A (a), .B (b), .C (c), .D (d), .S0 (s0), .S1 (s1)) ;

endmodule


module mux2(y, a, b, s) ;

input a, b, s ;
output y ;

assign y = s ? b : a ;


endmodule


`timescale 1ns / 1ns
`define SEQ1ADR 0 // address of globally visible sequence buffer (1)
`define SEQ2ADR 1 // address of globally visible sequence buffer (2)
`define SEQCTRLADR 2 // address of globally visible sequence control
module buffers(sin, sout, ssel, saddr, bufp, buffer_select, current_buffer, fieldp, fieldp2, fieldp3, fieldp4, fieldwp, field_byte, field_in, field_write, clk) ;

parameter buffer_size = 22 ; // bytes
parameter buffer_width = 8 ; // bits
parameter no_bufs = 8 ;      // patternbuf instances


input sin, ssel ;
input [2:0] saddr ;
input [buffer_width-1:0] bufp ;
input [7:0] buffer_select ; // one-hot
input [buffer_size-1:0] fieldp ; 
input [buffer_size-1:0] fieldp2 ; 
input [buffer_size-1:0] fieldp3 ; 
input [buffer_size-1:0] fieldp4 ; 
input [buffer_size-1:0] fieldwp ; 
input clk ;
input [buffer_width-1:0] field_in ;
input field_write ;
output sout ;
output [buffer_width-1:0] field_byte ;

output [buffer_width-1:0] current_buffer [buffer_size] ; 
reg [buffer_width-1:0] current_buffer [buffer_size] ; 


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
assign sout = souts[saddr] ;
//assign sout = souts[0] ;

//assign current_buffer = bufs[buffer_select] ;

// null, invalid buffer
wire [buffer_width-1:0] null_buffer [buffer_size] ;
genvar g ;
for (g = 0 ; g < buffer_size ; g++)
begin
	assign null_buffer[g] = {buffer_width{1'bx}} ;
end

always @(buffer_select)
begin
	casex (buffer_select)
		8'b00000001: current_buffer <= bufs[0] ;
		8'b00000010: current_buffer <= bufs[1] ;
		8'b00000100: current_buffer <= bufs[2] ;
		8'b00001000: current_buffer <= bufs[3] ;
		8'b00010000: current_buffer <= bufs[4] ;
		8'b00100000: current_buffer <= bufs[5] ;
		8'b01000000: current_buffer <= bufs[6] ;
		8'b10000000: current_buffer <= bufs[7] ;
		default: current_buffer <= null_buffer ; // impossible condition
	endcase
end

/*
// Buffer select one-hot for fanout optimisation
wire [buffer_width-1:0] null_buffer [buffer_size] ;
genvar g ;
for (g = 0 ; g < buffer_size ; g++)
begin
	assign null_buffer[g] = {buffer_width{1'bx}} ;
end

assign current_buffer = (buffer_select[0]) ? bufs[0] :
			(buffer_select[1]) ? bufs[1] :
			(buffer_select[2]) ? bufs[2] :
			(buffer_select[3]) ? bufs[3] :
			(buffer_select[4]) ? bufs[4] :
			(buffer_select[5]) ? bufs[5] :
			(buffer_select[6]) ? bufs[6] :
			bufs[7] ;
// not-allowed to not be selected since one-hot
			//null_buffer ;
			
*/		

// assign the patternbyte to the relevant
// buffer,
//
//assign field_byte = field_bytes[bufp] ;
//


// I could pipeline this to meet timing, like for the current_buffer above.
assign field_byte = (bufp[0]) ? field_bytes[0] :
		    (bufp[1]) ? field_bytes[1] :
		    (bufp[2]) ? field_bytes[2] :
		    (bufp[3]) ? field_bytes[3] :
		    (bufp[4]) ? field_bytes[4] :
		    (bufp[5]) ? field_bytes[5] :
		    (bufp[6]) ? field_bytes[6] :
		    field_bytes[7] ;




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
	.S0 (buffer_select[0]), .S1 (buffer_select[1]), .Q( bufmux1_1out)) ;

MUX4X1_HV mux1_2(.A (bufmux1_2in[0]), .B (bufmux1_2in[1]),
	.C (bufmux1_2in[2]), .D (bufmux1_2in[3]),
	.S0 (buffer_select[0]), .S1 (buffer_select[1]), .Q( bufmux1_2out)) ;
*/

/*
assign bufmux1_1out = bufmux1_1in[buffer_select[1:0]] ;
assign bufmux1_2out = bufmux1_2in[buffer_select[1:0]] ;


wire bufmux2_1out ;
assign bufmux2_1out = buffer_select[2] ? bufmux1_1out : bufmux1_2out ;
assign current_buffer[0] = bufmux2_1out ; 
*/


// split into two to reduce fanout problems
//assign current_buffer[0:(buffer_size/2)-1][buffer_width-1:0] = bufs[buffer_select][buffer_width-1:0][0:(buffer_size/2)-1] ;
//assign current_buffer[buffer_size/2:buffer_size-1][buffer_width-1:0] = bufs[buffer_select2][buffer_width-1:0][buffer_size/2:buffer_size-1] ;
//assign current_buffer[0:(buffer_size/2)-1] = bufs[buffer_select][0:(buffer_size/2)-1] ;
//assign current_buffer[buffer_size/2:buffer_size-1] = bufs[buffer_select2][buffer_size/2:buffer_size-1] ;

//genvar g, h, i ;


/*
// see if I can force some MUXs to be used
// Sims seem so tshow that Looks like 4s followed by a single 2 will be fastest (very marginally). -74 and -68ps.
//
generate for (g = 0 ; g < buffer_size ; g++)
begin
 for (h = 0 ; h < buffer_width ; h++)
 begin
   wire bufmuxout[4] ;
/*	
   mux2 bufmux0(bufmuxout[0], bufs[0][g][h], bufs[1][g][h], buffer_select[0]) ;
   mux2 bufmux1(bufmuxout[1], bufs[2][g][h], bufs[3][g][h], buffer_select[0]) ;
   mux2 bufmux2(bufmuxout[2], bufs[4][g][h], bufs[5][g][h], buffer_select[0]) ;
   mux2 bufmux3(bufmuxout[3], bufs[6][g][h], bufs[7][g][h], buffer_select[0]) ;

   mux4 bufmux4(current_buffer[g][h], bufmuxout[0], bufmuxout[1], bufmuxout[2], bufmuxout[3], buffer_select[1], buffer_select[2]) ;

   // OR...

   mux4 bufmux0(bufmuxout[0], bufs[0][g][h], bufs[1][g][h], bufs[2][g][h], bufs[3][g][h], buffer_select[0], buffer_select[1]) ;
   mux4 bufmux1(bufmuxout[1], bufs[4][g][h], bufs[5][g][h], bufs[6][g][h], bufs[7][g][h], buffer_select[0], buffer_select[1]) ;

   mux2 bufmux4(current_buffer[g][h], bufmuxout[0], bufmuxout[1], buffer_select[2]) ;
 end
end
endgenerate
*/

/*
generate for (i = 0 ; i < buffer_size ; i = i+1)
 begin 
   assign current_buffer[0] 
 end
endgenerate
*/



// below code seems to save 1ps over the direct assign above.
/*
genvar g, h ;

wire [no_bufs-1:0] field_bytes_swapped [buffer_width] ;
for (g = 0 ; g < buffer_width ; g++)
begin
	for (h = 0 ; h < no_bufs ; h++)
	begin
	       assign field_bytes_swapped[g][h] = field_bytes[h][g] ;
       end
	assign field_byte[g] = | field_bytes_swapped[g] ;
end
*/

/*
genvar g ;
generate for (g = 0 ; g < no_bufs ; g++)
begin
	assign field_byte = field_bytes[g] ;
end
endgenerate
*/

// try using tristate instead of MUX for the final step.
/* With patternbuf also using tristate => -370ps. Without => -300ps.
* Non-tristate logic: -331ps.
tri [buffer_width-1:0] field_bytes_tri [no_bufs] ;

genvar g ;
generate for (g = 0 ; g < no_bufs ; g++)
begin
	assign field_bytes_tri[g] = (bufp == g) ? field_bytes[g] : {buffer_width{1'bz}} ;
	assign field_byte = field_bytes_tri[g] ;
end
endgenerate
*/



//assign field_byte = current_buffer[fieldp] ;


wire field_write1 ;
wire field_write2 ;
wire field_write3 ;
wire field_write4 ;
wire field_write5 ;
wire field_write6 ;
wire field_write7 ;
wire field_write8 ;

assign field_write1 = (bufp[0] && field_write) ;
assign field_write2 = (bufp[1] && field_write) ;
assign field_write3 = (bufp[2] && field_write) ;
assign field_write4 = (bufp[3] && field_write) ;
assign field_write5 = (bufp[4] && field_write) ;
assign field_write6 = (bufp[5] && field_write) ;
assign field_write7 = (bufp[6] && field_write) ;
assign field_write8 = (bufp[7] && field_write) ;


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

patternbuf buffer1(buf1, ssel1, sin, souts[0], fieldp, fieldwp, field_bytes[0], field_in, field_write1, clk) ;
patternbuf buffer2(buf2, ssel2, sin, souts[1], fieldp, fieldwp, field_bytes[1], field_in, field_write2, clk) ;
patternbuf buffer3(buf3, ssel3, sin, souts[2], fieldp2, fieldwp, field_bytes[2], field_in, field_write3, clk) ;
patternbuf buffer4(buf4, ssel4, sin, souts[3], fieldp2, fieldwp, field_bytes[3], field_in, field_write4, clk) ;
patternbuf buffer5(buf5, ssel5, sin, souts[4], fieldp3, fieldwp, field_bytes[4], field_in, field_write5, clk) ;
patternbuf buffer6(buf6, ssel6, sin, souts[5], fieldp3, fieldwp, field_bytes[5], field_in, field_write6, clk) ;
patternbuf buffer7(buf7, ssel7, sin, souts[6], fieldp4, fieldwp, field_bytes[6], field_in, field_write7, clk) ;
patternbuf buffer8(buf8, ssel8, sin, souts[7], fieldp4, fieldwp, field_bytes[7], field_in, field_write8, clk) ;

endmodule
