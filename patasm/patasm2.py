#!/usr/bin/python -u

# PAT Assembler 2
# 30/07/2014
# Simon Hollis (simon@cs.bris.ac.uk)
# For 23-bit implicit register version of PAT

from __future__ import print_function
import sys

input_file_name = 'pat.asm'
input_file = open(input_file_name, 'r')

output_file_name = 'pat.hex'

# i8 operators
I8_OPS = ["ORI", "ORR", "ANDI", "ANDR", "ADDI", "ADDR", "SUBI", "SUBR", "LDIR", "BF", "CALL"] 
I8_OPCODES = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0xd, 0xe]

#i3 operators
I3_OPS = ["SHLZI", "SHLZR", "SHLOI", "SHLOR", "SHRZI", "SHRZR", "ASRI", "ASRR", "INR", "OUTR", "SETB"]
I3_OPCODES = [0, 1, 2, 3, 4, 5, 6, 7, 8, 0xb, 0xc]

#i0 operators
I0_OPS = ["NOT", "TEST", "RETURN", "NOP"]
I0_OPCODES = [0, 2, 3]

CONDITIONS = ["Z", "LT", "GT", "AL"]
COND_CODES = [0, 1, 2, 3]



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

def is_branch(instr):
	return instr.startswith("B") or instr.startswith("ZB") or instr.startswith("ALB") or instr.startswith("LTB") or instr.startswith("GTB")

def calculate_branch(address, immediate):
	offset = immediate - address
	if (offset >= 0):
		print("Branch forward by:", offset)
		return (offset, "BF")
	else:
		offset = abs(offset)
		print("Branch backward by:", offset)
		return (offset, "BB")


# see if the destination is a field or the acc
def get_dest(instr):
	if instr.endswith("F"):
		return 1 #field
	else:
		 return 0 # acc

def encode_instr(rd, fieldp, cond, opcode, shift, dest, immediate):
	# TODO: Insert bounds checking on immediates
	if (shift == 8):
		return ((rd << 20) | (fieldp << 15) | (cond << 13) | (dest << 12) | (opcode << 8) | immediate)
	elif (shift == 4):
		return ((rd << 20) | (fieldp << 15) | (cond << 13) | (dest << 12) | (opcode << 4) | immediate)
	else:
		return ((rd << 20) | (fieldp << 15) | (cond << 13) | (dest << 12) | opcode)


def write_hexfile(mem):
	out = open(output_file_name, 'w')
	address = 0
	while (address < len(mem)):
		out.write('@'+str(address/2)+' ')
		if (address + 1 < len(mem)):
			first = mem[address]
			second = mem[address+1]
			print(first+second)
			out.write(first+second)
		else:
			first = mem[address]
			second = "00000"
			print(first+second)
			out.write(first+second)
		out.write("\n")
		address += 2	
	out.close()

def write_hexfile_23bit(mem):
	out = open(output_file_name, 'w')
	address = 0
	while (address < len(mem)):
		out.write('@'+str(address/2)+' ')
		if (address + 1 < len(mem)):
			first = int(mem[address], 16)
			second = int(mem[address+1], 16)
			out.write(hex(first << 23 | second)[2:])
		else:
			first = int(mem[address], 16)
			second = 0
			out.write(hex(first << 23 | second)[2:])
		out.write("\n")
		address += 2	
	out.close()

##################################
address = 0
mem = []
labels = {}

for instr in input_file:
	# assert 
	print(instr)
	tokens = instr.split()
#	for t in tokens:
#		print(t)
	instr = tokens[0]
	print("Instruction is", instr, ", ", end="")
	if len(tokens) > 1:
		rd = tokens[1]
		print("Rd is", rd, ", ",  end="")
		rd = rd[1:] # strip 'r'
		rd = int(rd)
	if len(tokens) > 2:
		immediate = tokens[2]
		immediate.strip()

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
		
		if (is_branch(instr)):
			print ("Branch")
			immediate, branchtype = calculate_branch(address, immediate)
			instr = instr.replace("B", branchtype)
			print("Updated branch instruction is:", instr)
			

		opcode, shift, instr = get_opcode(instr)
		dest = get_dest(instr)
		#print (cond, opcode, shift, dest, immediate, instr)
		emit = encode_instr(rd, 0, cond, opcode, shift, dest, immediate)
		emit = (hex(emit)[2:]).zfill(6) # to hex, pad with zeroes and lose the '0x' prefix
		#print(emit)
		mem.append(emit) 
		address += 1

write_hexfile_23bit(mem)	
#address = 0
#for item in mem:
#	print(address, item)
#	address += 1


