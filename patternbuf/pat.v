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

module data_mem(data_read_adr, data_write_adr, data_write, data_in, data_out) ;
parameter d_adr_width = 8 ; // data address space size
parameter d_width = 8 ; // data width
parameter dmemsize = 256 ;

input [d_adr_width-1:0] data_read_adr ;
input [d_adr_width-1:0] data_write_adr ;
input data_write ;
input [d_width-1:0] data_in ;

output [d_width-1:0] data_out ;

reg [d_width-1:0] dmem [dmemsize] ;
wire [d_width-1:0] read_bus [dmemsize] ;

genvar i,j ;

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

// write
always @(data_write or data_write_adr or data_in)
begin
	if (data_write) begin
	dmem[data_write_adr] <= data_in ;
	end
end

endmodule




module pat(reset, pc, bufp, fieldp, fieldwp, field_write_en, field_out, imem_in, field_in, clk, acc, inputs, outputs) ;

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
input [i_width-1:0] imem_in ;
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

reg [d_width-1:0] acc ; // the main accumulator
reg [d_adr_width-1:0] sp ; // stack pointer


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
assign op_lda = (opcode_i0 == 4'b0010) && i_t_i0 ;
assign op_return = (opcode_i0 == 4'b0011) && i_t_i0 ;
assign op_nop = (opcode_i0 == 4'b0101) && i_t_i0 ;
assign op_stab = (opcode_i0 == 4'b0100) && i_t_i0 ;
assign op_ldsp = (opcode_i0 == 4'b0110) && i_t_i0 ;
assign op_stsp = (opcode_i0 == 4'b0111) && i_t_i0 ;



// operation type selection
wire source_acc, source_dmem, source_field, source_imm, source_sp ;
wire dest_acc, dest_dmem, dest_field, dest_sp ;
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



// instantiate two ALUs to speed up by preventing input MUX
wire [d_width-1:0] acc_alu_a ;
wire [d_width-1:0] acc_alu_b ;
wire [d_width-1:0] acc_alu_y ;
wire [d_width-1:0] field_alu_a ;
wire [d_width-1:0] field_alu_b ;
wire [d_width-1:0] field_alu_y ;

alu accALU(acc_alu_a, acc_alu_b, acc_alu_y, op_or, op_and, op_not, (op_add | op_addm), (op_sub | op_subm), op_shl, op_shlo, op_shr, op_asr) ;
alu fieldALU(field_alu_a, field_alu_b, field_alu_y, op_or, op_and, op_not, (op_add | op_addm), (op_sub | op_subm), op_shl, op_shlo, op_shr, op_asr) ;

/*`
assign alu_a = source_field ? field_in :
	       source_sp ? sp : acc ;
*/
wire [d_width-1:0] data_in ;
wire [d_adr_width-1:0] data_read_adr ;

assign data_read_adr = (op_lda) ? acc : (op_ldsp) ? sp : immediate_i8 ;
reg [d_adr_width-1:0] data_write_adr ; 
reg data_write ;

data_mem dmem(data_read_adr, data_write_adr, data_write, data_out, data_in) ;



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

wire [d_width-1:0] acc_result ; 
wire [d_width-1:0] field_result ; 
wire [d_width-1:0] result ; 

assign acc_result = (source_imm) ? immediate_i8 : (op_in) ? inputs[immediate_i3] : (op_ldba) ? field_in : acc_alu_y ;
assign field_result = (source_imm) ? immediate_i8 : (op_stab) ? acc : field_alu_y ;
assign result = (field_op) ? field_result : acc_result ;



// END ALUS


// Program counter 

wire [d_width-1:0] pc_offset ;
assign pc_offset = immediate_i8 ;


program_counter thePC(clk, reset, pc, pc_offset, op_bf, op_bb, op_return, acc) ;

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


always @(posedge clk)
	begin
		//updatePC() ;
          	getField() ;
		updateFieldp() ;
		updateFieldwp() ;

		if (dest_acc) acc <= acc_result ;

		if (dest_field) begin
			field_out <= field_result ;
			field_write_en <= 1'b1 ;
		end
		else field_write_en <= 1'b0 ;
		
		if (dest_dmem) begin 
		data_out <= result ;
		data_write <= 1'b1 ;
		data_write_adr <= (op_stsp) ? sp : immediate_i8 ;
		end
		else data_write <= 1'b0 ;

		if (op_call)
		begin
			// FIXME: I think this arrangement gives -1 size to call
			call_stack[call_stack_pointer+1] <= pc ;
			call_stack_pointer <= call_stack_pointer + 1 ; 
		end

		if (op_return)
		begin
			call_stack_pointer <= call_stack_pointer - 1 ;
		end

		if (op_setsp)
		begin
			sp <= immediate_i8 ;
		end
		
		if (op_incsp)
		begin
			sp <= sp + immediate_i3 ;	
		end

		if (op_decsp)
		begin
			sp <= sp - immediate_i3 ;
		end

		if (op_out)
		begin
			outputs[immediate_i3] <= acc ;
		end

		if (op_setb)
		begin
			bufp <= immediate_i3 ;
		end

	end

always @(negedge clk)
	begin
		data_write <= 1'b0 ; // disable write
	end

endmodule
