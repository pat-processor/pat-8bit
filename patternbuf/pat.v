/*
module program_counter(clk, reset, offset, bf, bb, pc_out) ;

parameter i_adr_width = 10 ;

input clk, reset, bf, bb ;
input [7:0] offset ;
output pc_out ;

reg [i_adr_width-1:0] pc ;

wire [i_adr_width-1:0] bf_pc ;
wire [i_adr_width-1:0] bb_pc ;
wire [i_adr_width-1:0] inc_pc ;

assign bf_pc = pc + offset ;
assign bb_pc = pc - offset ;
assign inc_pc = pc + 1 ;

always @(posedge clk)
begin
	if (reset) pc <= 0 ;
	else if (bf) pc <= bf_pc ;
	else if (bb) pc <= bb_pc ;
	else pc <= inc_pc ;
end
endmodule
*/
module shifter(a, b, left_rightn, y) ;

parameter d_width = 8 ;

input [d_width-1:0] a ;
input [2:0] b ;
input left_rightn ;

output y ;

wire [d_width-1:0] shl ;
wire [d_width-1:0] shr ;

assign shl = a << b ;
assign shr = a >> b ;
assign y = left_rightn ? shl : shr ;

endmodule

module subtractor(a, b, y) ;
parameter d_width = 8 ;
input [d_width-1:0] a ;
input [d_width-1:0] b ;
output [d_width-1:0] y ;

assign y = a - b ;

endmodule

module adder(a, b, y) ;
parameter d_width = 8 ;
input [d_width-1:0] a ;
input [d_width-1:0] b ;
output [d_width-1:0] y ;

assign y = a + b ;

endmodule

module negator(a, y) ;
parameter d_width = 8 ;
input [d_width-1:0] a ;
output [d_width-1:0] y ;

assign y = ~a ;

endmodule

module alu(a, b, y, op) ;

parameter d_width = 8 ;

input [d_width-1:0] a ;
input [d_width-1:0] b ;
input [2:0] op ;

output [d_width-1:0] y ;

wire [d_width-1:0] shift_out ;
wire [d_width-1:0] add_out ;
wire [d_width-1:0] sub_out ;
wire [d_width-1:0] neg_out ;

shifter theShifter(a, b[2:0], op[1], shift_out) ;
adder theAdder(a, b, add_out) ;
subtractor theSub(a, b, sub_out) ;
negator theNeg(a, neg_out) ;

assign y = (op[2] == 1'b1) ? shift_out : 
	   (op[1] == 1'b1) ? neg_out :
	   (op[0] == 1'b0) ? add_out :
           sub_out ;


endmodule

module pat(reset, pc, write_en, data_adr, data_out, bufp, fieldp, fieldwp, field_out, imem_in, data_in, field_in, clk) ;

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

input reset ;
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
reg [d_width-1:0] dmem [4] ; // TODO: Select this memory or external

reg [d_width-1:0] dmem_read[4] ;

// instruction type selection

wire i_t_i0 ;
wire i_t_i3 ;
wire i_t_i8 ;

// operation type selection
wire source_acc, source_dmem, source_field, source_imm, source_sp ;
wire dest_acc, dest_dmem, dest_field, dest_sp ;

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


wire [d_width-1:0] alu_a ;
wire [d_width-1:0] alu_b ;
wire [d_width-1:0] alu_y ;
wire [2:0] alu_op ; // FIXME: parameterise



// determine the type of operation
assign i_t_i8 = (opcode_i8 != `i3_opcode_prefix) ? 1'b1 : 1'b0 ;
assign i_t_i3 = (!i_t_i8) && (opcode_i3 != `i0_opcode_prefix) ? 1'b1 : 1'b0 ;
assign i_t_i0 = (!i_t_i8) && (!i_t_i3) ;

assign source_field = field_op ;

// instantiate two ALUs to speed up by preventing input MUX
alu accALU(acc_alu_a, acc_alu_b, acc_alu_y, alu_op) ;
alu fieldALU(field_alu_a, field_alu_b, field_alu_y, alu_op) ;

/*
assign alu_a = source_field ? field_in :
	       source_sp ? sp : acc ;
*/
assign acc_alu_a = acc ;
	  

assign acc_alu_b = source_dmem ? data_in : 
	       i_t_i8 ? immediate_i8 :
               {{5{1'b0}},immediate_i3} ;
	      // i_t_i0 ? {8{1'bx}} : {8{1'bx}} ; // FIXME: parameterise

assign field_alu_a = field_in ;
assign field_alu_b = acc_alu_b ;


assign alu_op = i_t_i8 ? opcode_i8[2:0] :  // FIXME: align with reality
		i_t_i3 ? opcode_i3[2:0] :
		i_t_i0 ? opcode_i0[2:0] : {3{1'bx}} ;

// should I put the immediates through the ALU too.
// TODO: SP, IN, OUT





wire [d_width-1:0] result ; // final result of the operation
wire [d_width-1:0] alu_result ; // result from the parallel ALUs

assign alu_result = field_op ? field_alu_y : acc_alu_y ;

assign result = (source_imm) ? immediate_i8 : alu_result ; // all non-immediate load ops go through the alu

wire op_bf, op_bb, op_call, op_ldi, op_ldm, op_stm, op_setsp, op_or ;
wire op_and, op_addm, op_subm, op_add, op_sub, op_ldba, op_stab ;
assign op_bf = 	(opcode_i8 == 4'b0000) && i_t_i8 ;
assign op_bb =	(opcode_i8 == 4'b0001) && i_t_i8 ;
assign op_call =(opcode_i8 == 4'b0010) && i_t_i8 ;
assign op_ldi = (opcode_i8 == 4'b0011) && i_t_i8 ;
assign op_ldm = (opcode_i8 == 4'b0100) && i_t_i8 ;
assign op_stm = (opcode_i8 == 4'b0101) && i_t_i8 ;
assign op_setsp=(opcode_i8 == 4'b0110) && i_t_i8 ;
assign op_or = 	(opcode_i8 == 4'b0111) && i_t_i8 ;
assign op_and = (opcode_i8 == 4'b1000) && i_t_i8 ;
assign op_addm =(opcode_i8 == 4'b1001) && i_t_i8 ;
assign op_subm =(opcode_i8 == 4'b1010) && i_t_i8 ;
assign op_add = (opcode_i8 == 4'b1011) && i_t_i8 ;
assign op_sub = (opcode_i8 == 4'b1100) && i_t_i8 ;


assign source_acc = op_or | op_and | op_addm | op_subm | op_add | op_sub ;
assign source_dmem = op_ldm | op_addm | op_subm ;
assign source_sp = 1'b0 ;
assign source_imm = ~(source_acc | source_dmem | source_sp) ;
// source_imm is none of above



// Program counter 

wire [i_adr_width-1:0] pc_offset ;
wire pc_bf, pc_bb ;

assign pc_offset = immediate_i8 ;

//program_counter thePC(clk, reset, pc_offset, op_bf, op_bb, pc) ;



/*
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
		//pc <= pc + 1 ;
	end
endtask

wire foo ; // FIXME: test

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

		// DEBUG FIXME - push to correct op format area
		4'b1110: op_ldba() ;
		4'b1111: op_stab() ;


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
	//	pc <= pc + offset ;
	end
endtask

task op_bb ;
	input [7:0] offset ;
//
	begin
	//	pc <= pc - offset ;
	end
endtask

task op_call ;
	input [7:0] offset ;
	begin
		call_stack[call_stack_pointer] <= pc ;
		call_stack_pointer <= call_stack_pointer + 1 ;
	//	pc <= pc + offset ;
	end
endtask


task op_return ; // 'return' is a reserved keyword
	begin
	//	pc <= call_stack[call_stack_pointer - 1] ;
		call_stack_pointer <= call_stack_pointer - 1 ;
	end
endtask


task op_ldi ;
	input [7:0] immediate ;
	begin
		if (field_op)
			field_out <= immediate ;
		else
			acc <= immediate ;
		incPC() ;
	end
endtask

task op_setsp ;
	input [7:0] immediate ;
	begin
		sp <= immediate ;
		incPC() ;
	end
endtask

task op_incsp ;
	input [2:0] inc ;
	begin
		sp <= sp + inc ;
		incPC() ;
	end
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
	begin
		if (field_op)
			field_out <= field_value | immediate ;
		else
			acc <= acc | immediate ;
		incPC() ;
	end
endtask

task op_and ;
	input [7:0] immediate ;
	begin
		if (field_op)
			field_out <= field_value & immediate ;
		else
			acc <= acc & immediate ;
		incPC() ;
	end
endtask

task op_add ;
	input [7:0] immediate ;
	begin
		if (field_op)
			field_out <= field_value + immediate ;
		else
			acc <= acc + immediate ;
		incPC() ;
	end
endtask

task op_sub ;
	input [7:0] immediate ;
	begin
		if (field_op)
			field_out <= field_value - immediate ;
		else
			acc <= acc - immediate ;
		incPC() ;
	end
endtask

task op_shl ;
	input [2:0] shift ;
	begin
		if (field_op)
			field_out <= field_value << shift ;
		else
			acc <= acc << shift ;
		incPC() ;
	end
endtask

task op_shr ;
	input [2:0] shift ;
	begin
		if (field_op)
			field_out <= field_value >> shift ;
		else
			acc <= acc >> shift ;
		incPC() ;
	end
endtask

task op_ashr ;
	input [2:0] shift ;
	begin
		if (field_op)
			field_out <= field_value >>> shift ;
		else
			acc <= acc >>> shift ;
		incPC() ;
	end
endtask

task op_not ;
	begin
		if (field_op)
			field_out <= ~field_value ;
		else
			acc <= ~acc ;
		incPC() ;
	end
endtask

task op_ldm ;
	input [7:0] immediate ;
	begin
		if (field_op)
			field_out <= dmem[immediate] ;
		else
			acc <= dmem[immediate] ;
		incPC() ;
	end
endtask 

task op_stm ;
	input [7:0] immediate ;
	begin
		if (field_op)
			dmem[immediate] <= field_value ;
		else
			dmem[immediate] <= acc ;
		incPC() ;
	end
endtask 


task op_addm ;
	input [7:0] immediate ;
	begin
		if (field_op)
			field_out <= field_value + dmem[immediate] ;
		else
			acc <= acc + dmem[immediate] ;
		incPC() ;
	end
endtask 

task op_subm ;
	input [7:0] immediate ;
	begin
		if (field_op)
			field_out <= field_value - dmem[immediate] ;
		else
			acc <= acc - dmem[immediate] ;
		incPC() ;
	end
endtask 


task op_stab ;
	begin
		field_out <= acc ;
	end
endtask

task op_ldba ;
	begin
		acc <= field_value ;
	end
endtask
*/


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
	begin
	//	doOp() ;
		// updatePC() ; // part of the ops
		// commitResults() ; // part of the ops
		pc <= pc + 1 ;
          	getField() ;
		updateFieldp() ;

		if (dest_acc) acc <= result ;
		else if (dest_field) field_out <= result ;
		else if (dest_dmem) data_out <= result ;



	end

always @(negedge clk)
	begin // run next statements in parallel
		//getField() ;
	//	updateFieldp() ;
		// getDmem() ; // if external data memory used
	end

endmodule
