struct Mstate { int Regs[31];} UserMState;

struct PCB { //Process Control Block
    struct MState State;    //Processor State
    struct Context PageMap; // MMu state for proc
    int DPYNum;             // Console number (and other I/O state)
} ProcTbl[N]; // one for each process

int Cur; // index of "Active" process


Scheduler() {
    ProcTbl[Cur].State = User;
    Cur = (Cur+1)%N;
    User = Proctbl[Cur].State;
    LoadUserContext(ProcTbl[Cur].PageMap);
}    

  
