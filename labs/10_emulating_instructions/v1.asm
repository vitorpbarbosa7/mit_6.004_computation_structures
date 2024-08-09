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
	
	
	// to get the opcode we must?
	// - sub 4 within the xp (would be next instruction after illegal instruction)
	ADDC(XP, -4, R3)
	// - load the value of the opcode (correspond to ldb or stb) into some register? corresponding to that register
	LD(R3, 0, R3)
	// take the higher order bits to determine if it is ldb or stb?
	SHRC(R3, 26, R3)
	// ldb 010000 (26) -- stb 010001 (17)
	CMPEQC(R3, 17, R8)
	BEQ(R8, STB)
	
	CMPEQC(R3, 16, R8)
	BNE(R8, exit_illegal)
// LDB(Ra, literal, Rc)
// LDB(R4, R5, R6)	
LDB:
	
	
	
	
STB:
	
	

exit_illegal:

	
exit:	
	MOVE(R6, R0)
	
	
	
	
	POP(R3)
	MOVE(BP, SP)
	POP(BP)
	POP(LP)
	JMP(LP)
	


	
	
	
	


STB:





	
	
	
	
	

	
	
	
	
	
   ... your assembly language code here ...
