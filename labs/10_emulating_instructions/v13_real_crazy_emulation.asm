// why the memory offset calculation:
// Detailed Explanation
// Register Index:
// The extract_field(r0,25,21,r1) instruction extracts a 5-bit field from the trapped instruction. This field represents the index of a register (e.g., Rc) within the register file. In Beta, the index can range from 0 to 31 because there are 32 registers.

// Memory Offset:
// Each register is 4 bytes (32 bits) wide. To access the correct register in memory, you need to know its byte offset from the start of the register file. For example:

// Register r0 is at offset 0 bytes.
// Register r1 is at offset 4 bytes.
// Register r2 is at offset 8 bytes.

.include "beta.uasm"
.include "checkoff.uasm"

// register file array, that is really simulating everything in software, really weird
regs:
	RESERVE(32)
	
//Variables

EA = R10
OPCODE = R1
OFF = R11

regs_rc_byte_offset = R18
Rc = R15

regs_ra_byte_offset = R18
Ra = R16

literal = R17

MDATA = R20

MDATA_byte = R25
Rc_byte = R22

UI:
	save_all_regs(regs)
	
	// to get the opcode we must
	// - sub 4 within the xp (would be next instruction after illegal instruction)
	// - load the value of the opcode (correspond to ldb or stb) into some register? corresponding to that register
	
	LD(XP, -4, R0)  // the illegal instruction to receive the handler treatment
	// take the higher order bits to determine if it is ldb or stb?
	extract_field(R0, 31, 26, R1) 
	// ldb 010000 (26) -- stb 010001 (17)
	CMPEQC(R1, 0b010001, R2)
	BNE(R2, STB)
	
	CMPEQC(R1, 0b010000, R2)
	BEQ(R2, exit_illegal)
// Load single byte (not full word 4 bytes - 32 bits) into register
LDB:
	// LDB(Ra, literal, Rc)
	// decode the opcode to correspond to the instruction	
	
	// extract the Rc, Ra, literal  
	extract_field(R0, 25, 21, regs_rc_byte_offset) // Rc
	MULC(regs_rc_byte_offset, 4, regs_rc_byte_offset)
	LD(regs_rc_byte_offset, regs, Rc) //regs[Rc]
	
	extract_field(R0, 20, 16, regs_ra_byte_offset) // Ra
	MULC(regs_ra_byte_offset, 4, regs_ra_byte_offset)
	LD(regs_ra_byte_offset, regs, Ra) // regs[Rc]
	
	extract_field(R0, 15, 0, literal) // literal
	SHLC(literal, 16, literal)
	SRAC(literal, 16, literal) //<- SEXT(literal)
	
	//EA <=Reg[Ra] + SEXT(literal)
	ADD(Ra, literal, EA)
	//MDATA <= Mem[EA]
	LD(EA, 0, MDATA)
	
	extract_field(EA, 1, 0, OFF) 
	
	CMPEQC(OFF, 0b00, R12)
	BNE(R12, _ldb_one)
	
	CMPEQC(OFF, 0b01, R12)
	BNE(R12, _ldb_two)
	
	CMPEQC(OFF, 0b10, R12)
	BNE(R12, _ldb_three)

	CMPEQC(OFF, 0b11, R12)
	BNE(R12, _ldb_four)
	
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
	MOVE(MDATA_byte, Rc)
	CMOVE(0x00FF, R24)
	AND(Rc, R24, Rc)
	ST(Rc, regs, regs_rc_byte_offset)
	.breakpoint
	restore_all_regs(regs)
	BR(_exit)

// Store 1 byte (not full workd 4 bytes - 32 bits) into memory 
STB:
	ADDC(R31, 0, R21) // for shifting 
	// STB(Rc, literal, Ra)
	// decode the opcode to correspond to the instruction	
	
	// extract the Rc, Ra, literal  
	extract_field(R0, 25, 21, Rc) // Rc
	MULC(Rc, 4, Rc)
	extract_field(R0, 20, 16, Ra) // Ra
	MULC(Ra, 4, Ra)
	
	extract_field(R0, 15, 0, literal) // literal
	SHLC(literal, 16, literal)
	SRAC(literal, 16, literal) //<- SEXT(literal)
	
	// EA <= Reg[Ra] + SEXT(literal)
	ADDC(Ra, literal, EA)
	
	//MDATA <= Mem[EA]
	LD(EA, 0, MDATA)
	
	extract_field(EA, 1, 0, OFF) 
	
// 	extract_field(Rc, 7, 0, R12)
	
	CMPEQC(OFF, 0b00, R12)
	BNE(R12, _stb_one)
	
	CMPEQC(OFF, 0b01, R12)
	BNE(R12, _stb_two)
	
	CMPEQC(OFF, 0b10, R12)
	BNE(R12, _stb_three)

	CMPEQC(OFF, 0b11, R12)
	BNE(R12, _stb_four)

// We we need to alter the MDATA	
_stb_one:
	extract_field(Rc, 7, 0, Rc_byte)
	OR(MDATA, 0b00000000, MDATA)
	OR(MDATA, Rc_byte, MDATA)
	BR(_stb_rtn)

_stb_two:
	CMOVE(0xFFFF, R23)
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
	JMP(XP)
