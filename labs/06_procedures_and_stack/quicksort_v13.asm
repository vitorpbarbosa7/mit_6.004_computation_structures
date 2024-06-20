.include "beta.uasm"

BR(STEP1)

// the array to be sorted
. = 0x0004
A: LONG(1) LONG(7) LONG(2) LONG(6) LONG(8) LONG(3) LONG(4)
ALEN = (. - 4)/4

. = 0x0040
STEP1:
	
	CMOVE(., BP)
	CMOVE(., SP)

	CMOVE(A, R1) // array
	CMOVE(0, R2) // left
	CMOVE(ALEN, R3)
	SUBC(R3, 1, R3)

	PUSH(R3) // right
	PUSH(R2) // left
	PUSH(R1) // array
	//BR(partition, LP)
	BR(quicksort, LP)
	DEALLOCATE(3)
	
	HALT()
	
// ---------------------------------------------------------------------

partition:
        // Entry sequence -------------------
        PUSH(LP) 
        PUSH(BP)
        MOVE(SP, BP)
			
		PUSH(R1) // To load array
		PUSH(R2) // To load left
		PUSH(R3) // To load right
		
		PUSH(R21) // right minus 1 for loop condition
		
		PUSH(R17) // right multiplied by 4
		PUSH(R19) // load contents of right address
		
		
		PUSH(R7) // index not multiplied
		PUSH(R4) // pivotIndex
		PUSH(R8) // pivotValue
		
		// loop variables
		PUSH(R9) // i from loop
		PUSH(R12) // i multiplied by 4
		PUSH(R13) // temp
		PUSH(R10) // result comparison from loop
		PUSH(R0) // storeIndex
		PUSH(R14) // compare if 
		PUSH(R15) // storeIndex multiplied by 4
		PUSH(R16) // element array[storeIndex]
		
		PUSH(R18) // get the array pivotIndex
		PUSH(R20) // load the contents of pivotIndex
		
		
		
		// Procedure call instructions implementation -------------------
		LD(BP, -12, R1) // array
		LD(BP, -16, R2) // left
		LD(BP, -20, R3) // right
		
		//pivotIndex = (left+right) >>1
		ADD(R2, R3, R7)
		SHRC(R7, 1, R7)
			
		// pivotValue = array[pivotIndex]
		// multiplied pivotIndex in R4
		SHLC(R7, 2, R4)
		// R8 will have the pivotValue
		ADD(R1, R4, R8)
		LD(R8,0,R8)
		
		ADD(R1, R4, R18) // array pivot Index address at R18
		SHLC(R3, 2, R17) // right multiplied by 4
		ADD(R1, R17, R17) // address of the right element in the array
		
		LD(R18, 0, R20) // contents of array[pivotIndex]
		LD(R17, 0, R19) // contents of array[right]
		
		ST(R20, 0, R17) // swap
		ST(R19, 0, R18) // swap
		
		MOVE(R2, R9) // R9 which the i from the loop is initialized as the left 
		SUBC(R9, 1, R9)
		MOVE(R2, R0) // storeIndex = left
loop:	ADDC(R9, 1, R9)
		SHLC(R9, 2, R12)// i multiplied by 4
		ADD(R1, R12, R13) // address of the array[i]
		LD(R13, R0, R13) // temp value in the register
		
		CMPLE(R13, R8, R14)
		BEQ(R14, floop)
		
		SHLC(R0, 2, R15) //StoreIndex multiplied by 4
		ADD(R1, R15, R16) // correct address for array[storeIndex]
		LD(R16, 0, R16) // element array[storeIndex]

		ADD(R1, R12, R12)
		ST(R16, 0, R12) // store the contents of array[storeIndex] into array[i]
		
		ADD(R1, R15, R15)
		ST(R13, 0, R15) // store the contents of temp into array[storeIndex]
		
		ADDC(R0, 1, R0) // increment the storeIndex (not multiplied by four)

		
		// if the i == right, then we stop, continue the code and not go
		//back the loop
		
		SUBC(R3, 1, R21)
floop:	CMPEQ(R9, R21, R10) 

     	BEQ(R10, loop)
		
		// move pivot to its final place
		SHLC(R0, 2, R15) // storeIndex multiplied by 4
		ADD(R1, R15, R15) // Address of array[storeIndex]
		LD(R15, R0, R16) // element array[storeIndex]
		
		SHLC(R3, 2, R17) // right multiplied by 4
		ADD(R1, R17, R17) // right address
		ST(R16, 0, R17) // array[right] = array[storeIndex]
		
		ST(R8, 0, R15) // array[storeIndex] = pivotValue
		
		// Exit Sequence -------------------
		
		POP(R20)
		POP(R18)
		
		POP(R16)
		POP(R15)
		POP(R14)
		POP(R0)
		POP(R10)
		POP(R13)
		POP(R12)
		POP(R9)
		
		POP(R8)
		POP(R4)
		POP(R7)
		
		POP(R19)
		POP(R17)
		
		POP(R21)
		
		POP(R3)
		POP(R2)
		POP(R1)

        MOVE(BP, SP)
        POP(BP)
        POP(LP)
        JMP(LP)		// ---------------------------------------------------------------------

//def quicksort(array, left, right):
//    if left < right:
//        pivotIndex = partition(array,left,right)
//        quicksort(array,left,pivotIndex-1)
//        quicksort(array,pivotIndex+1,right)

// quicksort(ArrayBase, left, right)
quicksort:
        PUSH(LP)
        PUSH(BP)
        MOVE(SP, BP)
		
		PUSH(R0)
		PUSH(R1)
		PUSH(R2)
		PUSH(R3)
		PUSH(R4)
		
		// PivotIndex -1 and +1
		PUSH(R5) // -1 
		PUSH(R6) // +1
		
		// TO HOLD R0 RETURN VALUE PIVOTINDEX FROM partition procedure call
		PUSH(R7)
		
		// Procedure call instructions implementation -------------------
		LD(BP, -12, R1) // array
		LD(BP, -16, R2) // left
		LD(BP, -20, R3) // right
		
		
		CMPLE(R2, R3, R4)
		BEQ(R4, exit_quicksort)
		
		// Call partition procedure
		PUSH(R3)
		PUSH(R2)
		PUSH(R1)
		.breakpoint
		BR(partition, LP)
		DEALLOCATE(3)
		
		// the R0 will hold the pivotIndex value
		
		// call the quicksort recursive two times 
		
		MOVE(R0, R7)
		SUBC(R7, 1, R5)
		
		PUSH(R5)
		PUSH(R2)
		PUSH(R1)
		BR(quicksort, LP)
		DEALLOCATE(3)
		
		MOVE(R0, R7)
		ADDC(R7, 1, R6)
		
		PUSH(R3)
		PUSH(R6)
		PUSH(R1)
		BR(quicksort, LP)
		DEALLOCATE(3)


// Exit Sequence ------------------------------------------------
exit_quicksort:
		
		POP(R7)
		POP(R6)
		POP(R5)
		POP(R4)
		POP(R3)
		POP(R2)
		POP(R1)
		POP(R0)

        MOVE(BP, SP)
        POP(BP)
        POP(LP)
        JMP(LP)