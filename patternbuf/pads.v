module pads (clk_int, pad_vdd_core, pad_gnd_core, pad_vdd_1v8_all, pad_gnd_all, pad_clock, pad_scan_enable, pad_reset, pad_modesel_0, pad_modesel_1, pad_scan_in_1, pad_scan_out_1, 
	pad_io_a0, pad_io_a1, pad_io_a2, pad_io_a3, pad_io_a4, pad_io_a5, pad_io_a6, pad_io_a7,
	pad_io_b0, pad_io_b1, pad_io_b2, pad_io_b3, pad_io_b4, pad_io_b5, pad_io_b6, pad_io_b7) ;

input pad_vdd_core ;
input pad_gnd_core ;
input pad_vdd_1v8_all ;
input pad_gnd_all ;
input clk_int ;

inout pad_clock ;
inout pad_scan_enable ;
inout pad_reset ;
inout pad_modesel_0 ;
inout pad_modesel_1 ;
inout pad_scan_in_1 ;
inout pad_scan_out_1 ;

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
wire scan_enable ;
wire modesel_0 ;
wire modesel_1 ;
wire scan_in_1 ;
wire scan_out_1 ;

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
// PE: pull-enable: open pad to be pulled to zero/one (state of pin A). 100kOhm
// SR: output slew rate control, active high (0 fast / 1 slow)
// PAD output path core signal A -> to pad
// Y: output to the core
// IE: input enable, active high, IE=0 -> Y set to 0
// PADA: ESD protected analog In/Out function. no digital function
// OE: 00 - tristate; 01 1/3 drive strength; 10 2/3 drive strength ;
// 11 full drive strength

wire vdd_logic1 ;
wire vdd_logic0 ;

// Input-only pins
IOPAD1V8_3_HV iopad_clock(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_clock), .Y(clk_ext)) ;
IOPAD1V8_3_HV iopad_reset(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_reset), .Y(reset)) ;
IOPAD1V8_3_HV iopad_scan_enable(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_scan_enable), .Y(scan_enable)) ;
IOPAD1V8_3_HV iopad_modesel_0(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_modesel_0), .Y(modesel_0)) ;

IOPAD1V8_3_HV iopad_modesel_1(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_modesel_1), .Y(modesel_1)) ;
IOPAD1V8_3_HV iopad_scan_in_1(.SR(vdd_logic0), .PE(vdd_logic1), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_scan_in_1), .Y(scan_in_1)) ;

// Output-only pins
IOPAD1V8_3_HV iopad_scan_out_1(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(scan_out_1), .IE(vdd_logic0), .OE0(vdd_logic1), .OE1(vdd_logic1), .PAD (pad_modesel_1), .Y( )) ;

// Bi-directional pins
IOPAD1V8_3_HV iopad_a0(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_a0_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a0), .Y(io_a0_in)) ;
IOPAD1V8_3_HV iopad_a1(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_a1_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a1), .Y(io_a1_in)) ;
IOPAD1V8_3_HV iopad_a2(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_a2_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a2), .Y(io_a2_in)) ;
IOPAD1V8_3_HV iopad_a3(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_a3_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a3), .Y(io_a3_in)) ;
IOPAD1V8_3_HV iopad_a4(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_a4_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a4), .Y(io_a4_in)) ;
IOPAD1V8_3_HV iopad_a5(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_a5_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a5), .Y(io_a5_in)) ;
IOPAD1V8_3_HV iopad_a6(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_a6_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a6), .Y(io_a6_in)) ;
IOPAD1V8_3_HV iopad_a7(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_a7_out), .IE(io_a_input_enable), .OE0(io_a_output_enable), .OE1(io_a_output_enable), .PAD (pad_io_a7), .Y(io_a7_in)) ;

IOPAD1V8_3_HV iopad_b0(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_b0_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b0), .Y(io_b0_in)) ;
IOPAD1V8_3_HV iopad_b1(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_b1_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b1), .Y(io_b1_in)) ;
IOPAD1V8_3_HV iopad_b2(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_b2_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b2), .Y(io_b2_in)) ;
IOPAD1V8_3_HV iopad_b3(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_b3_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b3), .Y(io_b3_in)) ;
IOPAD1V8_3_HV iopad_b4(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_b4_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b4), .Y(io_b4_in)) ;
IOPAD1V8_3_HV iopad_b5(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_b5_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b5), .Y(io_b5_in)) ;
IOPAD1V8_3_HV iopad_b6(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_b6_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b6), .Y(io_b6_in)) ;
IOPAD1V8_3_HV iopad_b7(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(io_b7_out), .IE(io_b_input_enable), .OE0(io_b_output_enable), .OE1(io_b_output_enable), .PAD (pad_io_b7), .Y(io_b7_in)) ;

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
always @(posedge modesel_1) begin
	   input_shifter <= (input_shifter[41:0] << 8) | inputs_a ;
end

assign imem_write_adr = input_shifter[49:40] ;
assign imem_in = input_shifter[39:0] ;

// TODO: Map these enables properly
assign io_a_input_enable = vdd_logic1 ;
assign io_b_input_enable = vdd_logic0 ;
assign io_a_output_enable = vdd_logic0 ;
assign io_b_output_enable = vdd_logic1 ;

//                I     I      I         I               I         I        O        O
digital theCore(clk_int, reset, inputs_a, imem_write_adr, imem_write, imem_in, outputs, acc_out) ;


// Wire up the power supplies
//
// Power on Reset
PORGEN_1V8_HV porGen() ;
// Pad VDD & GND
GNDPAD1V8ALL_HV gndPad( .PAD(pad_gnd_all)) ;
// alternative to split core and I/O supplies with GNDPAD1V8_CORE_HV and
// GNDPAD1V8_HV
VDDPAD1V8ALL_HV vddPad( .PAD(pad_vdd_1v8_all)) ;

APRIO1V800VHC gndCore( .PAD(pad_gnd_core)) ;
APRIO1V800VHC vddCore( .PAD(pad_vdd_core)) ;


endmodule
