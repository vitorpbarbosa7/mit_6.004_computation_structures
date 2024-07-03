


// alufn[5:0] // D[17:12]
// asel, bsel // D[11], D[10]
// moe, mwr // D[9], D[8]
// pcsel[2:0] // D[7:5]
// ra2sel // D[4]
// wasel, wdsel[1:0], werf // D[3], D[2:1], D[0]

// first row with 8 instructions, not valid implemented instructions
0b??????_??_?0_011_?_1001  // 0b000000
0b??????_??_?0_011_?_1001  // 0b000001
0b??????_??_?0_011_?_1001  // 0b000010
0b??????_??_?0_011_?_1001  // 0b000011
0b??????_??_?0_011_?_1001  // 0b000100
0b??????_??_?0_011_?_1001  // 0b000101
0b??????_??_?0_011_?_1001  // 0b000110
0b??????_??_?0_011_?_1001  // 0b000111

// second row with 8 instructions, not valid implemented instructions
0b??????_??_?0_011_?_1001  // 0b001000
0b??????_??_?0_011_?_1001  // 0b001001
0b??????_??_?0_011_?_1001  // 0b001010
0b??????_??_?0_011_?_1001  // 0b001011
0b??????_??_?0_011_?_1001  // 0b001100
0b??????_??_?0_011_?_1001  // 0b001101
0b??????_??_?0_011_?_1001  // 0b001110
0b??????_??_?0_011_?_1001  // 0b001111

// alufn[5:0]
// asel, bsel
// moe, mwr
// pcsel[2:0]
// ra2sel
// wasel, wdsel[1:0], werf
// second row with 8 instructions, not valid implemented instructions
0b??????_??_?0_011_?_1001  // 0b010000
0b??????_??_?0_011_?_1001  // 0b010001
0b??????_??_?0_011_?_1001  // 0b010010
0b??????_??_?0_011_?_1001  // 0b010011
0b??????_??_?0_011_?_1001  // 0b010100
0b??????_??_?0_011_?_1001  // 0b010101
0b??????_??_?0_011_?_1001  // 0b010110
0b??????_??_?0_011_?_1001  // 0b010111

// alufn[5:0]
// asel, bsel
// moe, mwr
// pcsel[2:0]
// ra2sel
// wasel, wdsel[1:0], werf
// fourth row with valid implemented opcodes
0b010000_01_10_000_?_0101  // 0b011000 LD
0b010000_01_01_000_1_0??0  // 0b011001 ST
0b??????_??_?0_011_?_1001  // 0b011010
0b??????_0?_?0_010_?_0001  // 0b011011 JMP
0b??????_0?_?0_001_?_0001  // 0b011100 BEQ
0b??????_0?_?0_001_?_0001  // 0b011101 BNE
// 0b??????_??_?0_011_?_1001  // 0b011101 BNE
0b??????_??_?0_011_?_1001  // 0b011110
// LDR needs to add the functionality to the ALU
0b101010_1?_10_000_?_0101  // 0b011111 LDR

// alufn[5:0]
// asel, bsel
// moe, mwr
// pcsel[2:0]
// ra2sel
// wasel, wdsel[1:0], werf
0b010000_00_?0_000_?_0011  // 0b100000 ADD
0b010001_00_?0_000_?_0011  // 0b100001 SUB
0b??????_??_?0_011_?_1001  // 0b100010 [normally MUL, but ILLOP for our ALU]
0b??????_??_?0_011_?_1001  // 0b100011 [normally DIV, but ILOOP for our ALU]
0b000011_00_?0_000_?_0011  // 0b100100 CMPEQ
0b000101_00_?0_000_?_0011  // 0b100101 CMPLT
0b000111_00_?0_000_?_0011  // 0b100110 CMPLE
0b??????_??_?0_011_?_1001  // 0b100111

0b101000_00_?0_000_?_0011  // 0b101000 AND
0b101110_00_?0_000_?_0011  // 0b101001 OR
0b100110_00_?0_000_?_0011  // 0b101010 XOR
0b101001_00_?0_000_?_0011  // 0b101011 XNOR
0b110000_00_?0_000_?_0011  // 0b101100 SHL
0b110001_00_?0_000_?_0011  // 0b101101 SHR
0b110011_00_?0_000_?_0011  // 0b101110 SRA
0b??????_??_?0_011_?_1001  // 0b101111

// alufn[5:0]
// asel, bsel
// moe, mwr
// pcsel[2:0]
// ra2sel
// wasel, wdsel[1:0], werf
0b010000_01_?0_000_0_0011  // 0b110000 ADDC
0b010001_01_?0_000_0_0011  // 0b110001 SUBC
0b??????_??_?0_011_?_1001  // 0b110010 [normally MULC, but ILLOP for our ALU]
0b??????_??_?0_011_?_1001  // 0b110011 [normally DIVC, but ILLOP for our ALU]
0b000011_01_?0_000_0_0011  // 0b110100 CMPEQC
0b000101_01_?0_000_0_0011  // 0b110101 CMPLTC
0b000111_01_?0_000_0_0011  // 0b110110 CMPLEC
0b??????_??_?0_011_?_1001  // 0b110111

0b101000_01_?0_000_0_0011  // 0b111000 ANDC
0b101110_01_?0_000_0_0011  // 0b111001 ORC
0b100110_01_?0_000_0_0011  // 0b111010 XORC
0b101001_01_?0_000_0_0011  // 0b111011 XNORC
0b110000_01_?0_000_0_0011  // 0b111100 SHLC
0b110001_01_?0_000_0_0011  // 0b111101 SHRC
0b110011_01_?0_000_0_0011  // 0b111110 SRAC
0b??????_??_?0_011_?_1001  // 0b111111