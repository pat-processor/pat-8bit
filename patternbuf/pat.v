module pat(pc, write_en, data_adr, data_out, bufp, fieldp, fieldwp, field_out, imem_in, data_in, field_in, clk) ;

parameter i_adr_width = 10 ; // instruction address space size
parameter i_width = 15 ; // instruction width
parameter d_adr_width = 8 ; // data address space size
parameter d_width = 8 ; // data width
parameter call_stack_size = 8 ; // max call depth supported
parameter call_stack_pointer_size = 3 ; // bits for call stack pointer
parameter bufp_width = 3 ;
parameter fieldp_width = 5 ;
parameter buffer_width = 8 ;
parameter opcode_i8_width = 4 ; // width of opcode for i8 instruction
parameter opcode_i3_width = 4 ; // width of opcode for i3 instruction
parameter opcode_i0_width = 5 ; // width of opcode for i0 instruction

`define i3_opcode_prefix 4'b1111  // prefix string from i8 space
`define i0_opcode_prefix 4'b1111  // prefix string from i3 space

input [i_width-1:0] imem_in ;
input [d_width-1:0] data_in;
input [buffer_width-1:0] field_in ;
input clk ;

output [i_adr_width-1:0] pc ;
output write_en ;
output [d_adr_width-1:0] data_adr ;
output [d_width-1:0] data_out ;
output [bufp_width-1:0] bufp ;
output [fieldp_width-1:0] fieldp ;
output [fieldp_width-1:0] fieldwp ;
output [buffer_width-1:0] field_out ;

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
reg [buffer_width-1:0] field_out ;

reg [d_width-1:0] field_value ; // after latching field in
reg [d_width-1:0] dmem [256] ; // TODO: Select this memory or external


// instruction type selection
/*
wire i_t_i0 ;
wire i_t_i3 ;
wire i_t_i8 ;
*/

// instruction immediate values
wire [7:0] immediate_i8 ;
wire [2:0] immediate_i3 ;
wire [fieldp_width-1:0] fieldp_next ;
wire [i_width-1:0] instruction ;
wire [1:0] condition ;
wire [opcode_i8_width-1:0] opcode_i8 ;
wire [opcode_i3_width-1:0] opcode_i3 ;
wire [opcode_i0_width-1:0] opcode_i0 ;

wire field_op ; // 0 := ACC op ; 1 := field op

assign {fieldp_next, condition, field_op, opcode_i8, immediate_i8} = imem_in ;
//assign {fieldp_next, condition, field_op, opcode_i8, immediate_i8} = 20'b00001_11_1_1000_01010101 ;

assign opcode_i3 = imem_in[6:3] ; // TODO: parameterise
assign immediate_i3 = imem_in[2:0] ; 
assign opcode_i0 = imem_in[opcode_i0_width-1:0] ;


task doOp ;
	// check the opcode prefix to determine operation type.
	begin
		if (opcode_i8 != `i3_opcode_prefix) i_i8(opcode_i8, condition, immediate_i8) ;
		else if (opcode_i3 != `i0_opcode_prefix) i_i3(opcode_i3, condition, immediate_i3) ;
		else i_i0(opcode_i0, condition) ;
	end
endtask

task incPC ; // incrementPC if not a jump
	begin
		pc <= pc + 1 ;
	end
endtask



task i_i8 ;
	input [opcode_i8_width-1:0] opcode ;
	input [1:0] condition ;
        input [7:0] immediate ;
	casex(opcode) // case is evaluated in order

		// i8 format instruction
		4'b0000: op_bf(immediate) ;
		4'b0001: op_bb(immediate) ;
		4'b0010: op_call(immediate) ;
		4'b0011: op_ldi(immediate) ;
		4'b0100: op_ldm(immediate) ;
		4'b0101: op_stm(immediate) ;
		4'b0110: op_setsp(immediate) ;
		// 4'b0111:
		4'b1000: op_or(immediate) ;
		4'b1001: op_and(immediate) ;
		4'b1010: op_addm(immediate) ;
		4'b1011: op_subm(immediate) ;
		4'b1100: op_add(immediate) ;
		4'b1101: op_sub(immediate) ;
		// 4'b1110:


		default: $display ("Undefined i8 instruction in decode") ;
	endcase
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


task op_bf ;
	input [7:0] offset ;
	begin
		pc <= pc + offset ;
	end
endtask

task op_bb ;
	input [7:0] offset ;

	begin
		pc <= pc - offset ;
	end
endtask

task op_call ;
	input [7:0] offset ;
	begin
		call_stack[call_stack_pointer] <= pc ;
		call_stack_pointer <= call_stack_pointer + 1 ;
		pc <= pc + offset ;
	end
endtask


task op_return ; // 'return' is a reserved keyword
	begin
		pc <= call_stack[call_stack_pointer - 1] ;
		call_stack_pointer <= call_stack_pointer - 1 ;
	end
endtask


task op_ldi ;
	input [7:0] immediate ;
	fork
		if (field_op)
			field_out <= immediate ;
		else
			acc <= immediate ;
		incPC() ;
	join
endtask

task op_setsp ;
	input [7:0] immediate ;
	fork
		sp <= immediate ;
		incPC() ;
	join
endtask

task op_incsp ;
	input [2:0] inc ;
	fork
		sp <= sp + inc ;
		incPC() ;
	join
endtask

task op_decsp ;
	input [2:0] dec ;
	begin
		sp <= sp - dec ;
		incPC() ;
	end
endtask

task op_or ;
	input [7:0] immediate ;
	fork
		if (field_op)
			field_out <= field_value | immediate ;
		else
			acc <= acc | immediate ;
		incPC() ;
	join
endtask

task op_and ;
	input [7:0] immediate ;
	fork
		if (field_op)
			field_out <= field_value & immediate ;
		else
			acc <= acc & immediate ;
		incPC() ;
	join
endtask

task op_add ;
	input [7:0] immediate ;
	fork
		if (field_op)
			field_out <= field_value + immediate ;
		else
			acc <= acc + immediate ;
		incPC() ;
	join
endtask

task op_sub ;
	input [7:0] immediate ;
	fork
		if (field_op)
			field_out <= field_value - immediate ;
		else
			acc <= acc - immediate ;
		incPC() ;
	join
endtask

task op_shl ;
	input [2:0] shift ;
	fork
		if (field_op)
			field_out <= field_value << shift ;
		else
			acc <= acc << shift ;
		incPC() ;
	join
endtask

task op_shr ;
	input [2:0] shift ;
	fork
		if (field_op)
			field_out <= field_value >> shift ;
		else
			acc <= acc >> shift ;
		incPC() ;
	join
endtask

task op_ashr ;
	input [2:0] shift ;
	fork
		if (field_op)
			field_out <= field_value >>> shift ;
		else
			acc <= acc >>> shift ;
		incPC() ;
	join
endtask

task op_not ;
	fork
		if (field_op)
			field_out <= ~field_value ;
		else
			acc <= ~acc ;
		incPC() ;
	join
endtask

task op_ldm ;
	input [7:0] immediate ;
	fork
		if (field_op)
			field_out <= dmem[immediate] ;
		else
			acc <= dmem[immediate] ;
		incPC() ;
	join
endtask 

task op_stm ;
	input [7:0] immediate ;
	fork
		if (field_op)
			dmem[immediate] <= field_value ;
		else
			dmem[immediate] <= acc ;
		incPC() ;
	join
endtask 


task op_addm ;
	input [7:0] immediate ;
	fork
		if (field_op)
			field_out <= field_value + dmem[immediate] ;
		else
			acc <= acc + dmem[immediate] ;
		incPC() ;
	join
endtask 

task op_subm ;
	input [7:0] immediate ;
	fork
		if (field_op)
			field_out <= field_value - dmem[immediate] ;
		else
			acc <= acc - dmem[immediate] ;
		incPC() ;
	join
endtask 


// control tasks

task getField() ;
	begin
		field_value <= field_in ;
	end
endtask

task updateFieldp() ;
	begin
		fieldp <= fieldp_next ;
	end
endtask


always @(posedge clk)
	fork
		doOp() ;
		// updatePC() ; // part of the ops
		// commitResults() ; // part of the ops
	join

always @(negedge clk)
	fork // run next statements in parallel
		getField() ;
		updateFieldp() ;
		// getDmem() ; // if external data memory used
	join

endmodule
