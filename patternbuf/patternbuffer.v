`timescale 1ns / 1ns
module patternbuffer(clk, reset, pwm, sin, ssel, saddr, sout, field_byte_out, bufp_in, fieldp_in, fieldwp_in, field_in_in, field_write_in, p_drive, n_drive, tweak_global_delay, tweak_sense, tweak_enable, tweak_delay_0, tweak_duration_0, tweak_delay_1, tweak_duration_1, tweak_delay_2, tweak_duration_2, tweak_delay_3, tweak_duration_3, tweak_delay_4, tweak_duration_4, tweak_delay_5, tweak_duration_5) ;

// TODO: set the input delay constraints on fieldp_in, fieldwp_in,
// field_write_in, field_in_in

parameter buffer_size = 22 ;
parameter buffer_width = 6 ;
parameter no_bufs = 8 ;
parameter delay_width = 3 ; // size of tweak delay value
parameter pulse_duration = 2 ; // size of tweak duration value

defparam theBuffers.buffer_size = buffer_size ;
defparam theBuffers.buffer_width = buffer_width ;

input sin, ssel ;
input clk ; 
input pwm ;
input reset ;
input [2:0] saddr ;
input [buffer_width-1:0] field_in_in ;
input field_write_in ;
input [2:0] bufp_in ;
input [4:0] fieldp_in ;
input [4:0] fieldwp_in ; 

// test output
output sout ;
// output to pat
output [buffer_width-1:0] field_byte_out ;

// outputs to the drivers
output [buffer_width-1:0] p_drive ;
output [buffer_width-1:0] n_drive ;
output [buffer_width-1:0] tweak_global_delay ;
output [buffer_width-1:0] tweak_sense ;
output [buffer_width-1:0] tweak_enable ;
output [delay_width-1:0] tweak_delay_0 ;
output [delay_width-1:0] tweak_delay_1 ;
output [delay_width-1:0] tweak_delay_2 ;
output [delay_width-1:0] tweak_delay_3 ;
output [delay_width-1:0] tweak_delay_4 ;
output [delay_width-1:0] tweak_delay_5 ;
output [pulse_duration-1:0] tweak_duration_0 ;
output [pulse_duration-1:0] tweak_duration_1 ;
output [pulse_duration-1:0] tweak_duration_2 ;
output [pulse_duration-1:0] tweak_duration_3 ;
output [pulse_duration-1:0] tweak_duration_4 ;
output [pulse_duration-1:0] tweak_duration_5 ;

reg [7:0] bufp ;
reg [7:0] buffer_select ;
reg [buffer_size-1:0] fieldp ;
reg [buffer_size-1:0] fieldp2 ;
reg [buffer_size-1:0] fieldp3 ;
reg [buffer_size-1:0] fieldp4 ;
reg [buffer_size-1:0] fieldwp ;
reg [buffer_size-1:0] fieldwp_2 ;
reg [buffer_width-1:0] field_byte_out ;


wire [buffer_width-1:0] field_byte ;
wire [buffer_width-1:0] current_buffer [buffer_size] ;



reg [buffer_width-1:0] field_in ;
reg field_write ;

// synchronisation flops
reg ssel_sync_1 ;
reg ssel_sync_2 ;
reg sin_sync_1 ;
reg sin_sync_2 ;
reg [2:0] saddr_sync_1 ;
reg [2:0] saddr_sync_2 ;


// instantiate the pattern buffers
buffers theBuffers(sin_sync_2, sout, ssel_sync_2, saddr_sync_2, bufp, buffer_select, current_buffer, fieldp, fieldp2, fieldp3, fieldp4, fieldwp, fieldwp_2, field_byte, field_in, field_write, clk) ;



// define field offsets for the pattern data
`define PDRIVE_A 0
`define PDRIVE_B 1
`define PTWEAKENABLE  2
`define PTWEAKSENSE 3
`define PTWEAKDELAY 4
`define PTWEAK0 5
`define PTWEAK1 6
`define PTWEAK2 7
`define PTWEAK3 8
`define PTWEAK4 9
`define PTWEAK5 10

`define NDRIVE_A 11
`define NDRIVE_B 12
`define NTWEAKENABLE 13
`define NTWEAKSENSE 14
`define NTWEAKDELAY 15
`define NTWEAK0 16
`define NTWEAK1 17
`define NTWEAK2 18
`define NTWEAK3 19
`define NTWEAK4 20
`define NTWEAK5 21


reg [buffer_width-1:0] p_drive ;
reg [buffer_width-1:0] n_drive ;
reg [buffer_width-1:0] tweak_global_delay ;
reg [buffer_width-1:0] tweak_enable ;
reg [buffer_width-1:0] tweak_sense ;
reg [delay_width-1:0] tweak_delay_0 ;
reg [delay_width-1:0] tweak_delay_1 ;
reg [delay_width-1:0] tweak_delay_2 ;
reg [delay_width-1:0] tweak_delay_3 ;
reg [delay_width-1:0] tweak_delay_4 ;
reg [delay_width-1:0] tweak_delay_5 ;
reg [pulse_duration-1:0] tweak_duration_0 ;
reg [pulse_duration-1:0] tweak_duration_1 ;
reg [pulse_duration-1:0] tweak_duration_2 ;
reg [pulse_duration-1:0] tweak_duration_3 ;
reg [pulse_duration-1:0] tweak_duration_4 ;
reg [pulse_duration-1:0] tweak_duration_5 ;

reg pwm_prev ;
reg dead_time ; // track if we're in deadtime - disables output

always @(posedge clk)
begin

	// two-flop synchroniser on input signals
	ssel_sync_1 <= ssel ;
	ssel_sync_2 <= ssel_sync_1 ;
	sin_sync_1 <= sin ;
	sin_sync_2 <= sin_sync_1 ;
	saddr_sync_1 <= saddr ;
	saddr_sync_2 <= saddr_sync_1 ;

	// convert pat signals
	case (bufp_in)
		0: bufp <= 8'b00000001 ;
		1: bufp <= 8'b00000010 ;
		2: bufp <= 8'b00000100 ;
		3: bufp <= 8'b00001000 ;
		4: bufp <= 8'b00010000 ;
		5: bufp <= 8'b00100000 ;
		6: bufp <= 8'b01000000 ;
		7: bufp <= 8'b10000000 ;
		default: bufp <= 8'b00000001 ;
	endcase

	// duplicate fieldps for fanout reasons
	// use via multiple identical cases

	case (fieldp_in)
		0: fieldp <= 22'b0000000000000000000001 ;
		1: fieldp <= 22'b0000000000000000000010 ;
		2: fieldp <= 22'b0000000000000000000100 ;
		3: fieldp <= 22'b0000000000000000001000 ;
		4: fieldp <= 22'b0000000000000000010000 ;
		5: fieldp <= 22'b0000000000000000100000 ;
		6: fieldp <= 22'b0000000000000001000000 ;
		7: fieldp <= 22'b0000000000000010000000 ;
		8: fieldp <= 22'b0000000000000100000000 ;
		9: fieldp <= 22'b0000000000001000000000 ;
		10: fieldp <= 22'b0000000000010000000000 ;
		11: fieldp <= 22'b0000000000100000000000 ;
		12: fieldp <= 22'b0000000001000000000000 ;
		13: fieldp <= 22'b0000000010000000000000 ;
		14: fieldp <= 22'b0000000100000000000000 ;
		15: fieldp <= 22'b0000001000000000000000 ;
		16: fieldp <= 22'b0000010000000000000000 ;
		17: fieldp <= 22'b0000100000000000000000 ;
		18: fieldp <= 22'b0001000000000000000000 ;
		19: fieldp <= 22'b0010000000000000000000 ;
		20: fieldp <= 22'b0100000000000000000000 ;
		21: fieldp <= 22'b1000000000000000000000 ;
		default: fieldp <= 22'b0000000000000000000001 ;
	endcase

	case (fieldp_in)
		0: fieldp2 <= 22'b0000000000000000000001 ;
		1: fieldp2 <= 22'b0000000000000000000010 ;
		2: fieldp2 <= 22'b0000000000000000000100 ;
		3: fieldp2 <= 22'b0000000000000000001000 ;
		4: fieldp2 <= 22'b0000000000000000010000 ;
		5: fieldp2 <= 22'b0000000000000000100000 ;
		6: fieldp2 <= 22'b0000000000000001000000 ;
		7: fieldp2 <= 22'b0000000000000010000000 ;
		8: fieldp2 <= 22'b0000000000000100000000 ;
		9: fieldp2 <= 22'b0000000000001000000000 ;
		10: fieldp2 <= 22'b0000000000010000000000 ;
		11: fieldp2 <= 22'b0000000000100000000000 ;
		12: fieldp2 <= 22'b0000000001000000000000 ;
		13: fieldp2 <= 22'b0000000010000000000000 ;
		14: fieldp2 <= 22'b0000000100000000000000 ;
		15: fieldp2 <= 22'b0000001000000000000000 ;
		16: fieldp2 <= 22'b0000010000000000000000 ;
		17: fieldp2 <= 22'b0000100000000000000000 ;
		18: fieldp2 <= 22'b0001000000000000000000 ;
		19: fieldp2 <= 22'b0010000000000000000000 ;
		20: fieldp2 <= 22'b0100000000000000000000 ;
		21: fieldp2 <= 22'b1000000000000000000000 ;
		default: fieldp2 <= 22'b0000000000000000000001 ;
	endcase

	case (fieldp_in)
		0: fieldp3 <= 22'b0000000000000000000001 ;
		1: fieldp3 <= 22'b0000000000000000000010 ;
		2: fieldp3 <= 22'b0000000000000000000100 ;
		3: fieldp3 <= 22'b0000000000000000001000 ;
		4: fieldp3 <= 22'b0000000000000000010000 ;
		5: fieldp3 <= 22'b0000000000000000100000 ;
		6: fieldp3 <= 22'b0000000000000001000000 ;
		7: fieldp3 <= 22'b0000000000000010000000 ;
		8: fieldp3 <= 22'b0000000000000100000000 ;
		9: fieldp3 <= 22'b0000000000001000000000 ;
		10: fieldp3 <= 22'b0000000000010000000000 ;
		11: fieldp3 <= 22'b0000000000100000000000 ;
		12: fieldp3 <= 22'b0000000001000000000000 ;
		13: fieldp3 <= 22'b0000000010000000000000 ;
		14: fieldp3 <= 22'b0000000100000000000000 ;
		15: fieldp3 <= 22'b0000001000000000000000 ;
		16: fieldp3 <= 22'b0000010000000000000000 ;
		17: fieldp3 <= 22'b0000100000000000000000 ;
		18: fieldp3 <= 22'b0001000000000000000000 ;
		19: fieldp3 <= 22'b0010000000000000000000 ;
		20: fieldp3 <= 22'b0100000000000000000000 ;
		21: fieldp3 <= 22'b1000000000000000000000 ;
		default: fieldp3 <= 22'b0000000000000000000001 ;
	endcase

	case (fieldp_in)
		0: fieldp4 <= 22'b0000000000000000000001 ;
		1: fieldp4 <= 22'b0000000000000000000010 ;
		2: fieldp4 <= 22'b0000000000000000000100 ;
		3: fieldp4 <= 22'b0000000000000000001000 ;
		4: fieldp4 <= 22'b0000000000000000010000 ;
		5: fieldp4 <= 22'b0000000000000000100000 ;
		6: fieldp4 <= 22'b0000000000000001000000 ;
		7: fieldp4 <= 22'b0000000000000010000000 ;
		8: fieldp4 <= 22'b0000000000000100000000 ;
		9: fieldp4 <= 22'b0000000000001000000000 ;
		10: fieldp4 <= 22'b0000000000010000000000 ;
		11: fieldp4 <= 22'b0000000000100000000000 ;
		12: fieldp4 <= 22'b0000000001000000000000 ;
		13: fieldp4 <= 22'b0000000010000000000000 ;
		14: fieldp4 <= 22'b0000000100000000000000 ;
		15: fieldp4 <= 22'b0000001000000000000000 ;
		16: fieldp4 <= 22'b0000010000000000000000 ;
		17: fieldp4 <= 22'b0000100000000000000000 ;
		18: fieldp4 <= 22'b0001000000000000000000 ;
		19: fieldp4 <= 22'b0010000000000000000000 ;
		20: fieldp4 <= 22'b0100000000000000000000 ;
		21: fieldp4 <= 22'b1000000000000000000000 ;
		default: fieldp4 <= 22'b0000000000000000000001 ;
	endcase


	case (fieldwp_in)
		0: fieldwp <= 22'b0000000000000000000001 ;
		1: fieldwp <= 22'b0000000000000000000010 ;
		2: fieldwp <= 22'b0000000000000000000100 ;
		3: fieldwp <= 22'b0000000000000000001000 ;
		4: fieldwp <= 22'b0000000000000000010000 ;
		5: fieldwp <= 22'b0000000000000000100000 ;
		6: fieldwp <= 22'b0000000000000001000000 ;
		7: fieldwp <= 22'b0000000000000010000000 ;
		8: fieldwp <= 22'b0000000000000100000000 ;
		9: fieldwp <= 22'b0000000000001000000000 ;
		10: fieldwp <= 22'b0000000000010000000000 ;
		11: fieldwp <= 22'b0000000000100000000000 ;
		12: fieldwp <= 22'b0000000001000000000000 ;
		13: fieldwp <= 22'b0000000010000000000000 ;
		14: fieldwp <= 22'b0000000100000000000000 ;
		15: fieldwp <= 22'b0000001000000000000000 ;
		16: fieldwp <= 22'b0000010000000000000000 ;
		17: fieldwp <= 22'b0000100000000000000000 ;
		18: fieldwp <= 22'b0001000000000000000000 ;
		19: fieldwp <= 22'b0010000000000000000000 ;
		20: fieldwp <= 22'b0100000000000000000000 ;
		21: fieldwp <= 22'b1000000000000000000000 ;
		default: fieldwp <= 22'b0000000000000000000001 ;
	endcase


		case (fieldwp_in)
		0: fieldwp_2 <= 22'b0000000000000000000001 ;
		1: fieldwp_2 <= 22'b0000000000000000000010 ;
		2: fieldwp_2 <= 22'b0000000000000000000100 ;
		3: fieldwp_2 <= 22'b0000000000000000001000 ;
		4: fieldwp_2 <= 22'b0000000000000000010000 ;
		5: fieldwp_2 <= 22'b0000000000000000100000 ;
		6: fieldwp_2 <= 22'b0000000000000001000000 ;
		7: fieldwp_2 <= 22'b0000000000000010000000 ;
		8: fieldwp_2 <= 22'b0000000000000100000000 ;
		9: fieldwp_2 <= 22'b0000000000001000000000 ;
		10: fieldwp_2 <= 22'b0000000000010000000000 ;
		11: fieldwp_2 <= 22'b0000000000100000000000 ;
		12: fieldwp_2 <= 22'b0000000001000000000000 ;
		13: fieldwp_2 <= 22'b0000000010000000000000 ;
		14: fieldwp_2 <= 22'b0000000100000000000000 ;
		15: fieldwp_2 <= 22'b0000001000000000000000 ;
		16: fieldwp_2 <= 22'b0000010000000000000000 ;
		17: fieldwp_2 <= 22'b0000100000000000000000 ;
		18: fieldwp_2 <= 22'b0001000000000000000000 ;
		19: fieldwp_2 <= 22'b0010000000000000000000 ;
		20: fieldwp_2 <= 22'b0100000000000000000000 ;
		21: fieldwp_2 <= 22'b1000000000000000000000 ;
		default: fieldwp_2 <= 22'b0000000000000000000001 ;
	endcase




	field_byte_out <= field_byte ;
	field_write <= field_write_in ;
	field_in <= field_in_in ;

	/* Obsolted by cases
	// bufp and fieldp cannot be simulaneously incremented
	bufp <= bufp_in ;	 
	fieldp <= fieldp_in ;
	fieldp2 <= fieldp_in ;
	fieldp3 <= fieldp_in ;
	fieldp4 <= fieldp_in ;
	fieldwp <= fieldwp_in ;
	*/

       // **************************************
       // **************************************
       // now for the buffer selection
       pwm_prev <= pwm ;

       // implement counter which is reset by pwm
       // change and stays at its maximum value

       /* One hot implementation */
       // One cycle dead-time between pull up and pull down
       // reset also causes deadtime
       if ((pwm != pwm_prev) || reset) begin
	       dead_time <= 1'b1 ;
       end
       else if (dead_time) begin
	       dead_time <= 1'b0 ;
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

       if (!dead_time) begin
	       // high-driving phase
	       if (pwm_prev) begin
		       p_drive <= {current_buffer[`PDRIVE_A][3:0], current_buffer[`PDRIVE_B][3:0]} ;
		       n_drive <= {buffer_width{1'b0}} ; // off
		       // gate tweak drive based on the programmed sense w.r.t. the pwm signal
		       tweak_global_delay <= current_buffer[`PTWEAKDELAY] ;
		       tweak_sense <= current_buffer[`PTWEAKSENSE] ;
		       tweak_enable <= current_buffer[`PTWEAKENABLE] ;
		       tweak_delay_0 <= current_buffer[`PTWEAK0][2:0] ;
		       tweak_delay_1 <= current_buffer[`PTWEAK1][2:0] ;
		       tweak_delay_2 <= current_buffer[`PTWEAK2][2:0] ;
		       tweak_delay_3 <= current_buffer[`PTWEAK3][2:0] ;
		       tweak_delay_4 <= current_buffer[`PTWEAK4][2:0] ;
		       tweak_delay_5 <= current_buffer[`PTWEAK5][2:0] ;
		       // gate tweak pulse duration
			tweak_duration_0 <= current_buffer[`PTWEAK0][4:3] ;
			tweak_duration_1 <= current_buffer[`PTWEAK1][4:3] ;
			tweak_duration_2 <= current_buffer[`PTWEAK2][4:3] ;
			tweak_duration_3 <= current_buffer[`PTWEAK3][4:3] ;
			tweak_duration_4 <= current_buffer[`PTWEAK4][4:3] ;
			tweak_duration_5 <= current_buffer[`PTWEAK5][4:3] ;


	       end
	       // low-driving phase
	       else begin
		       p_drive <= {current_buffer[`NDRIVE_A][3:0], current_buffer[`NDRIVE_B][3:0]} ;
		       n_drive <= {buffer_width{1'b0}} ; // off
		       // gate tweak drive based on the programmed sense w.r.t. the pwm signal
		       tweak_global_delay <= current_buffer[`NTWEAKDELAY] ;
		       tweak_sense <= current_buffer[`NTWEAKSENSE] ;
		       tweak_enable <= current_buffer[`NTWEAKENABLE] ;
		       tweak_delay_0 <= current_buffer[`NTWEAK0][2:0] ;
		       tweak_delay_1 <= current_buffer[`NTWEAK1][2:0] ;
		       tweak_delay_2 <= current_buffer[`NTWEAK2][2:0] ;
		       tweak_delay_3 <= current_buffer[`NTWEAK3][2:0] ;
		       tweak_delay_4 <= current_buffer[`NTWEAK4][2:0] ;
		       tweak_delay_5 <= current_buffer[`NTWEAK5][2:0] ;
		       // gate tweak pulse duration
			tweak_duration_0 <= current_buffer[`NTWEAK0][4:3] ;
			tweak_duration_1 <= current_buffer[`NTWEAK1][4:3] ;
			tweak_duration_2 <= current_buffer[`NTWEAK2][4:3] ;
			tweak_duration_3 <= current_buffer[`NTWEAK3][4:3] ;
			tweak_duration_4 <= current_buffer[`NTWEAK4][4:3] ;
			tweak_duration_5 <= current_buffer[`NTWEAK5][4:3] ;

	       end
       end // end if (!dead_time)

       else begin // deadtime, so disable all outputs
	       p_drive <= {buffer_width{1'b1}} ;
	       n_drive <= 0 ;
	       tweak_enable <= 0 ;
	       tweak_global_delay <= 0 ;
	       tweak_sense <= 0 ;
	       tweak_delay_0 <= 0 ;
	       tweak_delay_1 <= 0 ;
	       tweak_delay_2 <= 0 ;
	       tweak_delay_3 <= 0 ;
	       tweak_delay_4 <= 0 ;
	       tweak_delay_5 <= 0 ;

	       tweak_duration_0 <= 0 ;
	       tweak_duration_1 <= 0 ;
	       tweak_duration_2 <= 0 ;
	       tweak_duration_3 <= 0 ;
	       tweak_duration_4 <= 0 ;
	       tweak_duration_5 <= 0 ;
       end


end


endmodule
