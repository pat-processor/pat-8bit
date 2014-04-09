#!/usr/bin/python -u

from __future__ import print_function
import sys

# i8 operators
I8_OPS = ["ORI", "ANDI", "ADDM", "SUBM", "ADDI", "SUBI", "LDI", "LDM", "BF", "BB", "ORM", "ANDM"] 
I8_OPCODES = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xd, 0xe]

#i3 operators
I3_OPS = ["SHLZ", "SHLO", "SHRZ", "ASR", "IN", "OUT", "SETB"]
I3_OPCODES = [0, 1, 2, 3, 6, 8, 9]

#i0 operators
I0_OPS = ["NOT", "TEST", "NOP"]
I0_OPCODES = [0, 2, 5]

CONDITIONS = ["Z", "LT", "GT", "AL"]
COND_CODES = [0, 1, 2, 3]


input_file_name = 'pat.asm'
input_file = open(input_file_name, 'r')

def get_condition(instr): 
	cond = 3 # default to ALWAYS
	i = 0
	while i < len(CONDITIONS):
		if instr.startswith(CONDITIONS[i]):
			cond, sep, instr = instr.partition(CONDITIONS[i])
			cond = COND_CODES[i]
			return (cond, instr)
		i+=1
	return (cond, instr)

def get_opcode(instr):
	i = 0
	while i < len(I8_OPS):
		if instr.startswith(I8_OPS[i]):
			foo, bar, instr = instr.partition(I8_OPS[i])
			opcode = I8_OPCODES[i]
			return (opcode, 8, instr)
		i+=1

	i = 0

	while i < len(I3_OPS):
		if instr.startswith(I3_OPS[i]):
			foo, bar, instr = instr.partition(I3_OPS[i])
			opcode = I3_OPCODES[i]
			return (opcode, 4, instr)
		i+=1

	i = 0

	while i < len(I0_OPS):
		if instr.startswith(I0_OPS[i]):
			foo, bar, instr = instr.partition(I0_OPS[i])
			opcode = I0_OPCODES[i]
			return (opcode, 0, instr)
		i+=1

# see if the destination is a field or the acc
def get_dest(instr):
	if instr.startswith("F"):
		return 1 #field
	else:
		 return 0 # acc

def encode_instr(fieldp, cond, opcode, shift, dest, immediate):
	# TODO: Insert bounds checking on immediates
	if (shift == 8):
		return ((fieldp << 15) | (cond << 13) | (dest << 12) | (opcode << 8) | immediate)
	elif (shift == 4):
		return ((fieldp << 15) | (cond << 13) | (dest << 12) | (opcode << 4) | immediate)
	else:
		return ((fieldp << 15) | (cond << 13) | (dest << 12) | opcode)


address = 0
mem = []
labels = {}

for instr in input_file:
	# assert 
#	print(instr)
	instr, sep, immediate = instr.partition(' ')
	instr = instr.strip()
	immediate = immediate.strip()
	if (instr.startswith(':')): # labels start with ':' and are all alpha
		instr = instr.strip(':')
		print("Found label:", instr)
		if instr in labels:
			print("ERROR!: Duplicate key found:", instr, "at", address, "previously declared at", labels[instr])
			sys.exit(-1)
		else:
			labels[instr] = address
	else:
		if (immediate.isdigit()): # label uses are all alpha immediates
			print("Immediate is number:", immediate)
			immediate = int(immediate)
		else:
			print("Label use of:", immediate, labels[immediate])
			immediate = labels[immediate]

		cond, instr = get_condition(instr)
		opcode, shift, instr = get_opcode(instr)
		dest = get_dest(instr)
		#print (cond, opcode, shift, dest, immediate, instr)
		emit = encode_instr(0, cond, opcode, shift, dest, immediate)
		emit = (hex(emit)[2:]) # to hex and lose the '0x' prefix
		#print(emit)
		mem.append(emit) 
		address += 1
	
address = 0
for item in mem:
	print(address, item)
	address += 1


