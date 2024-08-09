.include "beta.uasm"
.include "checkoff.uasm"

regs:
	RESERVE(32)

UI:
	save_all_regs(regs)
	
	// to get the opcode we must?
	// - sub 4 within the xp (would be next instruction after illegal instruction)
	// - load the value of the opcode (correspond to ldb or stb) into some register? corresponding to that register
	
	MOVE(XP-4, R10)
	LD(XP, -4, R0)
	// take the higher order bits to determine if it is ldb or stb?
	extract_field(R0, 31, 26, R1) 
	// ldb 010000 (26) -- stb 010001 (17)
	CMPEQC(R1, 0b010001, R2)
	BEQ(R2, STB)
	
	CMPEQC(R1, 0b010000, R2)
	BNE(R2, exit_illegal)
LDB:
	// LDB(Ra, literal, Rc)
	// LDB(R4, R5, R6)	
	// decode the opcode to correspond to the instruction	
	
	extract_field(R10, 1, 0, R11)
	CMPEQC(R11, 0, R12)
	BEQ(R12, one)
	
	CMPEQC(R11, 1, R12)
	BEQ(R12, two)
	
	CMPEQC(R11, 2, R12)
	BEQ(R12, three)

	CMPEQC(R11, 3, R12)
	BEQ(R12, four)
	
one:
	extract_field(R0, 7, 0, R12)
	// CONTINUE HERE #TODO
	BR(rtn)
	
two:
	extract_field(R0, 15, 8, R12)
	BR(rtn)

three:
	extract_field(R0, 23, 16, R12)
	BR(rtn)

four:
	extract_field(R0, 31, 24, R12)
	BR(rtn)

rtn:
	MOVE(R6, R0)
	BR(_exit)
	
STB:
	// STB(Rc, literal, Ra)
	// LDB(Rx, Rx, Rx)	
	// decode the opcode to correspond to the instruction

	
	
	MOVE(R6, R0)
	BR(_exit)

exit_illegal:
	
	restore_all_regs(regs)
	
	BR(_IllegalInstruction)

	
_exit:	
	restore_all_regs(regs)
	JMP(XP)
	