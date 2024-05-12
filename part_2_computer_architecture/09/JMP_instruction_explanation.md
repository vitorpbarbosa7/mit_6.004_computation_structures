silvinahw (Staff)
8 years ago - marked as answer 8 years ago by silvinahw (Staff)

Vote for this post, there are currently 2 votes

Think of your program as a bunch of instructions at different addresses. Our program looks like this:

Addr     Instr
0x100   BEQ(R31,sqrt,R28)
0x104   Instr A1
0x108   Instr A2
...
0x678   BEQ(R31,sqrt,R28)
0x67C   Instr B1
0x680   Instr B2
...
In some other part of memory lives the sqrt procedure:

sqrt:      ....
           JMP(R28, R31)


You begin at address 0x100 with the first BEQ instruction, this instruction stores the next address (also known as the return address) into R28. In this case, the next address is 0x104 (address of instruction A1). So 0x104 is the return address. The BEQ causes you to branch to the instruction at label sqrt. The instructions at label sqrt are executed in order until you finally reach the JMP(R28, R31) instruction.

The JMP will make you jump back to the address that is stored in register R28. This address is 0x104. So after you executed the sqrt procedure the first time around, you jump back to address 0x104 and continue executing your program at Instr A1. (Note that you do not go back to the first BEQ instruction at address 0x100 because that instruction was already executed). Eventually you get down to address 0x678. Once again, we want to call our sqrt procedure, so we store the next address, this time 0x67C into R28, and branch to the sqrt code. We execute the sqrt code, and at the end of it we jump back to the location that is now stored in R28. Now the value of R28 is 0x67C. So after the second execution of the sqrt code, we jump back to our program at address 0x67C and continue execution with Instr B1.