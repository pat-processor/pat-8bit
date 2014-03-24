module pat(reset, pc, bufp, fieldp, fieldwp, field_write_en, field_out, imem_in_port, field_in, clk, acc, inputs, outputs) ;

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

input reset ;
input [i_width-1:0] imem_in_port ;
//input [d_width-1:0] data_in;
input [buffer_width-1:0] field_in ;
input clk ;
input [d_width-1:0] inputs [8] ;

output [i_adr_width-1:0] pc ;
output [bufp_width-1:0] bufp ;
output [fieldp_width-1:0] fieldp ;
output [fieldp_width-1:0] fieldwp ;
output field_write_en ;
output [buffer_width-1:0] field_out ;

output [d_width-1:0] acc ; //FIXME: remove --- debug
output [d_width-1:0] outputs [8] ;
reg [i_width-1:0] imem_in ;

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
//reg [d_width-1:0] dmem [16] ; // TODO: Select this memory or external

reg [d_width-1:0] outputs [8] ;

// instruction type selection

wire i_t_i0 ;
wire i_t_i3 ;
wire i_t_i8 ;


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

assign opcode_i3 = imem_in[7:4] ; // TODO: parameterise. Must not overlap with i0 opcode space
assign immediate_i3 = imem_in[2:0] ; 
assign opcode_i0 = imem_in[3:0] ;


// determine the type of operation
//assign i_t_i8 = (opcode_i8[3:0] != `i3_opcode_prefix) ? 1'b1 : 1'b0 ;
//assign i_t_i3 = (!i_t_i8) && (opcode_i3[3:0] != `i0_opcode_prefix) ? 1'b1 : 1'b0 ;
//assign i_t_i0 = (!i_t_i8) && (!i_t_i3) ;

assign i_t_i8 = (opcode_i8 != 4'b1111) ;
assign i_t_i3 = ((opcode_i8 != 4'b1111) && (opcode_i3 != 4'b1111)) ;
assign i_t_i0 = (!opcode_i8 && !opcode_i3) ;

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
//assign op_ldsp = (opcode_i3 == 4'b0100) && i_t_i3 ;
assign op_in = (opcode_i3 == 4'b0101) && i_t_i3 ;
//
//
assign op_out = (opcode_i3 == 4'b1000) && i_t_i3 ;
assign op_setb =(opcode_i3 == 4'b1001) && i_t_i3 ;
//assign op_ldsp =(opcode_i3 == 4'b1010) && i_t_i3 ;
//
//
//assign op_stasp = (opcode_i3 == 4'b1100) && i_t_i3 ;
assign op_incsp = (opcode_i3 == 4'b1101) && i_t_i3 ;
assign op_decsp = (opcode_i3 == 4'b1110) && i_t_i3 ;
// 4'b1111 is i0 prefix

// i0 operations
wire op_return, op_not, op_nop, op_ldba, op_stab, op_lda, op_ldsp, op_stsp ;

assign op_not = (opcode_i0 == 4'b0000) && i_t_i0 ;
assign op_ldba = (opcode_i0 == 4'b0001) && i_t_i0 ;
//assign op_lda = (opcode_i0 == 4'b0010) && i_t_i0 ;
assign op_return = (opcode_i0 == 4'b0011) && i_t_i0 ;
assign op_nop = (opcode_i0 == 4'b0101) && i_t_i0 ;
assign op_stab = (opcode_i0 == 4'b0100) && i_t_i0 ;
//assign op_ldsp = (opcode_i0 == 4'b0110) && i_t_i0 ;
//assign op_stsp = (opcode_i0 == 4'b0111) && i_t_i0 ;




// operation type selection
wire source_acc, source_dmem, source_field, source_imm, source_sp ;
wire dest_acc, dest_dmem, dest_field, dest_sp, dest_pc ;
wire dest_from_alu ; // aids readability

assign source_field = field_op ;
//assign source_acc = op_or | op_and | op_not | op_add | op_sub | (op_stam && !field_op) ;
assign source_dmem = op_ldsp | op_lda | op_ldm | op_addm | op_subm | op_orm | op_andm ;
assign source_sp = op_incsp | op_decsp ;
assign source_imm = op_ldi | op_setsp | op_setb ;

//assign dest_acc = (!field_op) && (i_t_i8 && opcode_i8[3] == 0) | op_orm | op_andm | (i_t_i3 && opcode_i3[3] == 0) | (i_t_i0 && (op_not | op_ldba | op_lda)) ;

assign dest_from_alu = ( op_or | op_and | op_addm | op_subm | op_add | op_sub
                                  | op_lda | op_ldm | op_shl | op_shr | op_asr | op_shlo
				  | op_ldsp | op_in | op_not | op_ldba | op_lda ) ;
assign dest_acc = (!field_op && dest_from_alu) ;
assign dest_field = (field_op && dest_from_alu) ; 
assign dest_dmem = op_stam | op_stsp ;
assign dest_sp = op_setsp | op_incsp | op_decsp ;
assign dest_pc = op_bf | op_bb | op_call | op_return ;


// register for next stage of the pipeline
reg [d_width-1:0] immediate_i8_regd ;
reg [1:0] condition_regd ;

task reg_instr ;
	begin
		immediate_i8_regd <= i_t_i8 ? immediate_i8 : {{5{1'b0}}, immediate_i3} ;
		condition_regd <= condition ;
	end
endtask

reg op_bf_regd, op_bb_regd, op_call_regd, op_ldi_regd, op_ldm_regd, op_stam_regd, op_setsp_regd, op_or_regd ;
reg op_and_regd, op_addm_regd, op_subm_regd, op_add_regd, op_sub_regd, op_orm_regd, op_andm_regd ;
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
		op_addm_regd <= op_addm ;
		op_subm_regd <= op_subm ;
		op_add_regd <= op_add ;
		op_sub_regd <= op_sub ;
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


reg field_op_regd ;
reg source_field_regd ;
reg source_dmem_regd  ;
reg source_sp_regd  ;
reg source_imm_regd ;
reg dest_acc_regd  ;
reg dest_field_regd ;
reg dest_dmem_regd ;
reg dest_sp_regd ;
reg dest_pc_regd ;

task reg_srcdest ;
	begin
		field_op_regd <= field_op ;
		source_field_regd <= source_field ;
		source_dmem_regd <= source_field ;
		source_sp_regd <= source_field ;
		source_imm_regd <= source_field ;
		dest_acc_regd <= dest_acc ;
		dest_field_regd <= dest_field ;
		dest_dmem_regd <= dest_dmem ;
		dest_sp_regd <= dest_sp ;
		dest_pc_regd <= dest_pc ;
	end
endtask










// instantiate two ALUs to speed up by preventing input MUX
wire [d_width-1:0] acc_alu_a ;
wire [d_width-1:0] acc_alu_b ;
wire [d_width-1:0] acc_alu_y ;
wire [d_width-1:0] field_alu_a ;
wire [d_width-1:0] field_alu_b ;
wire [d_width-1:0] field_alu_y ;

alu accALU(acc_alu_a, acc_alu_b, acc_alu_y, op_or_regd, op_and_regd, op_not_regd, (op_add_regd | op_addm_regd), (op_sub_regd | op_subm_regd), op_shl_regd, op_shlo_regd, op_shr_regd, op_asr_regd) ;
alu fieldALU(field_alu_a, field_alu_b, field_alu_y, op_or_regd, op_and_regd, op_not_regd, (op_add_regd | op_addm_regd), (op_sub_regd | op_subm_regd), op_shl_regd, op_shlo_regd, op_shr_regd, op_asr_regd) ;


/*`
assign alu_a = source_field ? field_in :
	       source_sp ? sp : acc ;
*/
wire [d_width-1:0] data_in ;
wire [d_adr_width-1:0] data_read_adr ;

assign data_read_adr = (op_lda) ? acc : (op_ldsp) ? sp : immediate_i8 ;
//assign data_read_adr = immediate_i8 ; 
reg [d_adr_width-1:0] data_write_adr ; 
reg data_write ;
reg [d_width-1:0] data_regd ; 
//assign data_write = dest_dmem ;
//assign data_write_adr = immediate_i8 ;

data_mem dmem(clk, data_read_adr, data_write_adr, data_write, data_out, data_in) ;



assign acc_alu_a = acc ;
assign acc_alu_b = source_dmem_regd ? data_regd : immediate_i8_regd ;  

assign field_alu_a = field_in ;
assign field_alu_b = acc_alu_b ;

	
wire [d_width-1:0] acc_result ; 
wire [d_width-1:0] field_result ; 
wire [d_width-1:0] result ; 

assign acc_result = (source_imm_regd) ? immediate_i8_regd : (op_in_regd) ? inputs[immediate_i3] : (op_ldba_regd) ? field_in : acc_alu_y ;
assign field_result = (source_imm_regd) ? immediate_i8_regd : (op_stab_regd) ? acc : field_alu_y ;
assign result = (field_op_regd) ? field_result : acc_result ;



// END ALUS


// Program counter 

wire [d_width-1:0] pc_offset ;
assign pc_offset = immediate_i8 ;

wire [i_adr_width-1:0] return_address ;
assign return_address = call_stack[call_stack_pointer] ;

program_counter thePC(clk, reset, pc, pc_offset, op_bf, op_bb, op_return, return_address) ; // TODO work_out what should happen to the PC w.r.t. which cycle of the pipeline it should update in.

/*
task updatePC ;
begin
	pc <= pc_next ;
end
endtask
*/
// END PC


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
		imem_in <= imem_in_port ;
		//updatePC() ;
          	getField() ;
		updateFieldp() ;
		updateFieldwp() ;
		getData() ;


	if (checkCondition(condition_regd, z, n))
	begin

		if (dest_acc_regd) begin
			 acc <= acc_result ;
		//	 z <= (acc_result == 0) ; // z and n take extra time
		//	 in ALU pipeline
			// n <= (acc_result < 0) ;
		end

		if (dest_field_regd) begin
			field_out <= field_result ;
			field_write_en <= 1'b1 ;
		end
		else field_write_en <= 1'b0 ;
		

		if (dest_dmem_regd) begin 
		data_out <= result ;
		data_write <= 1'b1 ;
		//data_write_adr <= (op_stsp) ? sp : immediate_i8 ;
		data_write_adr <= immediate_i8 ; //FIXME: sp removed
		end
		else data_write <= 1'b0 ;


		if (op_call_regd)
		begin
			// FIXME: I think this arrangement gives -1 size to call
			call_stack[call_stack_pointer+1] <= pc ;
			call_stack_pointer <= call_stack_pointer + 1 ; 
		end

		if (op_return_regd)
		begin
			call_stack_pointer <= call_stack_pointer - 1 ;
		end

		if (op_setsp_regd)
		begin
			sp <= immediate_i8 ;
		end
		
		if (op_incsp_regd)
		begin
			sp <= sp + immediate_i3 ;	
		end

		if (op_decsp_regd)
		begin
			sp <= sp - immediate_i3 ;
		end

		if (op_out_regd)
		begin
			outputs[immediate_i3] <= acc ;
		end

		if (op_setb_regd)
		begin
			bufp <= immediate_i3 ;
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

//wire [i_adr_width-1:0 ] pc_next ;
//assign pc_next = (op_return) ? return_adr : (op_bf) ? pcAdd : pcInc ;

always @(posedge clk)
	begin
		if (reset) pc <= 0 ;
		else 
		begin
			if (op_return) pc <= return_adr ;
			else if (op_bf) pc <= pcAdd ;
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

assign shlo = shl ; //TODO: Implement shlo

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
//adder theAdder(a, b, add_out) ;
//subtractor theSub(a, b, sub_out) ;
orer theOR(a, b, or_out) ;
ander theAND(a, b, and_out) ;
negator theNeg(a, neg_out) ;

// enhancement from Introduction to Logic Synthesis Using Verilog HDL
// By Robert Bryan Reese, Mitchell Aaron Thornton
// seems to be quicker than my solution //TODO: see if still true
wire op_addsub = op_add | op_sub ;
wire [d_width-1:0] addsubi ;
wire [d_width-1:0] addsubout ;
assign addsubi = op_sub ? ~b : b ;
assign addsubout = a + addsubi + {{d_width-1{1'b0}}, op_sub} ;

assign y = op_or ? or_out :
	   op_and ? and_out :
	   op_not ? neg_out :
//	   op_add ? add_out :
//	   op_sub ? sub_out : 
	   op_addsub ? addsubout :
	   shift_out ; // any of the three shifts


/*
assign y = op_add ? add_out :
	    sub_out ;
*/
endmodule

module data_mem(clk, data_read_adr, data_write_adr, data_write, data_in, data_out) ;
parameter d_adr_width = 8 ; // data address space size
parameter d_width = 8 ; // data width
parameter dmemsize = 256 ;

input clk ;
input [d_adr_width-1:0] data_read_adr ;
input [d_adr_width-1:0] data_write_adr ;
input data_write ;
input [d_width-1:0] data_in ;

output [d_width-1:0] data_out ;

reg [d_width-1:0] dmem [dmemsize] ;
wire [d_width-1:0] read_bus [dmemsize] ;

genvar i,j ;

assign data_out = dmem[data_read_adr] ;
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


always @(posedge clk) begin
	if (data_write)
		dmem[data_write_adr] <= data_in ;
	end


endmodule





