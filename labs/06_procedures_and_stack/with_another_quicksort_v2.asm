
////////////////////////////////////////////////////////////////////////////////
// Lab 6
////////////////////////////////////////////////////////////////////////////////

// Include the checkoff program:
.include "checkoff.uasm"

// Leave the following as zero to run ALL the test cases, and get your solution
//   validated if all pass.  If you have trouble with test case N, set it to N
//   to run JUST that test case (for easier debugging):
TestCase:       LONG(0)

// Quicksort-in-place code.  We include the C/Python version here as a comment;
// you can use this as a model for your Beta assembly version:

//def partition(array,left,right):
//    # choose middle element of array as pivot
//    pivotIndex = (left+right) >> 1;
//    pivotValue = array[pivotIndex]
//
//    # swap array[right] and array[pivotIndex]
//    # note that we already store array[pivotIndex] in pivotValue
//    array[pivotIndex] = array[right]
//
//    # elements <= the pivot are moved to the left (smaller indices)
//    storeIndex = left
//    for i in xrange(left,right):  # don't include array[right]
//        temp = array[i]
//        if temp <= pivotValue:
//            array[i] = array[storeIndex]
//            array[storeIndex] = temp
//            storeIndex += 1
//
//    # move pivot to its final place
//    array[right] = array[storeIndex]
//    array[storeIndex] = pivotValue;
//    return storeIndex;

p_array=R2          
p_left=R3
p_right=R4
p_pivotIndex=R5     
p_pivotValue=R6
p_storeIndex=R7
	
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
		PUSH(R22) // storeIndex
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
		MOVE(R2, R22) // storeIndex = left
loop:	ADDC(R9, 1, R9)
		SHLC(R9, 2, R12)// i multiplied by 4
		ADD(R1, R12, R13) // address of the array[i]
		
		LD(R13, 0, R13) // temp value in the register
		
		CMPLE(R13, R8, R14)
		BEQ(R14, floop)
		
		SHLC(R22, 2, R15) //StoreIndex multiplied by 4
		ADD(R1, R15, R16) // correct address for array[storeIndex]
		LD(R16, 0, R16) // element array[storeIndex]

		ADD(R1, R12, R12)
		ST(R16, 0, R12) // store the contents of array[storeIndex] into array[i]
		
		ADD(R1, R15, R15)
		ST(R13, 0, R15) // store the contents of temp into array[storeIndex]
		
		ADDC(R22, 1, R22) // increment the storeIndex (not multiplied by four)

		
		// if the i == right, then we stop, continue the code and not go
		//back the loop
		
// 		.breakpoint
floop:	SUBC(R3, 1, R21)
		CMPEQ(R9, R21, R10) 

     	BEQ(R10, loop)
		
		// move pivot to its final place
		SHLC(R22, 2, R15) // storeIndex multiplied by 4
		ADD(R1, R15, R15) // Address of array[storeIndex]
		LD(R15, 0, R16) // element array[storeIndex]
		
		SHLC(R3, 2, R17) // right multiplied by 4
		ADD(R1, R17, R17) // right address
		ST(R16, 0, R17) // array[right] = array[storeIndex]
		
		ST(R8, 0, R15) // array[storeIndex] = pivotValue
		
		// Exit Sequence -------------------
		
		
		MOVE(R22, R0)
		POP(R20)
		POP(R18)
		
		POP(R16)
		POP(R15)
		POP(R14)
		POP(R22)
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
// partition:
//         PUSH(LP)
//         PUSH(BP)
//         MOVE(SP, BP)

// // Fill in your code here...
// // start my code
//         PUSH(R1)
//         PUSH(R2)
//         PUSH(R3)
//         PUSH(R4)
//         PUSH(R5)
//         PUSH(R6)
//         PUSH(R7)
//         PUSH(R8)
//         PUSH(R9)

//         // arguments
//         LD(BP, -12, p_array)  
//         LD(BP, -16, p_left)  
//         LD(BP, -20, p_right)
		
//         // locals
//         ADD(p_left, p_right, R1)
//         SHRC(R1, 1, p_pivotIndex)  // p_pivotIndex
//         SHLC(p_pivotIndex, 2, R22)  
//         ADD(p_array, R22, R22)       // address of array[p_pivotIndex]
//         LD(R22, 0, p_pivotValue)    // pivotValue
        
//         // array[pivotIndex] = array[right]
//         SHLC(p_right, 2, R1)
//         ADD(p_array, R1, R1) 
//         LD(R1, 0, R8)              // array[p_right]
//         SHLC(p_pivotIndex, 2, R22)  
//         ADD(p_array, R22, R22)
//         ST(R8, 0, R22)  

//         // storeIndex = left
//         MOVE(p_left, p_storeIndex)
//         MOVE(p_left, R22)           // i = R22
// loop:
//         CMPLT(R22, p_right, R1)
//         BF(R1, rtn_q)
//         SHLC(R22, 2, R1)
//         ADD(p_array, R1, R1)       // array[i]
//         LD(R1, 0, R8)              // temp = R8
//         CMPLE(R8, p_pivotValue, R1)
//         BF(R1, loop1)
//         SHLC(p_storeIndex, 2, R1)  
//         ADD(p_array, R1, R1)       
//         LD(R1, 0, R9)              // array[storeIndex]
//         SHLC(R22, 2, R1)
//         ADD(p_array, R1, R1)    
//         ST(R9, 0, R1)              // array[i] = array[storeIndex]
//         SHLC(p_storeIndex, 2, R1)  
//         ADD(p_array, R1, R1)  
//         ST(R8, 0, R1)              // array[storeIndex] = temp
//         ADDC(p_storeIndex, 1, p_storeIndex) // storeIndex += 1
// loop1:  
//         ADDC(R22, 1, R22)
//         BF(R31, loop)

//         // move pivot to its final place
// rtn_q:    
// 		SHLC(p_storeIndex, 2, R1)
//         ADD(p_array, R1, R1) 
//         LD(R1, 0, R8)              // array[p_storeIndex]
//         SHLC(p_right, 2, R9)
//         ADD(p_array, R9, R9)
//         ST(R8, 0, R9)              // array[right] = array[storeIndex]
//         ST(p_pivotValue, 0, R1)    // array[storeIndex] = pivotValue
//         MOVE(p_storeIndex, R22)
// 		POP(R9)
//         POP(R8)
//         POP(R7)
//         POP(R6)
//         POP(R5)
//         POP(R4)
//         POP(R3)
//         POP(R2)
//         POP(R1)
// // end my code
//         MOVE(BP, SP)
//         POP(BP)
//         POP(LP)
//         JMP(LP)

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

// Fill in your code here...
// start my code
		PUSH(R1) 
        PUSH(R2) 
        PUSH(R3) 
        PUSH(R4)

        LD(BP, -12, p_array)  // R1 = address of array[0]
        LD(BP, -16, R3)  // R3 = left
        LD(BP, -20, R4)  // R4 = right
        CMPLT(R3, R4, R0)
        BF(R0, rtn)

        PUSH(R4)
        PUSH(R3)
        PUSH(p_array) 
        BR(partition, LP) 
        DEALLOCATE(3)
        MOVE(R0, R1)   // R1 = pivotIndex
		
        // quicksort(array,left,pivotIndex-1)
        SUBC(R1, 1, R4)  // pivotIndex-1
        PUSH(R4)
        PUSH(R3)
        PUSH(p_array) 
        BR(quicksort, LP) 
        DEALLOCATE(3)

        // quicksort(array,pivotIndex+1,right)
        LD(BP, -20, R4)  
        ADDC(R1, 1, R3)
        PUSH(R4)
        PUSH(R3)
        PUSH(p_array) 
        BR(quicksort, LP) 
        DEALLOCATE(3)

rtn:
        POP(R4)
        POP(R3)
        POP(R2)
        POP(R1)
// end my code

        MOVE(BP, SP)
        POP(BP)
        POP(LP)
        JMP(LP)

// Allocate a stack: SP is initialized by checkoff code.
StackBasePtr:
        LONG(StackArea)

.unprotect

StackArea:
        STORAGE(1000)