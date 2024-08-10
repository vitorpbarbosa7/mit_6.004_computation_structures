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

MDATA_byte = R25
Rc_byte = R22

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
	
	// extract the Rc, Ra, literal  
	extract_field(R0, 25, 21, Rc) // Rc
	extract_field(R0, 20, 16, Ra) // Ra
	extract_field(R0, 15, 0, literal) // literal
	
	//EA <=Reg[Ra] + SEXT(literal)
	ADDC(Ra, literal, EA)
	//MDATA <= Mem[EA]
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
	extract_field(MDATA, 7, 0, MDATA_byte)
	BR(_ldb_rtn)
	
_ldb_two:
	extract_field(MDATA, 15, 8, MDATA_byte)
	BR(_ldb_rtn)

_ldb_three:
	extract_field(MDATA, 23, 16, MDATA_byte)
	BR(_ldb_rtn)

_ldb_four:
	extract_field(MDATA, 31, 24, MDATA_byte)
	BR(_ldb_rtn)

_ldb_rtn:
	ADDC(R31, 0, Rc)
	OR(MDATA_byte, Rc, Rc) // Register C contents altered, with the single byte content
	CMOVE(0x000000FF, R24)
	AND(Rc, R24, Rc)
	BR(_exit)

// Store 1 byte (not full workd 4 bytes - 32 bits) into memory 
STB:
	ADDC(R31, 0, R21) // for shifting 
	// STB(Rc, literal, Ra)
	// decode the opcode to correspond to the instruction	
	
	// extract the Rc, Ra, literal  
	extract_field(R0, 25, 21, Rc) // Rc
	extract_field(R0, 20, 16, Ra) // Ra
	extract_field(R0, 15, 0, literal) // literal
	
	// EA <= Reg[Ra] + SEXT(literal)
	ADDC(Ra, literal, EA)
	
	//MDATA <= Mem[EA]
	LD(EA, 0, MDATA)
	
	extract_field(EA, 1, 0, OFF) 
	
// 	extract_field(Rc, 7, 0, R12)
	
	CMPEQC(OFF, 0b00, R12)
	BEQ(R12, _stb_one)
	
	CMPEQC(OFF, 0b01, R12)
	BEQ(R12, _stb_two)
	
	CMPEQC(OFF, 0b10, R12)
	BEQ(R12, _stb_three)

	CMPEQC(OFF, 0b11, R12)
	BEQ(R12, _stb_four)

// We we need to alter the MDATA	
_stb_one:
	extract_field(Rc, 7, 0, Rc_byte)
	OR(MDATA, 0b00000000, MDATA)
	OR(MDATA, Rc_byte, MDATA)
	BR(_stb_rtn)

_stb_two:
	CMOVE(0xFFFF, R23)`
	SHLC(R23, 16, R23)
	ANDC(R23, 0x00FF, R23)
	ANDC(MDATA, R23, MDATA)	
	
	extract_field(Rc, 7, 0, Rc_byte)
	SHLC(Rc_byte, 8, R21)
	OR(MDATA, R21, MDATA)
	BR(_stb_rtn)

_stb_three:
	CMOVE(0xFF00, R23)
	SHLC(R23, 16, R23)
	ANDC(R23, 0xFFFF, R23)
	ANDC(MDATA, R23, MDATA)	
	
	extract_field(Rc, 7, 0, Rc_byte)
	SHLC(Rc_byte, 16, R21)
	OR(MDATA, R21, MDATA)
	BR(_stb_rtn)

_stb_four:
	CMOVE(0x00FF, R23)
	SHLC(R23, 16, R23)
	ANDC(MDATA, R23, MDATA)	
	
	extract_field(Rc, 7, 0, Rc_byte)
	SHLC(Rc_byte, 24, R21)
	OR(MDATA, R21, MDATA)
	BR(_stb_rtn)
	
_stb_rtn:
	// create the desired final side effect on the memory address
	ST(MDATA, literal, Ra)
	BR(_exit)

exit_illegal:
	restore_all_regs(regs)
	BR(_IllegalInstruction)
	
_exit:	
	restore_all_regs(regs)
	JMP(XP)
