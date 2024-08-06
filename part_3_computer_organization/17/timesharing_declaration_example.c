#include <stdio.h>

// Define struct Context (assuming it's defined somewhere)
struct Context {
    // Context-specific members
    int exampleField; // Example field
};

// Define struct Mstate
struct Mstate {
    int Regs[31];
};

// Define struct PCB
struct PCB {
    struct Mstate State;    // Processor State
    struct Context PageMap; // MMU state for proc
    int DPYNum;             // Console number (and other I/O state)
};

#define N 5 // Define the size of the ProcTbl array

int main() {
    struct PCB ProcTbl[N]; // Declare an array of struct PCB

    // Initialize the ProcTbl array
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < 31; j++) {
            ProcTbl[i].State.Regs[j] = j + i; // Example initialization
        }
        ProcTbl[i].DPYNum = i; // Example initialization
        ProcTbl[i].PageMap.exampleField = i * 10; // Example initialization
    }

    // Print the values in the ProcTbl array to verify initialization
    for (int i = 0; i < N; i++) {
        printf("Process %d:\n", i);
        for (int j = 0; j < 31; j++) {
            printf("  Regs[%d] = %d\n", j, ProcTbl[i].State.Regs[j]);
        }
        printf("  DPYNum = %d\n", ProcTbl[i].DPYNum);
        printf("  PageMap.exampleField = %d\n", ProcTbl[i].PageMap.exampleField);
    }

    return 0;
}

