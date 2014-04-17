`timescale 1ns / 1ns
module patternbuffer(clk, pwm, sclk, sin, ssel, saddr, sout, field_byte_out, bufp_in, fieldp_in, fieldwp_in, field_in_in, field_write_in, p_drive, n_drive, tweak_delay, tweak_drive_0, tweak_drive_1, tweak_drive_2, tweak_drive_3, tweak_drive_4, tweak_drive_5, tweak_drive_6, tweak_drive_7) ;

parameter buffer_size = 12 ;
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

// test output
output sout ;
// output to pat
output [buffer_width-1:0] field_byte_out ;

// outputs to the drivers
output [buffer_width-1:0] p_drive ;
output [buffer_width-1:0] n_drive ;
output [buffer_width-1:0] tweak_delay ;
output [buffer_width-1:0] tweak_drive_0 ;
output [buffer_width-1:0] tweak_drive_1 ;
output [buffer_width-1:0] tweak_drive_2 ;
output [buffer_width-1:0] tweak_drive_3 ;
output [buffer_width-1:0] tweak_drive_4 ;
output [buffer_width-1:0] tweak_drive_5 ;
output [buffer_width-1:0] tweak_drive_6 ;
output [buffer_width-1:0] tweak_drive_7 ;

reg [2:0] bufp ;
reg [2:0] buffer_select ;
reg prev_pwm ;
reg [buffer_size-1:0] fieldp ;
reg [buffer_size-1:0] fieldwp ;
reg [buffer_width-1:0] field_byte_out ;


wire [buffer_width-1:0] field_byte ;
wire [buffer_width-1:0] current_buffer [buffer_size] ;

wire [buffer_width-1:0] tweak_sense ;

input [2:0] bufp_in ;
input [buffer_size-1:0] fieldp_in ;
input [buffer_size-1:0] fieldwp_in ;

reg [buffer_width-1:0] field_in ;
reg field_write ;

buffers theBuffers(sclk, sin, sout, ssel, saddr, bufp, buffer_select, current_buffer, fieldp, fieldwp, field_byte, field_in, field_write, clk) ;





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
 prev_pwm <= pwm ;

 // implement counter which is reset by pwm
 // change and stays at its maximum value
 if (pwm != prev_pwm) buffer_select <= 0 ;
 else if (buffer_select == (no_bufs-1)) buffer_select <= (no_bufs-1) ;
 else buffer_select <= buffer_select + 1 ;

end

// define field offsets for the pattern data
`define PDRIVE 0
`define NDRIVE 1
`define TWEAKSENSE 2
`define TWEAKDELAY 3
`define TWEAK0 4
`define TWEAK1 5
`define TWEAK2 6
`define TWEAK3 7
`define TWEAK4 8
`define TWEAK5 9
`define TWEAK6 10
`define TWEAK7 11

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

  
endmodule
