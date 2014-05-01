`timescale 1ns / 1ns
module patternbuffer(clk, pwm, sclk, sin, ssel, saddr, sout, field_byte_out, bufp_in, fieldp_in, fieldwp_in, field_in_in, field_write_in, p_drive, n_drive, tweak_delay, tweak_sense, tweak_drive_0, tweak_drive_1, tweak_drive_2, tweak_drive_3, tweak_drive_4, tweak_drive_5, tweak_drive_6, tweak_drive_7) ;

parameter buffer_size = 22 ;
parameter buffer_width = 8 ;
parameter no_bufs = 8 ;

defparam theBuffers.buffer_size = buffer_size ;
defparam theBuffers.buffer_width = buffer_width ;

input sin, sclk, ssel ;
input clk ; 
input pwm ;
input [2:0] saddr ;
input [buffer_width-1:0] field_in_in ;
input field_write_in ;
input [7:0] bufp_in ;
input [buffer_size-1:0] fieldp_in ;
input [buffer_size-1:0] fieldwp_in ;

// test output
output sout ;
// output to pat
output [buffer_width-1:0] field_byte_out ;

// outputs to the drivers
output [buffer_width-1:0] p_drive ;
output [buffer_width-1:0] n_drive ;
output [buffer_width-1:0] tweak_delay ;
output [buffer_width-1:0] tweak_sense ;
output [buffer_width-1:0] tweak_drive_0 ;
output [buffer_width-1:0] tweak_drive_1 ;
output [buffer_width-1:0] tweak_drive_2 ;
output [buffer_width-1:0] tweak_drive_3 ;
output [buffer_width-1:0] tweak_drive_4 ;
output [buffer_width-1:0] tweak_drive_5 ;
output [buffer_width-1:0] tweak_drive_6 ;
output [buffer_width-1:0] tweak_drive_7 ;

reg [7:0] bufp ;
reg [7:0] buffer_select ;
reg [buffer_size-1:0] fieldp ;
reg [buffer_size-1:0] fieldwp ;
reg [buffer_width-1:0] field_byte_out ;


wire [buffer_width-1:0] field_byte ;
wire [buffer_width-1:0] current_buffer [buffer_size] ;



reg [buffer_width-1:0] field_in ;
reg field_write ;

buffers theBuffers(sclk, sin, sout, ssel, saddr, bufp, buffer_select, current_buffer, fieldp, fieldwp, field_byte, field_in, field_write, clk) ;



// define field offsets for the pattern data
`define PDRIVE 0
`define NDRIVE 1
`define PTWEAKSENSE 2
`define PTWEAKDELAY 3
`define PTWEAK0 4
`define PTWEAK1 5
`define PTWEAK2 6
`define PTWEAK3 7
`define PTWEAK4 8
`define PTWEAK5 9
`define PTWEAK6 10
`define PTWEAK7 11

`define NTWEAKSENSE 12
`define NTWEAKDELAY 13
`define NTWEAK0 14
`define NTWEAK1 15
`define NTWEAK2 16
`define NTWEAK3 17
`define NTWEAK4 18
`define NTWEAK5 19
`define NTWEAK6 20
`define NTWEAK7 21


reg [buffer_width-1:0] p_drive ;
reg [buffer_width-1:0] n_drive ;
reg [buffer_width-1:0] tweak_delay ;
reg [buffer_width-1:0] tweak_sense ;
reg [buffer_width-1:0] tweak_drive_0 ;
reg [buffer_width-1:0] tweak_drive_1 ;
reg [buffer_width-1:0] tweak_drive_2 ;
reg [buffer_width-1:0] tweak_drive_3 ;
reg [buffer_width-1:0] tweak_drive_4 ;
reg [buffer_width-1:0] tweak_drive_5 ;
reg [buffer_width-1:0] tweak_drive_6 ;
reg [buffer_width-1:0] tweak_drive_7 ;


/*
reg [buffer_width-1:0] n_drive ;
reg [buffer_width-1:0] tweak_delay_n ;
reg [buffer_width-1:0[ tweak_sense_n ;
reg [buffer_width-1:0] tweak_drive_n0 ;
reg [buffer_width-1:0] tweak_drive_n1 ;
reg [buffer_width-1:0] tweak_drive_n2 ;
reg [buffer_width-1:0] tweak_drive_n3 ;
reg [buffer_width-1:0] tweak_drive_n4 ;
reg [buffer_width-1:0] tweak_drive_n5 ;
reg [buffer_width-1:0] tweak_drive_n6 ;
reg [buffer_width-1:0] tweak_drive_n7 ;
*/

/*
assign p_drive = current_buffer[`PDRIVE] ;
assign n_drive = current_buffer[`NDRIVE] ;
assign tweak_sense = current_buffer[`TWEAKSENSE] ;
assign tweak_delay = current_buffer[`TWEAKDELAY] ;

// gate tweak drive based on the programmed sense w.r.t. the pwm signal
assign tweak_drive_0 = current_buffer[`TWEAK0] && (tweak_sense[0] == pwm) ;
assign tweak_drive_1 = current_buffer[`TWEAK1] && (tweak_sense[1] == pwm) ;
assign tweak_drive_2 = current_buffer[`TWEAK2] && (tweak_sense[2] == pwm) ;
assign tweak_drive_3 = current_buffer[`TWEAK3] && (tweak_sense[3] == pwm) ;
assign tweak_drive_4 = current_buffer[`TWEAK4] && (tweak_sense[4] == pwm) ;
assign tweak_drive_5 = current_buffer[`TWEAK5] && (tweak_sense[5] == pwm) ;
assign tweak_drive_6 = current_buffer[`TWEAK6] && (tweak_sense[6] == pwm) ;
assign tweak_drive_7 = current_buffer[`TWEAK7] && (tweak_sense[7] == pwm) ;
*/




reg pwm_prev ;

always @(posedge clk)
begin
 // pat signals
 // bufp and fieldp cannot be simulaneously incremented
 bufp <= bufp_in ;	 
 fieldp <= fieldp_in ;
 fieldwp <= fieldwp_in ;
 field_byte_out <= field_byte ;
 field_write <= field_write_in ;
 field_in <= field_in_in ;

 // now for the buffer selection
 pwm_prev <= pwm ;

 // implement counter which is reset by pwm
 // change and stays at its maximum value
 
 /* One hot implementation */
 if (pwm != pwm_prev) begin
	 buffer_select <= 8'b00000001 ;
 end
 else begin
	 if (buffer_select[no_bufs-1] == 1'b1) begin
		 buffer_select <= {1'b1, {no_bufs-1{1'b0}}} ;
	 end
	 else begin
		 buffer_select <= buffer_select << 1 ;
	 end
 end
 

 /* standard counter implementation 
 if (pwm != pwm_prev) begin
	 buffer_select <= 0 ;
 end
 else begin
	 if (buffer_select == 7) begin
		 buffer_select <= 7 ;
	 end
	 else begin
		 buffer_select <= buffer_select + 1 ;
	 end
 end
*/



// high-driving phase
if (pwm_prev) begin
	p_drive <= current_buffer[`PDRIVE] ;
	n_drive <= {buffer_width{1'b0}} ; // off
	// gate tweak drive based on the programmed sense w.r.t. the pwm signal
	tweak_delay <= current_buffer[`PTWEAKDELAY] ;
	tweak_sense <= current_buffer[`PTWEAKSENSE] ;
	tweak_drive_0 <= current_buffer[`PTWEAK0] ;
	tweak_drive_1 <= current_buffer[`PTWEAK1] ;
	tweak_drive_2 <= current_buffer[`PTWEAK2] ;
	tweak_drive_3 <= current_buffer[`PTWEAK3] ;
	tweak_drive_4 <= current_buffer[`PTWEAK4] ;
	tweak_drive_5 <= current_buffer[`PTWEAK5] ;
	tweak_drive_6 <= current_buffer[`PTWEAK6] ;
	tweak_drive_7 <= current_buffer[`PTWEAK7] ;
end
// low-driving phase
else begin
	n_drive <= current_buffer[`NDRIVE] ;
	p_drive <= {buffer_width{1'b1}} ; // off TODO: Check what sense David wants for off
	// gate tweak drive based on the programmed sense w.r.t. the pwm signal
	tweak_delay <= current_buffer[`NTWEAKDELAY] ;
	tweak_sense <= current_buffer[`NTWEAKSENSE] ;
	tweak_drive_0 <= current_buffer[`NTWEAK0] ;
	tweak_drive_1 <= current_buffer[`NTWEAK1] ;
	tweak_drive_2 <= current_buffer[`NTWEAK2] ;
	tweak_drive_3 <= current_buffer[`NTWEAK3] ;
	tweak_drive_4 <= current_buffer[`NTWEAK4] ;
	tweak_drive_5 <= current_buffer[`NTWEAK5] ;
	tweak_drive_6 <= current_buffer[`NTWEAK6] ;
	tweak_drive_7 <= current_buffer[`NTWEAK7] ;
end


end

  
endmodule
