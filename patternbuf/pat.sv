module pat(clk, reset, pc, bufp, fieldp, fieldwp, field_write_en, field_out, instruction_in, field_in, acc, inputs, outputs) ;

parameter i_adr_width = 10 ; // instruction address space size
parameter i_width = 20 ; // instruction width
parameter d_adr_width = 8 ; // data address space size
parameter d_width = 8 ; // data width
parameter call_stack_size = 8 ; // max call depth supported
parameter call_stack_pointer_size = 3 ; // bits for call stack pointer
parameter bufp_width = 3 ;
parameter fieldp_width = 5 ;
parameter buffer_width = 8 ;
parameter opcode_i8_width = 4 ; // width of opcode for i8 instruction
parameter opcode_i3_width = 4 ; // width of opcode for i3 instruction
parameter opcode_i0_width = 4 ; // width of opcode for i0 instruction
parameter field_latency = 4 ; // cycle count between field read and write

`define i3_opcode_prefix 4'b1111  // prefix string from i8 space
`define i0_opcode_prefix 4'b1111  // prefix string from i3 space

input clk ;
input reset ;
input [i_width-1:0] instruction_in ;
input [buffer_width-1:0] field_in ;
input [d_width-1:0] inputs ;

output [i_adr_width-1:0] pc ;
output [bufp_width-1:0] bufp ;
output [fieldp_width-1:0] fieldp ;
output [fieldp_width-1:0] fieldwp ;
output field_write_en ;
output [buffer_width-1:0] field_out ;

output [d_width-1:0] acc ; //FIXME: remove --- debug
output [d_width-1:0] outputs ;
reg [i_width-1:0] instruction_1 ;
reg [i_width-1:0] instruction_2 ; // duplicate for FO optimisation
reg [i_width-1:0] instruction_3 ; // duplicate for FO optimisation
reg [i_width-1:0] instruction_4 ; // duplicate for FO optimisation

reg [d_width-1:0] acc ; // the main accumulator
reg [d_adr_width-1:0] sp ; // stack pointer
reg z ; // zero flag
reg n ; // neg flag


reg [i_adr_width-1:0] call_stack [call_stack_size] ;
reg [call_stack_pointer_size-1:0] call_stack_pointer ;

reg [d_width-1:0] data_out ;
reg [bufp_width-1:0] bufp ;
reg [fieldp_width-1:0] fieldp ;
reg [fieldp_width-1:0] fieldwp ;
reg field_write_en ;
reg [buffer_width-1:0] field_out ;
reg [fieldp_width-1:0] fieldp_history [field_latency] ;

reg [d_width-1:0] field_value ; // after latching field in
reg [d_width-1:0] outputs ;


// =========================================================
// ============== PIPELINE STAGE 1 =========================
// =========================================================




// **** DECODE ******

// instruction type selection
wire i_t_i0 ;
wire i_t_i3 ;
wire i_t_i8 ;


// instruction immediate values
wire [7:0] immediate_i8 ;
wire [2:0] immediate_i3 ;
wire [fieldp_width-1:0] fieldp_next ;
wire [1:0] condition ;
wire [opcode_i8_width-1:0] opcode_i8 ;
wire [opcode_i3_width-1:0] opcode_i3 ;
wire [opcode_i0_width-1:0] opcode_i0 ;

wire field_op ; // 0 := ACC op ; 1 := field op

assign {fieldp_next, condition, field_op, opcode_i8, immediate_i8} = instruction_1 ;

assign opcode_i3 = instruction_3[7:4] ; // TODO: parameterise. Must not overlap with i0 opcode space
assign opcode_i0 = instruction_3[3:0] ;
assign immediate_i3 = instruction_1[2:0] ; 


// determine the type of operation
//assign i_t_i8 = (opcode_i8[3:0] != `i3_opcode_prefix) ? 1'b1 : 1'b0 ;
//assign i_t_i3 = (!i_t_i8) && (opcode_i3[3:0] != `i0_opcode_prefix) ? 1'b1 : 1'b0 ;
//assign i_t_i0 = (!i_t_i8) && (!i_t_i3) ;

assign i_t_i8 = (opcode_i8 != 4'b1111) ;
assign i_t_i3 = ((opcode_i8 == 4'b1111) && (opcode_i3 != 4'b1111)) ;
assign i_t_i0 = (!i_t_i8 && !i_t_i3) ;

// i8 operations
wire op_bf, op_bb, op_call, op_ldi, op_ldm, op_stam, op_setsp, op_or ;
wire op_and, op_addm, op_subm, op_add, op_sub, op_orm, op_andm ;
assign op_or =	(opcode_i8 == 4'b0000) && i_t_i8 ;
assign op_and =(opcode_i8 == 4'b0001) && i_t_i8 ;
assign op_addm =(opcode_i8 == 4'b0010) && i_t_i8 ;
assign op_subm = (opcode_i8 == 4'b0011) && i_t_i8 ;
assign op_add = (opcode_i8 == 4'b0100) && i_t_i8 ;
assign op_sub = (opcode_i8 == 4'b0101) && i_t_i8 ;
assign op_ldi =(opcode_i8 == 4'b0110) && i_t_i8 ;
assign op_ldm =	(opcode_i8 == 4'b0111) && i_t_i8 ;
assign op_bf = (opcode_i8 == 4'b1000) && i_t_i8 ;
assign op_bb =(opcode_i8 == 4'b1001) && i_t_i8 ;
assign op_call =(opcode_i8 == 4'b1010) && i_t_i8 ;
assign op_stam = (opcode_i8 == 4'b1011) && i_t_i8 ;
assign op_setsp = (opcode_i8 == 4'b1100) && i_t_i8 ;
assign op_orm = (opcode_i8 == 4'b1101) && i_t_i8 ;
assign op_andm = (opcode_i8 == 4'b1110) && i_t_i8 ;
// 4'b1111 is i3 prefix


// i3 operations
wire op_in, op_shl, op_shr, op_shlo, op_asr, op_out, op_setb ;
wire op_incsp, op_decsp ;

assign op_shl = (opcode_i3 == 4'b0000) && i_t_i3 ;
assign op_shlo =(opcode_i3 == 4'b0001) && i_t_i3 ;
assign op_shr =(opcode_i3 == 4'b0010) && i_t_i3 ;
assign op_asr = (opcode_i3 == 4'b0011) && i_t_i3 ;
assign op_in = (opcode_i3 == 4'b0101) && i_t_i3 ;
//
//
assign op_out = (opcode_i3 == 4'b1000) && i_t_i3 ;
assign op_setb =(opcode_i3 == 4'b1001) && i_t_i3 ;
//
//
assign op_incsp = (opcode_i3 == 4'b1101) && i_t_i3 ;
assign op_decsp = (opcode_i3 == 4'b1110) && i_t_i3 ;
// 4'b1111 is i0 prefix

// i0 operations
wire op_return, op_not, op_nop, op_ldba, op_stab, op_lda, op_ldsp, op_stsp ;

assign op_not = (opcode_i0 == 4'b0000) && i_t_i0 ;
assign op_ldba = (opcode_i0 == 4'b0001) && i_t_i0 ;
//assign op_lda = (opcode_i0 == 4'b0010) && i_t_i0 ;
assign op_return = (opcode_i0 == 4'b0011) && i_t_i0 ;
assign op_nop = (opcode_i0 == 4'b1111) && i_t_i0 ;
assign op_stsp = (opcode_i0 == 4'b1110) && i_t_i0 ;
assign op_stab = (opcode_i0 == 4'b1000) && i_t_i0 ;
assign op_ldsp = (opcode_i0 == 4'b1010) && i_t_i0 ;



// operation type selection
wire source_dmem, source_field, source_imm, source_sp, source_in ;
wire dest_acc, dest_dmem, dest_field, dest_sp, dest_pc, dest_reg ;

assign source_field = field_op ;
assign source_dmem = op_ldsp | op_ldm | op_addm | op_subm | op_orm | op_andm ; // TODO: | op_lda if re-added
assign source_sp = op_incsp | op_decsp ;
assign source_imm = op_ldi | op_setsp | op_setb ;
assign source_in = op_in ;

//assign dest_acc = (!field_op) && (i_t_i8 && opcode_i8[3] == 0) | op_orm | op_andm | (i_t_i3 && opcode_i3[3] == 0) | (i_t_i0 && (op_not | op_ldba | op_lda)) ;

// Which ops are committed to a register (ACC or Field_Out)
assign dest_reg = ( op_or | op_and | op_addm | op_subm | op_add | op_sub
                                  | op_lda | op_ldm | op_shl | op_shr | op_asr | op_shlo
				  | op_ldsp | op_in | op_not | op_ldba | op_lda ) ;
assign dest_acc = (!field_op && dest_reg) ;
assign dest_field = (field_op && dest_reg) ; 
assign dest_dmem = op_stam | op_stsp ;
assign dest_sp = op_setsp | op_incsp | op_decsp ;
assign dest_pc = op_bf | op_bb | op_call | op_return ;


// register for next stage of the pipeline
reg [d_width-1:0] immediate_regd ;
reg [d_width-1:0] immediate_regd_2 ;
reg [1:0] condition_regd ;
reg [d_width-1:0] alu_b_regd ; // pre-MUXd alu inputs
reg [d_width-1:0] alu_b_regd_2 ; // pre-MUXd alu inputs

wire [d_width-1:0] immediate_i_all ;
assign immediate_i_all = (i_t_i8) ? immediate_i8 : {{5{1'b0}}, immediate_i3} ;

wire [d_width-1:0] data_in ;
task reg_instr ;
	begin
		immediate_regd <= immediate_i_all ; // Duplicated to aid fan-out. DC will merge if more optimal
		immediate_regd_2 <= immediate_i_all ; 
		condition_regd <= condition ;
		alu_b_regd <= (source_dmem) ? data_in : immediate_i_all ;
		alu_b_regd_2 <= (source_dmem) ? data_in : immediate_i_all ;
	end
endtask

reg op_bf_regd, op_bb_regd, op_call_regd, op_ldi_regd, op_ldm_regd, op_stam_regd, op_setsp_regd, op_or_regd ;
reg op_and_regd, op_sub_subm_regd, op_add_addm_regd, op_sub_subm_regd_2, op_add_addm_regd_2, op_orm_regd, op_andm_regd ;
reg op_in_regd, op_shl_regd, op_shr_regd, op_shlo_regd, op_asr_regd, op_out_regd, op_setb_regd ;
reg op_incsp_regd, op_decsp_regd ;
reg op_return_regd, op_not_regd, op_nop_regd, op_ldba_regd, op_stab_regd, op_lda_regd, op_ldsp_regd, op_stsp_regd ;

task reg_ops ;
	begin
		op_bf_regd <= op_bf ;
		op_bb_regd <= op_bb ;
		op_call_regd <= op_call ;
		op_ldi_regd <= op_ldi ;
		op_ldm_regd <= op_ldm ;
		op_stam_regd <= op_stam ;
		op_setsp_regd <= op_setsp ;
		op_or_regd <= op_or ;
		op_and_regd <= op_and ;
		op_add_addm_regd <= op_add | op_addm ;
		op_add_addm_regd_2 <= op_add | op_addm ;
		op_sub_subm_regd <= op_sub | op_subm ;
		op_sub_subm_regd_2 <= op_sub | op_subm ;
		op_orm_regd <= op_orm ;
		op_andm_regd <= op_andm ;
		op_in_regd <= op_in ;
		op_shl_regd <= op_shl ;
		op_shr_regd <= op_shr ;
		op_shlo_regd <= op_shlo ;
		op_asr_regd <= op_asr ;
		op_out_regd <= op_out ;
		op_setb_regd <= op_setb ;
		op_incsp_regd <= op_incsp ;
		op_decsp_regd <= op_decsp ;
		op_return_regd <= op_return ;
		op_not_regd <= op_not ;
		op_nop_regd <= op_nop ;
		op_ldba_regd <= op_ldba ;
		op_stab_regd <= op_stab ;
		op_lda_regd <= op_lda ;
		op_ldsp_regd <= op_ldsp ;
		op_stsp_regd <= op_stsp ;
	end
endtask


reg source_field_regd ;
reg source_dmem_regd  ;
reg source_sp_regd  ;
reg source_imm_regd ;
reg source_in_regd ;
reg dest_acc_regd  ;
reg dest_field_regd ;
reg dest_dmem_regd ;
reg dest_sp_regd ;

task reg_srcdest ;
	begin
		source_field_regd <= source_field ;
		source_dmem_regd <= source_dmem ;
		source_sp_regd <= source_sp ;
		source_imm_regd <= source_imm ;
		source_in_regd <= source_in ;
		dest_acc_regd <= dest_acc ;
		dest_field_regd <= dest_field ;
		dest_dmem_regd <= dest_dmem ;
		dest_sp_regd <= dest_sp ;
	end
endtask


// **** Data memory ****
wire [d_adr_width-1:0] data_read_adr ;
reg [d_adr_width-1:0] data_write_adr ; 
reg data_write ;
reg [d_width-1:0] data_regd ; 

assign data_read_adr = instruction_4[7:0] ; // immediate_i8 ;  
// TODO: Consider role of op_lda
//assign data_read_adr = (op_lda) ? acc : (op_ldsp) ? sp : immediate_i8 ;

data_mem dmem(clk, data_read_adr, data_write_adr, data_write, data_out, data_in) ;

// * End data memory * 


// **** Program counter ****

wire [d_width-1:0] pc_immediate ;
wire [i_adr_width-1:0] return_address ;

assign pc_immediate = instruction_2[7:0] ; // immediate_i8 ;
assign return_address = (op_return) ? call_stack[call_stack_pointer] : immediate_i8 ;

program_counter thePC(clk, reset, pc, pc_immediate, op_bf, op_bb, op_return | op_call , return_address) ; 

// * End program counter *

// =====================================================================
// ================== PIPELINE STAGE 2: ALU and commit  ================
// =====================================================================

// instantiate two ALUs to speed up by preventing input MUX
wire [d_width-1:0] acc_alu_a ;
wire [d_width-1:0] acc_alu_b ;
wire [d_width-1:0] acc_alu_y ;
wire [d_width-1:0] field_alu_a ;
wire [d_width-1:0] field_alu_b ;
wire [d_width-1:0] field_alu_y ;

assign acc_alu_a = acc ;
assign acc_alu_b = alu_b_regd ;

assign field_alu_a = field_in ;
assign field_alu_b = alu_b_regd_2 ;

	
wire [d_width-1:0] acc_result ; 
wire [d_width-1:0] field_result ; 

assign acc_result = (source_imm_regd) ? alu_b_regd : (source_in_regd) ? inputs : acc_alu_y ;
assign field_result = (source_imm_regd) ? alu_b_regd_2 : (source_in_regd) ? inputs : field_alu_y ;


alu accALU(acc_alu_a, acc_alu_b, acc_alu_y, op_or_regd, op_and_regd, op_not_regd, op_add_addm_regd, op_sub_subm_regd, op_shl_regd, op_shlo_regd, op_shr_regd, op_asr_regd) ;
alu fieldALU(field_alu_a, field_alu_b, field_alu_y, op_or_regd, op_and_regd, op_not_regd, op_add_addm_regd_2, op_sub_subm_regd_2, op_shl_regd, op_shlo_regd, op_shr_regd, op_asr_regd) ;


// END ALUS




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

task updateFieldwp() ;
	begin
		integer i ;
		fieldp_history[0] <= fieldp ;
		fieldwp <= fieldp_history[field_latency-1] ;

		for (i = 1 ; i < (field_latency) ; i++)
		begin
			fieldp_history[i] <= fieldp_history[i-1] ; 
		end
	end
endtask

task getData() ;
	begin
		data_regd <= data_in ;
	end
endtask

task updateFlags() ;
	begin
		z <= (acc == 0) ;
		n <= (acc[d_width-1] == 1) ;
	end
endtask

function checkCondition ;
	input [1:0] cond ;
	input z ;
	input n ; 
	begin
	checkCondition = (cond == 2'b11) ? 1'b1 : // always
			(cond == 2'b01) ? n : // negative
			(cond == 2'b00) ? z : // zero
					1'b1 ; // default
	end
endfunction

always @(posedge clk)
	begin
		instruction_1 <= instruction_in ;
		instruction_2 <= instruction_in ;
		instruction_3 <= instruction_in ;
		instruction_4 <= instruction_in ;
		//dmem_in <= immediate_i8 ; // TODO: Restore latching
		reg_instr() ;
		reg_ops() ;
		reg_srcdest() ;
          	getField() ;
		updateFieldp() ;
		updateFieldwp() ;
		getData() ;
		updateFlags() ;


	if (checkCondition(condition_regd, z, n)) //TODO: Restore conditionality
	begin

		if (dest_acc_regd) begin
			 acc <= acc_result ;
		//	 z <= (acc_result == 0) ; // z and n take extra tim0
		//	 in ALU pipeline
			// n <= (acc_result < 0) ;your_library.db
		end

		if (dest_field_regd) begin
			field_out <= field_result ;
			field_write_en <= 1'b1 ;
		end
		else field_write_en <= 1'b0 ;
		

		if (dest_dmem_regd) begin 
		data_out <= (source_field_regd) ? field_value : acc ;
		data_write <= 1'b1 ;
		//data_write_adr <= (op_stsp) ? sp : immediate_i8 ;
		data_write_adr <= immediate_regd_2 ; //TODO: sp removed. Re-add if fast enough
		end
		else data_write <= 1'b0 ;


		if (op_call_regd)
		begin
			// FIXME: I think this arrangement gives -1 size to call
			// TODO: ensure that this stores the
			// next-to-currently-active instruction
			call_stack[call_stack_pointer+1] <= pc ;
			call_stack_pointer <= call_stack_pointer + 1 ; 
		end

		if (op_return_regd)
		begin
			call_stack_pointer <= call_stack_pointer - 1 ;
		end

		if (op_setsp_regd)
		begin
			sp <= immediate_regd ;
		end
		
		if (op_incsp_regd)
		begin
			sp <= sp + immediate_regd[2:0] ;	
		end

		if (op_decsp_regd)
		begin
			sp <= sp - immediate_regd[2:0] ;
		end

		if (op_out_regd)
		begin
			//outputs[immediate_regd] <= acc ; TODO: can I have more outputs like this?
			outputs <= acc ; 
		end

		if (op_setb_regd)
		begin
			bufp <= immediate_regd[2:0] ;
		end

	end

	end



endmodule


module program_counter(clk, reset, pc, immediate_i8, op_bf, op_bb, op_return, return_adr) ;
parameter i_adr_width = 10 ;
input clk, reset ;
input [i_adr_width-1:0] return_adr ;
input [7:0] immediate_i8 ;
input op_bf, op_bb, op_return ;

output [i_adr_width-1:0] pc ;
reg [i_adr_width-1:0] pc ; // program counter

wire [i_adr_width-1:0] pcInc ;
wire [i_adr_width-1:0] pcAdd ;
wire [i_adr_width-1:0] pcSub ;

pc_inc pcIncr(pc, pcInc) ;
pc_add pcAddr(pc, immediate_i8, pcAdd) ;
pc_sub pcSubr(pc, immediate_i8, pcSub) ;

always @(posedge clk)
	begin
		if (reset) pc <= 0 ;
		else 
		begin
		//	if (op_call) pc <= immediate_i8 ; // FIXME add call back
		//	if (op_return) pc <= return_adr ; // FIXME add return back
			if (op_bf) pc <= pcAdd ;
			else if (op_bb) pc <= pcSub ;
			else pc <= pcInc ;
		end
	end


endmodule



module pc_inc(pc, pc_next) ;

parameter i_adr_width = 10 ;
input [i_adr_width-1:0] pc ;
output [i_adr_width-1:0] pc_next ;

assign pc_next = pc + 1 ;
endmodule

module pc_add(pc, offset, pc_next) ;
parameter i_adr_width = 10 ;
parameter d_width = 8 ;
input [i_adr_width-1:0] pc ;
input signed [d_width-1:0] offset ;
output [i_adr_width-1:0] pc_next ;

assign pc_next = pc + offset ;
endmodule

module pc_sub(pc, offset, pc_next) ;
parameter i_adr_width = 10 ;
parameter d_width = 8 ;
input [i_adr_width-1:0] pc ;
input [d_width-1:0] offset ;
output [i_adr_width-1:0] pc_next ;

assign pc_next = pc - offset ;
endmodule


module shifter(a, b, y, op_shl, op_shlo, op_shr, op_asr) ;

parameter d_width = 8 ;

input [d_width-1:0] a ;
input [2:0] b ;
input op_shl, op_shlo, op_shr, op_asr ;

output [d_width-1:0] y ;

wire [d_width-1:0] shl ;
wire [d_width-1:0] shlo ;
wire [d_width-1:0] shr ;
wire [d_width-1:0] asr ;

assign shl = a << b ;
assign shr = a >> b ;
assign asr = a >>> b ;

assign shlo =
	(b == 0) ? a :
	(b == 1) ? {a << 1, {1{1'b1}}} :
	(b == 2) ? {a << 2, {2{1'b1}}} :
	(b == 3) ? {a << 3, {3{1'b1}}} :
	(b == 4) ? {a << 4, {4{1'b1}}} :
	(b == 5) ? {a << 5, {5{1'b1}}} :
	(b == 6) ? {a << 6, {6{1'b1}}} :
	{a << 7, {7{1'b1}}} ; // b == 7 case


assign y = op_shl ? shl : 
	   op_shr ? shr :
	   op_shlo ? shlo :
		asr ;

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

module orer(a, b, y) ;
parameter d_width = 8 ;
input [d_width-1:0] a ;
input [d_width-1:0] b ;
output [d_width-1:0] y ;

assign y = a | b ;
endmodule

module ander(a, b, y) ;
parameter d_width = 8 ;
input [d_width-1:0] a ;
input [d_width-1:0] b ;
output [d_width-1:0] y ;

assign y = a & b ;
endmodule

module negator(a, y) ;
parameter d_width = 8 ;
input [d_width-1:0] a ;
output [d_width-1:0] y ;

assign y = ~a ;

endmodule

module alu(a, b, y, op_or, op_and, op_not, op_add, op_sub, op_shl, op_shlo, op_shr, op_asr) ;

parameter d_width = 8 ;

input [d_width-1:0] a ;
input [d_width-1:0] b ;
input op_or, op_and, op_not ;
input op_add, op_sub;
input op_shl, op_shlo, op_shr, op_asr ;

output [d_width-1:0] y ;

wire [d_width-1:0] shift_out ;
wire [d_width-1:0] add_out ;
wire [d_width-1:0] sub_out ;
wire [d_width-1:0] neg_out ;
wire [d_width-1:0] and_out ;
wire [d_width-1:0] or_out ;

shifter theShifter(a, b[2:0], shift_out, op_shl, op_shlo, op_shr, op_asr) ;
adder theAdder(a, b, add_out) ;
subtractor theSub(a, b, sub_out) ;
orer theOR(a, b, or_out) ;
ander theAND(a, b, and_out) ;
negator theNeg(a, neg_out) ;

// enhancement from Introduction to Logic Synthesis Using Verilog HDL
// By Robert Bryan Reese, Mitchell Aaron Thornton
// seems to be quicker than my solution //TODO: see if still true
wire op_addsub = op_add | op_sub ; // TODO: op_addsub could be pushed to previous pipeline cycle to speed
wire [d_width-1:0] addsubi ;
wire [d_width-1:0] addsubout ;
assign addsubi = op_sub ? ~b : b ;
assign addsubout = a + addsubi + {{d_width-1{1'b0}}, op_sub} ;

assign y = op_or ? or_out :
	   op_and ? and_out :
	   op_not ? neg_out :
	   op_add ? add_out :
	   op_sub ? sub_out : 
//	   op_addsub ? addsubout :
	   shift_out ; // any of the three shifts


/*
assign y = op_add ? add_out :
	    sub_out ;
*/
endmodule

module data_mem(clk, data_read_adr, data_write_adr, data_write, data_in, data_out) ;
parameter d_adr_width = 8 ; // data address space size
parameter d_width = 8 ; // data width
parameter dmemsize = 32 ;

input clk ;
input [d_adr_width-1:0] data_read_adr ;
input [d_adr_width-1:0] data_write_adr ;
input [d_width-1:0] data_in ;
input data_write ;

output [d_width-1:0] data_out ;

reg [d_width-1:0] dmem [dmemsize] ;
wire [d_width-1:0] read_bus [dmemsize] ;

genvar i,j ;


assign data_out = dmem[data_read_adr] ;
always @(posedge clk) begin
	if (data_write)
		dmem[data_write_adr] <= data_in ;
	end

/*
// read decoder 

for (i = 0 ; i < dmemsize ; i++)
begin
	assign read_bus[i] = (data_read_adr == i) ? dmem[i] : {d_width{1'b0}} ;
end

wire [dmemsize-1:0] read_bus_transformed [d_width] ;

for (i = 0 ; i < d_width ; i++)
begin
	for (j = 0 ; j < dmemsize ; j++)
	begin
		assign read_bus_transformed[i][j] = read_bus[j][i] ;
	end
	assign data_out[i] = | read_bus_transformed[i] ;
end
*/

/*
// write
always @(data_write or data_write_adr or data_in)
begin
	if (data_write) begin
	dmem[data_write_adr] <= data_in ;
	end
end
*/
/*
wire write_enable [dmemsize] ;
 write decoder
for (i = 0 ; i < dmemsize ; i++)
begin
	assign write_enable[i] = (data_write && data_write_adr == i)  ;
end


for (i = 0 ; i < dmemsize ; i++)
begin
always @(posedge clk)
	if (write_enable[i]) dmem[i] <= data_in ;
end
*/




endmodule

// Level sensitive write signal; not registered
module inst_mem (imem_read_adr, imem_write_adr, imem_write, imem_in, imem_out) ;

parameter i_buffer_size = 2 ;
parameter i_mem_size = 1024 ;
parameter i_mem_lines =  512 ; //imem_size / i_buffer_size ;
parameter i_adr_width = 10 ; // instruction address space size
parameter i_width = 20 ; // instruction width

input [i_adr_width-1:0] imem_read_adr ;
input [i_adr_width-1:0] imem_write_adr ;
input imem_write ;
input [(i_buffer_size*i_width)-1:0] imem_in ;

output [(i_buffer_size*i_width)-1:0] imem_out ;

reg [(i_buffer_size*i_width)-1:0] imem [i_mem_lines] ;

assign imem_out = imem[imem_read_adr] ;

always @(imem_write or imem_write_adr or imem_in)
begin
	if (imem_write) imem[imem_write_adr] <= imem_in ;
end
/*
genvar i,j ;
read decoder 
tri [i_adr_width-1:0] imem_out ;
for (i = 0 ; i < i_mem_size ; i++)
begin
	assign imem_out = (imem_read_adr == i) ? imem[i] : {i_width{1'bz}} ;
end
*/
/*
wire [i_mems_size-1:0] read_bus_transformed [i_width] ;

for (i = 0 ; i < i_width ; i++)
begin
	for (j = 0 ; j < i_mem_size ; j++)
	begin
		assign read_bus_transformed[i][j] = read_bus[j][i] ;
	end
	assign imem_out[i] = | read_bus_transformed[i] ;
end
*/


endmodule

module instruction_buffer(clk, reset, instruction_address, instruction_out, imem_write_adr, imem_write, imem_in) ;

parameter i_buffer_size = 2 ;
parameter i_mem_adr_start_bit = 1 ; // first address bit of significance for imem
parameter i_adr_width = 10 ;
parameter i_width = 20 ; // instruction width


input clk, reset ;
input [i_adr_width-1:0] instruction_address ;
input [i_adr_width-1:0] imem_write_adr ;
input imem_write ;
input [(i_buffer_size*i_width)-1:0] imem_in ;

output [i_width-1:0] instruction_out ;
reg [i_width-1:0] instruction_out ;


reg [i_adr_width-1:0] imem_read_adr ;
wire [(i_buffer_size*i_width)-1:0] imem_out ;

reg [i_width-1:0] i_buffer [i_buffer_size] ;
reg inst_index ;

inst_mem iMem(imem_read_adr, imem_write_adr, imem_write, imem_in, imem_out) ;

/* Mechanism
/  If the PC shows an even number, go and fetch that instruction line from memory.
/  Then, load both into the instruction buffer
/  and MUX the next instruction out of this.
*/
always @(posedge clk)
begin
	if (reset) inst_index <= 0 ;
	else begin
		if (inst_index == 0) begin
			i_buffer[0] <= imem_out[19:0] ;
			i_buffer[1] <= imem_out[39:20] ;
			imem_read_adr <= instruction_address[i_adr_width-1:i_mem_adr_start_bit] ; // TODO: check this can't just come from the pc
		end
	instruction_out <= i_buffer[instruction_address[0]] ;
	inst_index <= ~inst_index ;
	end
end
	
	
endmodule
