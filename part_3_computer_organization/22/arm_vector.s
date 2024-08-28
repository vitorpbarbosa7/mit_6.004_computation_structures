.section .data
    array1: .word 1, 2, 3, 4
    array2: .word 5, 6, 7, 8
    result: .space 16

.section .text
    .global _start

_start:
    // Load array1 and array2 into SIMD registers
    LDR q0, [array1]
    LDR q1, [array2]

    // Add the vectors and store the result in q2
    ADD v2.4s, v0.4s, v1.4s

    // Store the result back to memory
    STR q2, [result]

    // Exit program
    MOV x8, 93         // Exit syscall number
    MOV x0, 0          // Exit code 0
    SVC 0              // Make syscall

