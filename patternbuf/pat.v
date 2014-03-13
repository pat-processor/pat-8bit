module pat(pc, write_en, data_adr, data_out, bufp, fieldp, fieldwp, field_byte_out, instr, data_in, field_byte_in, clk) ;

parameter i_adr_width = 10 ; // instruction address space size
parameter i_width = 16 ; // instruction width
parameter d_adr_width = 8 ; // data address space size
parameter d_width = 8 ; // data width
parameter call_stack_size = 8 ; // max call depth supported
parameter call_stack_pointer_size = 3 ; // bits for call stack pointer
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

reg [d_width-1:0] acc ; // the main accumulator
reg [d_adr_width-1:0] sp ; // stack pointer
reg [i_adr_width-1:0] pc ; // program counter
reg [i_adr_width-1:0] call_stack [call_stack_size] ;
reg [call_stack_pointer_size-1:0] call_stack_pointer ;

reg write_en ;
reg [d_adr_width-1:0] data_adr ;
reg [d_width-1:0] data_out ;
reg [bufp_width-1:0] bufp ;
reg [fieldp_width-1:0] fieldp ;
reg [fieldp_width-1:0] fieldwp ;
reg [buffer_width-1:0] field_byte_out ;



/*
// instruction type selection
wire i_t_fb ;
wire i_t_fi3 ;
wire i_t_i8 ;
wire i_t_ldif ;
*/

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
assign {condition_i8, opcode_i8, immediate_i8} = instr ;

wire [(i_width-(fieldp_width+2+3+1)):0] opcode_fi3 ;
wire [1:0] condition_fi3 ;
wire [fieldp_width-1:0] field_fi3 ;
wire [2:0] immediate3_fi3 ;
assign {condition_fi3, opcode_fi3, field_fi3, immediate3_fi3} = instr ;

// add opcode i3 and opcode i0

task decode ;
	input [i_width-1:0] instr ;
	// outputs
	
	begin
	casex(instr)
		// LDIF
		{3'bxx1,{i_width-3{1'bx}}}: 
		begin
		        // call ldif instruction directly	
			i_ldif(condition_ldif, field_ldif, immediate_ldif) ;
		end

		// i8 format instruction
		{4'bxx01,{i_width-4{1'bx}}}:
		begin
			i_i8(opcode_i8, condition_i8, immediate_i8) ;
		end

		// fi3 format instruction
		{5'bxx001,{i_width-5{1'bx}}}:
		begin
			i_fi3(opcode_fi3, condition_fi3, field_fi3, immediate3_fi3) ;
		end

		// i3 format instruction
		{8'bxx000001,{i_width-8{1'bx}}}:
		begin
			i_i3(opcode_i3, condition_i3, immediate_i3) ;
		end

		{10'bxx00000001,{i_width-10{1'bx}}}:
		begin
			i_i0(opcode_i0, condition_i0) ;
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

task i_i3 ;
	input [i_width-1:0] opcode ;
	input [1:0] condition ;
	input [2:0] immediate ;


	begin
	end
endtask

task i_i0 ;
	input [i_width-1:0] opcode ;
	input [1:0] condition ;

	begin
	end
endtask


task bf
	input [7:0] offset ;

	begin
		pc <= pc + offset ;
	end
endtask

task bb
	input [7:0] offset ;

	begin
		pc <= pc - offset ;
	end
endtask

task call
	input [7:0] offset ;
	begin
		call_stack[call_stack_pointer] <= pc ;
		call_stack_pointer <= call_stack_pointer + 1 ;
		pc <= pc + offset ;
	end
endtask

task return
	begin
		pc <= call_stack[call_stack_pointer - 1] ;
		call_stack_pointer <= call_stack_pointer - 1 ;
	end
endtask

task ldi
	input [7:0] immediate ;
	begin
		acc <= immediate ;
	end
endtask

task setsp
	input [7:0] immediate ;
	begin
		sp <= immediate ;
	end
endtask

task incsp
	input [2:0] inc ;
	begin
		sp <= sp + inc ;
	end
endtask

task decsp
	input [2:0] dec ;
	begin
		sp <= sp - dec ;
	end
endtask

task ora
	input [7:0] immediate ;
	begin
		acc <= acc | immediate ;
	end
endtask

task anda
	input [7:0] immediate ;
	begin
		acc <= acc & immediate ;
	end
endtask

task adda
	input [7:0] immediate ;
	begin
		acc <= acc + immediate ;
	end
endtask

task suba
	input [7:0] immediate ;
	begin
		acc <= acc - immediate ;
	end
endtask

task shla
	input [2:0] shift ;
	begin
		acc <= acc << shift ;
	end
endtask

task shra
	input [2:0] shift ;
	begin
		acc <= acc >> shift ;
	end
endtask

task ashra
	input [2:0] shift ;
	begin
		acc <= acc >>> shift ;
	end
endtask

task nota
	begin
		acc <= ~acc ;
	end
endtask


task ldm
	input [7:0] address ;
	begin
//		acc <= 
		// how to access memory? From the immediate??


always @(posedge clk)
	fork // run next statements in parallel
		// pc needs updating in each instruction
		pc <= pc + 1 ;
		decode(instr) ;
	join


endmodule
