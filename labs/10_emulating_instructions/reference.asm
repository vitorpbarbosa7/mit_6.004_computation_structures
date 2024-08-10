.include "beta.uasm"
.include "checkoff.uasm"

regs:
  RESERVE(32)                // Array used to store register contents

UI: 
  save_all_regs(regs)

  LD(xp,-4,r0)                    // Load the illegal instruction
  extract_field(r0,31,26,r1)      // Extract opcode, bits 31:26

  CMPEQC(r1,0x10,r2)              // Is it LDB? (Opcode 010000)
  BT(r2, ldb_handler)             // If yes, handle LDB

  CMPEQC(r1,0x11,r2)              // Is it STB? (Opcode 010001)
  BT(r2, stb_handler)             // If yes, handle STB

  // If it's not LDB or STB, branch to _IllegalInstruction
  restore_all_regs(regs)
  BR(_IllegalInstruction)

ldb_handler:
  extract_field(r0,20,16,r3)      // Extract Ra
  extract_field(r0,15,0,r4)       // Extract literal
  ADDC(r31, 0, r5)                // Clear Rc (r5 will be used for Rc)

  ADD(r3, r4, r6)                 // EA = Reg[Ra] + SEXT(literal)
  LD(r6, 0, r7)                   // Load memory word at EA into MDATA (r7)

  extract_field(r6,1,0,r8)        // Get the lowest two bits of EA

  // Now, based on the lowest two bits, extract the corresponding byte
  CMPEQC(r8, 0, r9)
  ANDC(r7, 0xFF, r10)             // Extract the byte if EA[1:0] = 00
  BNE(r9, next_check)
  OR(r10, r5, r5)                 // Store byte in Rc (r5)
  BR(set_reg)

next_check:
  CMPEQC(r8, 1, r9)
  SRLC(r7, 8, r10)                // Extract the byte if EA[1:0] = 01
  ANDC(r10, 0xFF, r10)
  BNE(r9, final_check)
  OR(r10, r5, r5)
  BR(set_reg)

final_check:
  SRLC(r7, 16, r10)               // Extract the byte if EA[1:0] = 10
  ANDC(r10, 0xFF, r10)
  OR(r10, r5, r5)

set_reg:
  restore_all_regs(regs)
  OR(r5, r5, r1)                  // Set Rc to the loaded byte
  JMP(xp)

stb_handler:
  // Similar to ldb_handler, but you insert a byte into MDATA and store it back to memory
  extract_field(r0,20,16,r3)      // Extract Ra
  extract_field(r0,15,0,r4)       // Extract literal
  ADD(r3, r4, r6)                 // EA = Reg[Ra] + SEXT(literal)

  LD(r6, 0, r7)                   // Load memory word at EA into MDATA (r7)
  extract_field(r0,25,21,r8)      // Extract Rc
  ANDC(r8, 0xFF, r8)              // Extract byte from Rc

  extract_field(r6,1,0,r9)        // Get the lowest two bits of EA
  CMPEQC(r9, 0, r10)
  BNE(r10, next_check_stb)
  OR(r8, r7, r7)                  // Insert byte if EA[1:0] = 00
  BR(store_back)

next_check_stb:
  CMPEQC(r9, 1, r10)
  SLLC(r8, 8, r8)                 // Shift byte to the correct position if EA[1:0] = 01
  BNE(r10, final_check_stb)
  OR(r8, r7, r7)
  BR(store_back)

final_check_stb:
  SLLC(r8, 16, r8)                // Shift byte to the correct position if EA[1:0] = 10
  OR(r8, r7, r7)

store_back:
  ST(r7, 0, r6)                   // Store MDATA back to memory
  restore_all_regs(regs)
  JMP(xp)

_IllegalInstruction:
  HALT()
