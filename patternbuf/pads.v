module pads (
	// scan chain
	scan_enable, scan_in_1, scan_out_1,
	// inputs
	clk_int, sout,
	// pads
	pad_vdd_core, pad_gnd_core, pad_vdd_1v8_all, pad_gnd_all, pad_clock_in, pad_clock_out, pad_reset, pad_modesel_0, pad_modesel_1, pad_mem_clock,
	pad_io_a0, pad_io_a1, pad_io_a2, pad_io_a3, pad_io_a4, pad_io_a5, pad_io_a6, pad_io_a7,
	pad_io_b0, pad_io_b1, pad_io_b2, pad_io_b3, pad_io_b4, pad_io_b5, pad_io_b6, pad_io_b7,
	pad_clock_select, pad_vref_select, pad_f5v_select,
	// outputs
	sclk, ssel, saddr, buf_fieldp, buf_fieldwp, field_write_en_low, field_write_en_high, field_fromPAT, field_toPAT_low, field_toPAT_high, clock_select, vref_select, f5v_select) ;

input pad_vdd_core ;
input pad_gnd_core ;
input pad_vdd_1v8_all ;
input pad_gnd_all ;
input clk_int ;
input sout ;

parameter d_width = 8 ;
parameter bufp_width = 3 ;
parameter fieldp_width = 5 ;

input scan_enable ;
input scan_in_1 ;
output scan_out_1 ;

output sclk ;
output ssel ;
output [2:0] saddr ;
output [(fieldp_width+bufp_width)-1:0] buf_fieldp ;
output [(fieldp_width+bufp_width)-1:0] buf_fieldwp ;
output field_write_en_low ;
output field_write_en_high ;
output [d_width-1:0] field_fromPAT ;
output [d_width-1:0] field_toPAT_low ;
output [d_width-1:0] field_toPAT_high ;


inout pad_clock_in ;
input pad_clock_out ;
inout pad_reset ;
inout pad_modesel_0 ;
inout pad_modesel_1 ;
inout pad_mem_clock ;

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
inout pad_clock_select ;
inout pad_vref_select ;
inout pad_f5v_select ;

wire io_a_input_enable ;
wire io_b_input_enable ;
wire io_a_output_enable ;
wire io_b_output_enable ;

wire reset ; 
wire modesel_0 ;
wire modesel_1 ;
wire clock_out ;
wire mem_clock ;

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

// analogue outputs
output clock_select ;
output vref_select ;
output f5v_select ;


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
IOPAD1V8_3_HV iopad_clock_in(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_clock_in), .Y(clk_ext)) ;
IOPAD1V8_3_HV iopad_reset(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_reset), .Y(reset)) ;
IOPAD1V8_3_HV iopad_modesel_0(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_modesel_0), .Y(modesel_0)) ;
IOPAD1V8_3_HV iopad_modesel_1(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_modesel_1), .Y(modesel_1)) ;

// Output-only pins
IOPAD1V8_3_HV iopad_clock_out(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(clock_out), .IE(vdd_logic0), .OE0(vdd_logic1), .OE1(vdd_logic1), .PAD (pad_clock_out), .Y( )) ;

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

// Pins for analogue section
IOPAD1V8_3_HV iopad_clock_select(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_clock_select), .Y(clock_select)) ;
IOPAD1V8_3_HV iopad_vref_select(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_vref_select), .Y(vref_select)) ;
IOPAD1V8_3_HV iopad_f5v_select(.SR(vdd_logic0), .PE(vdd_logic0), .VDD_LOGIC1(vdd_logic1), .VDD_LOGIC0(vdd_logic0), .A(vdd_logic0), .IE(vdd_logic1), .OE0(vdd_logic0), .OE1(vdd_logic0), .PAD (pad_f5v_select), .Y(f5v_select)) ;


// MODES:
// 0 := Debug: io_a input; io_b output
// 1 := Memory load: io_a & io_b input
// 2 := Run: io_a input; io_b output
wire [1:0] mode ;
assign mode[0] = modesel_0 ;
assign mode[1] = modesel_1 ;


// Mode 0: Debug
assign sclk = (mode == 0) ? io_a0_in : 1'b0 ;
assign ssel = (mode == 0) ? io_a1_in : 1'b0 ;
assign sin = (mode == 0) ? io_a2_in : 1'b0 ;
assign saddr[0] = (mode == 0) ? io_a3_in : 1'b0 ;
assign saddr[1] = (mode == 0) ? io_a4_in : 1'b0 ;
assign saddr[2] = (mode == 0) ? io_a5_in : 1'b0 ;
assign scan_enable = (mode == 0) ? io_a6_in : 1'b0 ;
assign scan_in_1 = (mode == 0) ? io_a7_in : 1'b0 ;

wire[7:0] outputs ;
assign io_b0_out = (mode == 0) ? sout : outputs[0] ;
assign io_b1_out = (mode == 0) ? scan_out_1 : outputs[1] ;
assign io_b2_out = (mode == 0) ? 1'b0 : outputs[2] ;
assign io_b3_out = (mode == 0) ? 1'b0 : outputs[3] ;
assign io_b4_out = (mode == 0) ? 1'b0 : outputs[4] ;
assign io_b5_out = (mode == 0) ? 1'b0 : outputs[5] ;
assign io_b6_out = (mode == 0) ? 1'b0 : outputs[6] ;
assign io_b7_out = (mode == 0) ? 1'b0 : outputs[7] ;

/*
wire [7:0] acc_out ;
assign io_a0_out = acc_out[0] ;
assign io_a1_out = acc_out[1] ;
assign io_a2_out = acc_out[2] ;
assign io_a3_out = acc_out[3] ;
assign io_a4_out = acc_out[4] ;
assign io_a5_out = acc_out[5] ;
assign io_a6_out = acc_out[6] ;
assign io_a7_out = acc_out[7] ;
*/

/*
wire [7:0] inputs_b ;
assign inputs_b[0] = io_b0_in ;
assign inputs_b[1] = io_b1_in ;
assign inputs_b[2] = io_b2_in ;
assign inputs_b[3] = io_b3_in ;
assign inputs_b[4] = io_b4_in ;
assign inputs_b[5] = io_b5_in ;
assign inputs_b[6] = io_b6_in ;
assign inputs_b[7] = io_b7_in ;
*/

// PAT INPUT
wire [7:0] inputs_a ;
assign inputs_a[0] = io_a0_in ;
assign inputs_a[1] = io_a1_in ;
assign inputs_a[2] = io_a2_in ;
assign inputs_a[3] = io_a3_in ;
assign inputs_a[4] = io_a4_in ;
assign inputs_a[5] = io_a5_in ;
assign inputs_a[6] = io_a6_in ;
assign inputs_a[7] = io_a7_in ;

wire imem_clock ;
wire imem_write ;
assign imem_clock = io_b0_in ;
assign imem_write = io_b1_in ;

// synchronise asynchronous inputs with a two-flop synchroniser
reg [7:0] inputs_a_sync_1 ;
reg [7:0] inputs_a_synched ;
reg imem_clock_sync_1 ;
reg imem_clock_synched ;
reg imem_write_sync_1 ;
reg imem_write_synched ;
always @(posedge clk_int) begin
	inputs_a_sync_1 <= inputs_a ;
	inputs_a_synched <= inputs_a_sync_1 ;
	imem_clock_sync_1 <= imem_clock ;
	imem_clock_synched <= imem_clock_sync_1 ;
	imem_write_sync_1 <= imem_write ;
	imem_write_synched <= imem_write_sync_1 ;
end

// **** Functionality ****

// Map these enables properly
assign io_a_input_enable = vdd_logic1 ;
assign io_a_output_enable = vdd_logic0 ;

assign io_b_input_enable = (mode == 1) ? vdd_logic1 : vdd_logic0 ;
assign io_b_output_enable = (mode == 1) ? vdd_logic0 : vdd_logic1 ;


// iMem initialisation


reg [49:0] input_shifter ;
wire [9:0] imem_write_adr ;
wire [39:0] imem_in ;

// shift data address and value to write in on port a
always @(posedge imem_clock_synched) begin
	   input_shifter <= (input_shifter[41:0] << 8) | inputs_a_synched ;
end

assign imem_write_adr = input_shifter[49:40] ;
assign imem_in = input_shifter[39:0] ;


// Instantiate the cores
//                I     I      I         I               I         I        O        O
digital theCore(clk_int, reset, inputs_a_synched, imem_write_adr, imem_write_synched, imem_in, outputs, acc_out,
buf_fieldp, buf_fieldwp, field_write_en_low, field_write_en_high, field_fromPAT, field_toPAT_low, field_toPAT_high) ;


// clock divider
reg [2:0] clk_div ;
assign clock_out  = clk_div[2] ;
always @(posedge clk_int) begin
	clk_div <= clk_div + 1 ;
end


// Wire up the power supplies
//
// Power on Reset
PORGEN_1V8_HV porGen() ;
// Pad VDD & GND
GNDPAD1V8ALL_HV gndAll( .PAD(pad_gnd_all)) ;
// alternative to split core and I/O supplies with GNDPAD1V8_CORE_HV and
// GNDPAD1V8_HV
VDDPAD1V8ALL_HV vddAll( .PAD(pad_vdd_1v8_all)) ;

GNDPAD1V8_CORE_HV gndCore_0( .PAD(pad_gnd_core)) ;
VDDPAD1V8_CORE_HV vddCore_0( .PAD(pad_vdd_core)) ;
GNDPAD1V8_CORE_HV gndCore_1( .PAD(pad_gnd_core)) ;
VDDPAD1V8_CORE_HV vddCore_1( .PAD(pad_vdd_core)) ;

//APRIO1V800VHC gndCore_0( .PAD(pad_gnd_core), .Z(gnd)) ;
//APRIO1V800VHC vddCore_0( .PAD(pad_vdd_core), .Z(vdd)) ;
//APRIO1V800VHC gndCore_1( .PAD(pad_gnd_core), .Z(gnd)) ;
//APRIO1V800VHC vddCore_1( .PAD(pad_vdd_core), .Z(vdd)) ;

endmodule
