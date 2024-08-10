.include "beta.uasm"
.include "checkoff.uasm"

//Variables

EA = R10
OPCODE = R1
OFF = R11
Rc = R15
Ra = R16
literal = R17
MDATA = R20

regs:
	RESERVE(32)

UI:
	save_all_regs(regs)
	
	// to get the opcode we must
	// - sub 4 within the xp (would be next instruction after illegal instruction)
	// - load the value of the opcode (correspond to ldb or stb) into some register? corresponding to that register
	
	LD(XP, -4, R0) 
	// take the higher order bits to determine if it is ldb or stb?
	extract_field(R0, 31, 26, R1) 
	// ldb 010000 (26) -- stb 010001 (17)
	CMPEQC(R1, 0b010001, R2)
	BEQ(R2, STB)
	
	CMPEQC(R1, 0b010000, R2)
	BNE(R2, exit_illegal)
// Load single byte (not full word 4 bytes - 32 bits) into register
LDB:
	// LDB(Ra, literal, Rc)
	// decode the opcode to correspond to the instruction	
	
	// Clear Rc, where the 8 bit (byte) data will be stored
	ADDC(R31, 0, Rc)
	// extract the Rc, Ra, literal  
	extract_field(R0, 25, 21, Rc) // Rc
	extract_field(R0, 20, 16, Ra) // Ra
	extract_field(R0, 15, 0, literal) // literal
	
	ADDC(Ra, literal, EA)
	
	LD(EA, 0, MDATA)
	
	extract_field(EA, 1, 0, OFF) 
	
	CMPEQC(OFF, 0b00, R12)
	BEQ(R12, _ldb_one)
	
	CMPEQC(OFF, 0b01, R12)
	BEQ(R12, _ldb_two)
	
	CMPEQC(OFF, 0b10, R12)
	BEQ(R12, _ldb_three)

	CMPEQC(OFF, 0b11, R12)
	BEQ(R12, _ldb_four)
	
_ldb_one:
	extract_field(MDATA, 7, 0, R12)
	BR(_ldb_rtn)
	
_ldb_two:
	extract_field(MDATA, 15, 8, R12)
	BR(_ldb_rtn)

_ldb_three:
	extract_field(MDATA, 23, 16, R12)
	BR(_ldb_rtn)

_ldb_four:
	extract_field(MDATA, 31, 24, R12)
	BR(_ldb_rtn)

_ldb_rtn:
	OR(R12, Rc, Rc) // Register C contents altered, with the single byte content
	BR(_exit)

// Store 1 byte (not full workd 4 bytes - 32 bits) into memory 
STB:
	// STB(Rc, literal, Ra)
	// decode the opcode to correspond to the instruction	
	
	// Clear Rc, where the 8 bit (byte) data will be stored
	ADDC(R31, 0, Rc)

	// extract the Rc, Ra, literal  
	extract_field(R0, 25, 21, Rc) // Rc
	extract_field(R0, 20, 16, Ra) // Ra
	extract_field(R0, 15, 0, literal) // literal
	
	ADDC(Ra, literal, EA)
	
	LD(EA, 0, MDATA)
	
	extract_field(EA, 1, 0, OFF) 
	
	extract_field(Rc, 7, 0, R12)
	
	CMPEQC(OFF, 0b00, R12)
	BEQ(R12, _stb_one)
	
	CMPEQC(OFF, 0b01, R12)
	BEQ(R12, _stb_two)
	
	CMPEQC(OFF, 0b10, R12)
	BEQ(R12, _stb_three)

	CMPEQC(OFF, 0b11, R12)
	BEQ(R12, _stb_four)

	
_stb_one:
	OR(MDATA, 0b00000000, MDATA)
	OR(MDATA, Rc, MDATA)
	BR(_stb_rtn)

_stb_two:

	BR(_stb_rtn)

_stb_three:

	BR(_stb_rtn)

_stb_four:

	BR(_stb_rtn)
	
_stb_rtn:
	// create the desired final side effect on the memory address
	LD(EA, 0, MDATA)
	BR(_exit)

exit_illegal:
	
	restore_all_regs(regs)
	
	BR(_IllegalInstruction)

	
_exit:	
	restore_all_regs(regs)
	JMP(XP)
