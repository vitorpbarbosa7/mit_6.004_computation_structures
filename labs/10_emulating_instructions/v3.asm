.include "beta.uasm"
.include "checkoff.uasm"

UI:
    // stack discipline
	PUSH(LP)
	PUSH(BP)
	MOVE(SP, BP)
	
	// save used registers
	PUSH(R0)
	PUSH(R3)
	PUSH(R4)
	PUSH(R5)
	PUSH(R6)
	PUSH(R8)
	PUSH(R10)
	
	
	// to get the opcode we must?
	// - sub 4 within the xp (would be next instruction after illegal instruction)
	ADDC(XP, -4, R3)
	// - load the value of the opcode (correspond to ldb or stb) into some register? corresponding to that register
	LD(R3, 0, R3)
	// take the higher order bits to determine if it is ldb or stb?
	SHRC(R3, 26, R10)
	// ldb 010000 (26) -- stb 010001 (17)
	CMPEQC(R10, 17, R8)
	BEQ(R8, STB)
	
	CMPEQC(R10, 16, R8)
	BNE(R8, exit_illegal)
LDB:
	// LDB(Ra, literal, Rc)
	// LDB(R4, R5, R6)	
	// decode the opcode to correspond to the instruction
	
	
	
	
	SHRC(R3, 30, R12)
	CMPEQC(R12, 0, R11)
	BEQ(R11, one)
	
	CMPEQC(R12, 1, R11)
	BEQ(R11, two)
	
	CMPEQC(R12, 2, R11)
	BEQ(R11, three)

	CMPEQC(R12, 3, R11)
	BEQ(R11, four)
	
	MO
	
one:

two:

three:

four:


	
	
	
	MOVE(R6, R0)
	BR(_exit)
STB:
	// STB(Rc, literal, Ra)
	// LDB(Rx, Rx, Rx)	
	// decode the opcode to correspond to the instruction

	
	
	MOVE(R6, R0)
	BR(_exit)

exit_illegal:
	
	POP(R10)
	POP(R8)
	POP(R6)
	POP(R5)
	POP(R4)
	POP(R3)
	POP(R0)	
	
	MOVE(BP, SP)
	POP(BP)
	POP(LP)
	
	BR(_IllegalInstruction)

	
_exit:	
	
	
	
	POP(R10)
	POP(R8)
	POP(R6)
	POP(R5)
	POP(R4)
	POP(R3)
	POP(R0)	
	
	MOVE(BP, SP)
	POP(BP)
	POP(LP)
	
	JMP(XP)
	


	
	
	
	


STB:





	
	
	
	
	

	
	
	
	
	
   ... your assembly language code here ...
