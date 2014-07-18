`define INSTR_NOP 20'h06ff5
module pat(clk, reset, pc, jump, bufp, fieldp, fieldwp, field_write_en_low, field_write_en_high, field_out, instruction_in, field_in_low, field_in_high, inputs, outputs) ;

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
input [buffer_width-1:0] field_in_low ;
input [buffer_width-1:0] field_in_high ;
input [d_width-1:0] inputs ;

output [i_adr_width-1:0] pc ;
output jump ;
output [bufp_width-1:0] bufp ;
output [fieldp_width-1:0] fieldp ;
output [fieldp_width-1:0] fieldwp ;
output field_write_en_low ;
output field_write_en_high ;
output [buffer_width-1:0] field_out ;

output [d_width-1:0] outputs ;
reg [i_width-1:0] instruction_1 ;
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
reg field_write_en_low ;
reg field_write_en_high ;
reg [buffer_width-1:0] field_out ;
reg [fieldp_width-1:0] fieldp_history [field_latency] ;
reg low_high_buffer ; // '0' means use low-side buffer; '1' means use high-side

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
wire op_bf, op_bb, op_call, op_ldi, op_ldm, op_stm, op_setsp, op_or ;
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
assign op_stm = (opcode_i8 == 4'b1011) && i_t_i8 ;
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
wire op_return, op_not, op_nop, op_test, op_mov, op_stab, op_lda, op_ldsp, op_stsp ;

assign op_not = (opcode_i0 == 4'b0000) && i_t_i0 ;
assign op_mov = (opcode_i0 == 4'b0001) && i_t_i0 ;
assign op_test = (opcode_i0 == 4'b0010) && i_t_i0 ;
//assign op_lda = (opcode_i0 == 4'b0100) && i_t_i0 ;
assign op_lda = 1'b0 ;
assign op_return = (opcode_i0 == 4'b0011) && i_t_i0 ;
assign op_nop = (opcode_i0 == 4'b1111) && i_t_i0 ;
assign op_stsp = (opcode_i0 == 4'b1110) && i_t_i0 ;
assign op_stab = (opcode_i0 == 4'b1000) && i_t_i0 ;
assign op_ldsp = (opcode_i0 == 4'b1010) && i_t_i0 ;

// Move operations buffer<->acc
wire op_ldba = op_mov && !field_op ;
wire op_ldab = op_mov && field_op ;


// operation type selection
wire source_dmem, source_field, source_imm, source_sp, source_in ;
wire dest_acc, dest_dmem, dest_field, dest_sp, dest_pc, dest_reg ;

assign source_field = field_op ;
assign source_dmem = op_ldsp | op_ldm | op_addm | op_subm | op_orm | op_andm ; // TODO: | op_lda if re-added
assign source_sp = op_incsp | op_decsp ;
assign source_imm = op_ldi | op_setsp | op_setb ;
assign source_in = op_in ;


// Which ops are committed to a register (ACC or Field_Out)
assign dest_reg = ( op_or | op_and | op_addm | op_subm | op_add | op_sub
                  | op_lda | op_ldm | op_shl | op_shr | op_asr | op_shlo  
		  | op_ldsp | op_in | op_not | op_mov | op_ldi) ;
assign dest_acc = (!field_op && dest_reg) ;
assign dest_field = (field_op && dest_reg) ; 
assign dest_dmem = op_stm | op_stsp ; // op_stm is stam and stfm
assign dest_sp = op_setsp | op_incsp | op_decsp ;
assign dest_pc = op_bf | op_bb | op_call | op_return ;

// register f
// immediate_pc <= immediate_i8_regd ; // delay a further cycle for PCor next stage of the pipeline
reg [3:0] immediate_bufp_regd ;
reg [d_width-1:0] immediate_all_regd ;
reg [7:0] immediate_i8_regd ;
reg [7:0] immediate_pc ;
reg [3:0] condition_decoded ;
reg [d_width-1:0] alu_b_regd ; // pre-MUXd alu inputs
reg [d_width-1:0] alu_b_regd_2 ; // pre-MUXd alu inputs
reg [d_width-1:0] alu_b_regd_3 ; // pre-MUXd alu inputs
reg [d_width-1:0] field_value_muxd ; // pre-MUXd alu inputs

wire [d_width-1:0] immediate_i_all ;
assign immediate_i_all = (i_t_i8) ? immediate_i8 : {{5{1'b0}}, immediate_i3} ;

wire [d_width-1:0] data_in ;
task reg_instr ;
	begin
		immediate_bufp_regd <= immediate_i8[3:0] ; // Duplicated to aid fan-out. DC will merge if more optimal
		immediate_i8_regd <= immediate_i8 ;
		immediate_pc <= immediate_i8_regd ; // delay a further cycle for PC
		immediate_all_regd <= immediate_i_all ; 
		// condition flags: {N, Z, AL}
		case (condition)
			0: condition_decoded <= 4'b0001 ;
			1: condition_decoded <= 4'b0010 ;
			2: condition_decoded <= 4'b0100 ;
			3: condition_decoded <= 4'b1000 ;
		endcase
		
		alu_b_regd <= (source_dmem) ? data_in : immediate_i_all ; // TODO- New rationalise
		alu_b_regd_2 <= (source_dmem) ? data_in : immediate_i_all ;
	//	alu_b_regd_3 <= (source_dmem) ? data_in : immediate_i_all ;
		field_value_muxd <= (low_high_buffer) ?  field_in_high : field_in_low ;
	end
endtask

reg op_bf_regd, op_bb_regd, op_call_regd, op_ldi_regd, op_ldm_regd, op_stm_regd, op_setsp_regd, op_or_regd ;
reg op_and_regd, op_sub_subm_regd, op_add_addm_regd, op_sub_subm_regd_2, op_add_addm_regd_2, op_orm_regd, op_andm_regd ;
reg op_in_regd, op_shl_regd, op_shr_regd, op_shlo_regd, op_asr_regd, op_out_regd, op_setb_regd ;
reg op_incsp_regd, op_decsp_regd ;
reg op_return_regd, op_not_regd, op_test_regd, op_nop_regd, op_mov_regd, op_stab_regd, op_lda_regd, op_ldsp_regd, op_stsp_regd ;
reg field_op_regd ;
reg field_op_regd_2 ;
reg field_op_regd_3 ;

task reg_ops ;
	begin
		field_op_regd <= field_op ;
		field_op_regd_2 <= field_op ;
		field_op_regd_3 <= field_op ;
		op_bf_regd <= op_bf ;
		op_bb_regd <= op_bb ;
		op_call_regd <= op_call ;
		op_ldi_regd <= op_ldi ;
		op_ldm_regd <= op_ldm ;
		op_stm_regd <= op_stm ;
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
		op_test_regd <= op_test ;
		op_mov_regd <= op_mov ;
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
reg dest_pc_regd ;

task reg_srcdest ;
	begin
		source_field_regd <= source_field ;
		source_dmem_regd <= source_dmem ;
		source_sp_regd <= source_sp ;
		source_imm_regd <= source_imm ;
		source_in_regd <= source_in ;
		dest_acc_regd <= dest_acc ;
		dest_pc_regd <= dest_pc ;
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

//assign pc_immediate = instruction_2[7:0] ; // immediate_i8 ;
//assign return_address = (op_return) ? call_stack[call_stack_pointer] : immediate_i8 ;

reg [2:0] bubbles ;
reg jumping ;
reg jump_forward ;
reg jump_return ;
`define NOPIPELINEBUBBLES 4

program_counter thePC(clk, reset, pc, immediate_pc, jump_forward, jump_return, op_call_regd) ; 

// * End program counter *

// =====================================================================
// ================== PIPELINE STAGE 2: ALU and commit  ================
// =====================================================================

// instantiate the shared ALU
wire [d_width-1:0] acc_alu_a ;
wire [d_width-1:0] acc_alu_b ;
wire [d_width-1:0] acc_alu_y ;
wire [d_width-1:0] field_alu_a ;
wire [d_width-1:0] field_alu_b ;
wire [d_width-1:0] field_alu_y ;

// select duplicated for fan-out reasons
//assign alu_a[7:4] = (field_op_regd) ? field_value_muxd[7:4] : acc[7:4] ;
//assign alu_a[3:0] = (field_op_regd_3) ? field_value_muxd[3:0] : acc[3:0] ;
//assign alu_b = alu_b_regd ;
	
wire [d_width-1:0] result ; 

//Below saves only 100-150ps
//reg [7:0] alu_y_regd ;
//always @(posedge clk)
//begin
//	alu_y_regd <= alu_y ;
//end

wire [d_width-1:0] alus_result ;
assign alus_result = (field_op_regd) ? field_alu_y : acc_alu_y ;

// TODO: NewD Re-add inputs.
assign result = (source_imm_regd | op_ldm_regd) ? alu_b_regd : alus_result ;
//assign result = (source_imm_regd | op_ldm_regd) ? alu_b_regd : (source_in_regd) ? inputs : alus_result ;// TODO: NewD Remove bypass by re-engineering ALU with passthrough
// TODO: NewD Three inputs, with selection registered before this point

alu accALU(acc_alu_a, alu_b_regd, acc_alu_y, op_or_regd, op_and_regd, op_not_regd, op_add_addm_regd, op_sub_subm_regd, op_shl_regd, op_shlo_regd, op_shr_regd, op_asr_regd) ;
alu fieldALU(field_value_muxd, alu_b_regd_2, field_alu_y, op_or_regd, op_and_regd, op_not_regd, op_add_addm_regd, op_sub_subm_regd, op_shl_regd, op_shlo_regd, op_shr_regd, op_asr_regd) ;


// END ALUS




// control tasks

/*
task getField() ;
	begin 
		field_value <= (low_high_buffer) ? field_in_high : field_in_low ;
	end
endtask
*/

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
		if (field_op_regd_2)
		begin
			z <= (field_value_muxd == 0) ;
			n <= (field_value_muxd[d_width-1] == 1) ;
		end
		else
		begin
			z <= (acc == 0) ;
			n <= (acc[d_width-1] == 1) ;
		end
	end
endtask

`define COND_Z 0 // zero
`define COND_NZ 1 // not-zero
`define COND_N 2 // negative
`define COND_AL 3 // always

function checkCondition ;
	input [3:0] cond_decoded ;
	input z ;
	input n ; 
	begin
	checkCondition = cond_decoded[`COND_AL] |
	       	(cond_decoded[`COND_N] && n) |
	       	(cond_decoded[`COND_NZ] && ~n) |
		(cond_decoded[`COND_Z] && z) ;
	end
endfunction



assign jump = jump_forward | jump_return ;
always @(posedge clk)
	begin
		instruction_1 <= instruction_in ;
		instruction_3 <= instruction_in ;
		instruction_4 <= instruction_in ;
		//dmem_in <= immediate_i8 ; // TODO: Restore latching
		reg_instr() ;
		reg_ops() ;
		reg_srcdest() ;
          	//getField() ;
		updateFieldp() ;
		updateFieldwp() ;
		getData() ;
		//updateFlags() ; // Having this regd means two cycles of
		//match, which gives unexpected execution results.

		if (bubbles > 0) begin
			bubbles <= bubbles - 1 ;
			jump_forward <= 1'b0 ;
			jump_return <= 1'b0 ;
		end

		if (bubbles == 0) begin
			jumping <= 1'b0 ;
		end

	if (checkCondition(condition_decoded, z, n) && !jumping) //TODO: Restore conditionality
	begin
		if (dest_pc_regd) begin
			if (op_return_regd) begin
				jump_return <= 1'b1 ;
				jumping <= 1'b1 ;
				bubbles <= `NOPIPELINEBUBBLES ;
			end
			else begin
				jump_forward <= 1'b1 ;
				jumping <= 1'b1 ;
				bubbles <= `NOPIPELINEBUBBLES ;
			end
		end

		if (dest_acc_regd) begin
			 acc <= result ;
		end

		if (dest_field_regd) begin
			field_out <= result ;
			if (low_high_buffer) field_write_en_high <= 1'b1 ;
			else field_write_en_low <= 1'b1 ;
		end
		else begin
			field_write_en_high <= 1'b0 ;
			field_write_en_low <= 1'b0 ;
		end
		

		// TODO: Mem writes only happen as part of a dedicated
		// memory write instruction. Is mutually exclusive to
		// acc or field updates, so acc will not change.
		if (dest_dmem_regd) begin 
		data_out <= acc ;
		data_write <= 1'b1 ;
		//data_write_adr <= (op_stsp) ? sp : immediate_i8 ;
		data_write_adr <= immediate_all_regd ; //TODO: sp removed. Re-add if fast enough
		end
		else data_write <= 1'b0 ;

		if (op_test) updateFlags() ;

		if (op_out_regd)
		begin
			//outputs[immediate_regd] <= acc ; TODO: can I have more outputs like this?
			outputs <= acc ; 
		end

		if (op_setb_regd)
		begin
			bufp <= immediate_bufp_regd[2:0] ;
			low_high_buffer <= immediate_bufp_regd[3] ;
		end

/* REMOVED OPS FOR PERFORMANCE REASONS 
 * if (op_call_regd)
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
		*/



	end

	end



endmodule


module program_counter(clk, reset, pc_out, jump_offset, jump_forward, jump_return, call) ;
parameter i_adr_width = 10 ;
`define PC_CALL_ADJUST 4 // how many instructions ahead of next instruction to be executed the PC is
input clk, reset ;
input [7:0] jump_offset ;
input jump_forward ;
input jump_return ;
input call ;

output [i_adr_width-1:0] pc_out ;
reg [i_adr_width-1:0] pc ; // program counter
reg [i_adr_width-1:0] pc_out ; // program counter copy to drive memory
reg [i_adr_width-1:0] lr ;

wire [i_adr_width-1:0] pcInc ;
wire [i_adr_width-1:0] pcAdd ;
wire [i_adr_width-1:0] pcSub ;

pc_inc pcIncr(pc, pcInc) ;
//pc_add pcAddr(pc, immediate_i8, pcAdd) ;
//pc_sub pcSubr(pc, immediate_i8, pcSub) ;
pc_add_signed pcAddrSigned(pc, jump_offset, pcAdd) ;

always @(posedge clk)
	begin
		if (reset) pc <= 0 ;
		else 
		begin
			if (call) lr <= pc - `PC_CALL_ADJUST ; // TODO: Check value of call adjust
		//	if (op_call) pc <= immediate_i8 ; // FIXME add call back
		//	if (op_return) pc <= return_adr ; // FIXME add return back
/*			if (op_bf) begin
			  pc <= pcAdd ;
			  pc_out <= pcAdd ;
			end
			else if (op_bb) begin 
				pc <= pcSub ;
				pc_out <= pcSub ;
			end
			*/
		       if (jump_forward) begin
			       pc <= pcAdd ;
			       pc_out <= pcAdd ;
		       end
			else if (jump_return) begin
				pc <= lr ;
				pc_out <= lr ;
			end
			else begin
				pc <= pcInc ;
				pc_out <= pcInc ;
			end
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
input [d_width-1:0] offset ;
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

module pc_add_signed(pc, offset, pc_next) ;
parameter i_adr_width = 10 ;
parameter d_width = 8 ;

input [i_adr_width-1:0] pc ;
input [d_width-1:0] offset ;
output [i_adr_width-1:0] pc_next ;

wire [i_adr_width-1:0] offset_extended ;

assign offset_extended = {{i_adr_width-d_width{offset[d_width-1]}}, offset} ;

assign pc_next = pc + offset_extended ;

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
	(b == 1) ? (a << 1) | {1{1'b1}} :
	(b == 2) ? (a << 2) | {2{1'b1}} :
	(b == 3) ? (a << 3) | {3{1'b1}} :
	(b == 4) ? (a << 4) | {4{1'b1}} :
	(b == 5) ? (a << 5) | {5{1'b1}} :
	(b == 6) ? (a << 6) | {6{1'b1}} :
	(a << 7) | {7{1'b1}} ; // b == 7 case


assign y = op_shl ? shl : shr ; // FIXME: Revert to full functionality
//	   op_shr ? shr :
//	   op_shlo ? shlo :
//		asr ;

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
parameter d_adr_width = 4 ; // data address space size
parameter d_width = 8 ; // data width
parameter dmemsize = 8 ;

input clk ;
input [d_adr_width-1:0] data_read_adr ;
input [d_adr_width-1:0] data_write_adr ;
input [d_width-1:0] data_in ;
input data_write ;

output [d_width-1:0] data_out ;

reg [d_width-1:0] dmem [dmemsize] ;
//wire [d_width-1:0] read_bus [dmemsize] ;
//genvar i,j ;


assign data_out = dmem[data_read_adr] ;
always @(posedge clk) begin
	if (data_write)
		dmem[data_write_adr] <= data_in ;
	end


// read decoder 
/*
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
parameter i_mem_size = 512 ;
parameter i_mem_lines =  256 ; //imem_size / i_buffer_size ;
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

module instruction_buffer(clk, reset, instruction_address, instruction_out, imem_write_adr, imem_write, imem_in, jump) ;

parameter i_buffer_size = 2 ;
parameter i_mem_adr_start_bit = 1 ; // first address bit of significance for imem
parameter i_adr_width = 10 ;
parameter i_width = 20 ; // instruction width


input clk, reset ;
input [i_adr_width-1:0] instruction_address ;
input [i_adr_width-1:0] imem_write_adr ;
input imem_write ;
input [(i_buffer_size*i_width)-1:0] imem_in ;
input jump ;

output [i_width-1:0] instruction_out ;
reg [i_width-1:0] instruction_out ;


reg [i_adr_width-1:0] imem_read_adr ;
wire [(i_buffer_size*i_width)-1:0] imem_out ;

reg [i_width-1:0] i_buffer [i_buffer_size] ;
reg inst_index ;
reg [1:0] jump_bubble ;

inst_mem iMem(imem_read_adr, imem_write_adr, imem_write, imem_in, imem_out) ;

assign imem_read_adr = instruction_address[i_adr_width-1:i_mem_adr_start_bit] ;

//wire jump_int ;
//assign jump_int = (instruction_out[11:8] == 4'b1000) ;

/* Mechanism
/  If the PC shows an even number, go and fetch that instruction line from memory.
/  Then, load both into the instruction buffer
/  and MUX the next instruction out of this.
*/
always @(posedge clk)
begin
	if (reset)
	begin
		i_buffer[0] <= `INSTR_NOP ;
		i_buffer[1] <= `INSTR_NOP ;
		instruction_out <= `INSTR_NOP ;
		jump_bubble <= 1 ;
	end

	else if (jump) 
	begin
		instruction_out <= `INSTR_NOP ;
		jump_bubble <= 2 ;
	end

	else if (jump_bubble > 0)
	begin
		instruction_out <= `INSTR_NOP ;
		jump_bubble <= jump_bubble - 1 ;
	end

	else
	begin
		instruction_out <= instruction_address[0] ?  
			i_buffer[0] : i_buffer[1] ;
	end

	if (instruction_address[0] == 0)
	begin
		i_buffer[0] <=  imem_out[19:0] ;
		i_buffer[1] <= 	imem_out[39:20] ;
	end
end	
	
endmodule
