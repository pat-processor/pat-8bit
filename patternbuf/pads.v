module pads (clk, pad_clock, pad_sclk, pad_reset, pad_modesel_0, pad_modesel_1, 
	pad_io_a0, pad_io_a1, pad_io_a2, pad_io_a3, pad_io_a4, pad_io_a5, pad_io_a6, pad_io_a7,
	pad_io_b0, pad_io_b1, pad_io_b2, pad_io_b3, pad_io_b4, pad_io_b5, pad_io_b6, pad_io_b7) ;

input clk ;

inout pad_clock ;
inout pad_sclk ;
inout pad_reset ;
inout pad_modesel_0 ;
inout pad_modesel_1 ;

inout pad_io_a0 ;
inout pad_io_a1 ;
inout pad_io_a2 ;
inout pad_io_a3 ;
inout pad_io_a4 ;
inout pad_io_a5 ;
inout pad_io_a6 ;
inout pad_io_a7 ;

inout pad_io_b0 ;
inout pad_io_b1 ;
inout pad_io_b2 ;
inout pad_io_b3 ;
inout pad_io_b4 ;
inout pad_io_b5 ;
inout pad_io_b6 ;
inout pad_io_b7 ;

wire io_a_input_enable ;
wire io_b_input_enable ;
wire io_a_output_enable ;
wire io_b_output_enable ;

wire clk_ext ;
wire reset ; 
wire sclk ;
wire modesel_0 ;
wire modesel_1 ;

wire io_a0_in ;
wire io_a1_in ;
wire io_a2_in ;
wire io_a3_in ;
wire io_a4_in ;
wire io_a5_in ;
wire io_a6_in ;
wire io_a7_in ;

wire io_a0_out ;
wire io_a1_out ;
wire io_a2_out ;
wire io_a3_out ;
wire io_a4_out ;
wire io_a5_out ;
wire io_a6_out ;
wire io_a7_out ;

wire io_b0_in ;
wire io_b1_in ;
wire io_b2_in ;
wire io_b3_in ;
wire io_b4_in ;
wire io_b5_in ;
wire io_b6_in ;
wire io_b7_in ;

wire io_b0_out ;
wire io_b1_out ;
wire io_b2_out ;
wire io_b3_out ;
wire io_b4_out ;
wire io_b5_out ;
wire io_b6_out ;
wire io_b7_out ;


// IOPads: .VDDLOGIC1 and .VDDLOGIC0 are outputs
//
// Also available: Analogue pads with only "PAD" and "Z" pins: 
// APRIO1V8_00{'', _HC, _VHC}, APRIO1V8_1k4, APRIO1V8_200, APRIO1V8_500, APRIO1V8_50
//
// Input-only pins
IOPAD1V8_3_HV iopad_clock(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(1'b0), .IE(1'b1), .OE0(1'b0), .OE1(1'b0), .PAD (pad_clock), .Y(clk_ext)) ;
IOPAD1V8_3_HV iopad_reset(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(1'b0), .IE(1'b1), .OE0(1'b0), .OE1(1'b0), .PAD (pad_reset), .Y(reset)) ;
IOPAD1V8_3_HV iopad_sclk(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(1'b0), .IE(1'b1), .OE0(1'b0), .OE1(1'b0), .PAD (pad_sclk), .Y(sclk)) ;
IOPAD1V8_3_HV iopad_modesel_0(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(1'b0), .IE(1'b1), .OE0(1'b0), .OE1(1'b0), .PAD (pad_modesel_0), .Y(modesel_0)) ;

IOPAD1V8_3_HV iopad_modesel_1(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(1'b0), .IE(1'b1), .OE0(1'b0), .OE1(1'b0), .PAD (pad_modesel_1), .Y(modesel_1)) ;

// Bi-directional pins
IOPAD1V8_3_HV iopad_a0(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_a0_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a0), .Y(io_a0_in)) ;
IOPAD1V8_3_HV iopad_a1(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_a1_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a1), .Y(io_a1_in)) ;
IOPAD1V8_3_HV iopad_a2(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_a2_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a2), .Y(io_a2_in)) ;
IOPAD1V8_3_HV iopad_a3(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_a3_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a3), .Y(io_a3_in)) ;
IOPAD1V8_3_HV iopad_a4(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_a4_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a4), .Y(io_a4_in)) ;
IOPAD1V8_3_HV iopad_a5(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_a5_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a5), .Y(io_a5_in)) ;
IOPAD1V8_3_HV iopad_a6(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_a6_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a6), .Y(io_a6_in)) ;
IOPAD1V8_3_HV iopad_a7(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_a7_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a7), .Y(io_a7_in)) ;

IOPAD1V8_3_HV iopad_b0(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_b0_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b0), .Y(io_b0_in)) ;
IOPAD1V8_3_HV iopad_b1(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_b1_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b1), .Y(io_b1_in)) ;
IOPAD1V8_3_HV iopad_b2(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_b2_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b2), .Y(io_b2_in)) ;
IOPAD1V8_3_HV iopad_b3(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_b3_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b3), .Y(io_b3_in)) ;
IOPAD1V8_3_HV iopad_b4(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_b4_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b4), .Y(io_b4_in)) ;
IOPAD1V8_3_HV iopad_b5(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_b5_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b5), .Y(io_b5_in)) ;
IOPAD1V8_3_HV iopad_b6(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_b6_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b6), .Y(io_b6_in)) ;
IOPAD1V8_3_HV iopad_b7(.SR(1'b0), .PE(1'b0), .VDD_LOGIC1( ), .VDD_LOGIC0( ), .A(io_b7_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b7), .Y(io_b7_in)) ;

wire [7:0] inputs_a ;
assign inputs_a[0] = io_a0_in ;
assign inputs_a[1] = io_a1_in ;
assign inputs_a[2] = io_a2_in ;
assign inputs_a[3] = io_a3_in ;
assign inputs_a[4] = io_a4_in ;
assign inputs_a[5] = io_a5_in ;
assign inputs_a[6] = io_a6_in ;
assign inputs_a[7] = io_a7_in ;

wire [7:0] acc_out ;
assign io_a0_out = acc_out[0] ;
assign io_a1_out = acc_out[1] ;
assign io_a2_out = acc_out[2] ;
assign io_a3_out = acc_out[3] ;
assign io_a4_out = acc_out[4] ;
assign io_a5_out = acc_out[5] ;
assign io_a6_out = acc_out[6] ;
assign io_a7_out = acc_out[7] ;

wire [7:0] inputs_b ;
assign inputs_b[0] = io_b0_in ;
assign inputs_b[1] = io_b1_in ;
assign inputs_b[2] = io_b2_in ;
assign inputs_b[3] = io_b3_in ;
assign inputs_b[4] = io_b4_in ;
assign inputs_b[5] = io_b5_in ;
assign inputs_b[6] = io_b6_in ;
assign inputs_b[7] = io_b7_in ;

wire [7:0] outputs ;
assign io_b0_out = outputs[0] ; 
assign io_b1_out = outputs[1] ; 
assign io_b2_out = outputs[2] ; 
assign io_b3_out = outputs[3] ; 
assign io_b4_out = outputs[4] ; 
assign io_b5_out = outputs[5] ; 
assign io_b6_out = outputs[6] ; 
assign io_b7_out = outputs[7] ; 


// **** Functionality ****

wire imem_write ;
assign imem_write = modesel_0 ;

reg [49:0] input_shifter ;
wire [9:0] imem_write_adr ;
wire [39:0] imem_in ;

// shift data address and value to write in on port a
//
// TODO: The shifter is partly optimised out. Why?
// Pattern: *: optimised out; X: in use
// 9876543210 9876543210 9876543210 9876543210 9876543210
// XX******** XXXXXXXX** ******XXXX XXXX****** **XXXXXXXX
always @(posedge modesel_1) begin
	   input_shifter <= (input_shifter[41:0] << 8) | inputs_a ;
end

assign imem_write_adr = input_shifter[49:40] ;
assign imem_in = input_shifter[39:0] ;

// TODO: Map these enables properly
assign io_a_input_enable = 1'b1 ;
assign io_b_input_enable = 1'b0 ;
assign io_a_output_enable = 1'b0 ;
assign io_b_output_enable = 1'b1 ;

//                I     I      I         I               I         I        O        O
digital theCore(clk, reset, inputs_a, imem_write_adr, imem_write, imem_in, outputs, acc_out) ;



endmodule
