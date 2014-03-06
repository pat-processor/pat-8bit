module pat(pc, write_en, data_adr, data_out, bufp, fieldp, fieldwp, field_byte_out, instr, data_in, field_byte_in, clk) ;

parameter i_adr_width = 10 ; // instruction address space size
parameter i_width = 16 ; // instruction width
parameter d_adr_width = 8 ; // data address space size
parameter d_width = 8 ; // data width
parameter bufp_width = 3 ;
parameter fieldp_width = 5 ;
parameter buffer_width = 8 ;

input [i_width-1:0] instr ;
input [d_width-1:0] data_in;
input [buffer_width-1:0] field_byte_in ;
input clk ;

output [i_adr_width-1:0] pc ;
output write_en ;
output [d_adr_width-1:0] data_adr ;
output [d_width-1:0] data_out ;
output [bufp_width-1:0] bufp ;
output [fieldp_width-1:0] fieldp ;
output [fieldp_width-1:0] fieldwp ;
output [buffer_width-1:0] field_byte_out ;

reg [i_adr_width-1:0] pc ;
reg write_en ;
reg [d_adr_width-1:0] data_adr ;
reg [d_width-1:0] data_out ;
reg [bufp_width-1:0] bufp ;
reg [fieldp_width-1:0] fieldp ;
reg [fieldp_width-1:0] fieldwp ;
reg [buffer_width-1:0] field_byte_out ;

// instruction type selection
wire i_t_fb ;
wire i_t_fi3 ;
wire i_t_i8 ;
wire i_t_ldif ;

// instruction immediate values
wire [d_width-1:0] immediate ;
wire [2:0] immediate3 ;
wire [fieldp_width-1:0] field ;
wire [bufp_width-1:0] buffer ;
wire [i_width-1:0] opcode ;
wire [1:0] condition ;

// individual format immediates
wire [fieldp_width-1:0] field_ldif ;
wire [1:0] condition_ldif ;
wire [d_width-1:0] immediate_ldif ;
assign {condition_ldif, field_ldif, immediate_ldif} = instr ;

wire [(i_width-d_width)-3:0] opcode_i8 ;
wire [1:0] condition_i8 ;
wire [d_width-1:0] immediate_i8 ;
assign {opcode_i8, condition_i8, immediate_i8} = instr ;

wire [(i_width-(fieldp_width+2+3+1)):0] opcode_fi3 ;
wire [1:0] condition_fi3 ;
wire [fieldp_width-1:0] field_fi3 ;
wire [2:0] immediate3_fi3 ;
assign {opcode_fi3, condition_fi3, field_fi3, immediate3_fi3} = instr ;

wire [(i_width-(2+fieldp_width+bufp_width+1)):0] opcode_fb ;
wire [1:0] condition_fb ;
wire [fieldp_width-1:0] field_fb ;
wire [bufp_width-1:0] buffer_fb ;
assign {opcode_fb, condition_fb, field_fb, buffer_fb} = instr ;

task decode ;
	input [i_width-1:0] instr ;
	// outputs
	
	begin
	casex(instr)
		// LDIF
		{1'b1,{i_width-1{1'bx}}}: 
		begin
		        // call ldif instruction directly	
			i_ldif(condition_ldif, field_ldif, immediate_ldif) ;
		end

		// i8 format instruction
		{2'b01,{i_width-2{1'bx}}}:
		begin
			i_i8(opcode_i8, condition_i8, immediate_i8) ;
		end

		// fi3 format instruction
		{3'b001,{i_width-3{1'bx}}}:
		begin
			i_fi3(opcode_fi3, condition_fi3, field_fi3, immediate3_fi3) ;
		end

		// fb format instruction
		{4'b0001,{i_width-4{1'bx}}}:
		begin
			i_fb(opcode_fb, condition_fb, field_fb, buffer_fb) ;
		end

		default: $display ("Undefined instruction in decode") ;
	endcase
	end
endtask // end decode task


task i_ldif ;
	input [1:0] condition ;
	input [fieldp_width-1:0]field ;
        input [d_width-1:0] immediate ;

	begin
	end
endtask

task i_i8 ;
	input [i_width-1:0] opcode ;
	input [1:0] condition ;
        input [d_width-1:0] immediate ;

	begin
	end
endtask

task i_fi3 ;
	input [i_width-1:0] opcode ;
	input [1:0] condition ;
	input [fieldp_width-1:0] field ;
        input [2:0] immediate3 ;

	begin
	end
endtask

task i_fb ;
	input [i_width-1:0] opcode ;
	input [1:0] condition ;
	input [fieldp_width-1:0] field ;
        input [bufp_width-1:0] buffer ;

	begin
	end
endtask

always @(posedge clk)
begin
	pc = pc + 1 ;
	decode(instr) ;
end // end always


endmodule
