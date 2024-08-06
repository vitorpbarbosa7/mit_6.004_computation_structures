https://www.geeksforgeeks.org/what-is-reentrant-kernel/

A disc read is an example of this. When a user program requests a disc read, the scheduler will delegate the CPU to another process (kernel thread) until the disc controller issues an interrupt indicating that the data is accessible and our thread can be resumed. This process can still access I/O, such as user input, which requires kernel functions. The system remains responsive, and the amount of CPU time wasted as a result of IO delays is reduced. The original function (whatever requested data) would be blocked in a non-reentrant kernel until the disc read was completed.

If a computer program or routine can be safely called again before its previous invocation has been completed, it is said to be reentrant (i.e it can be safely executed concurrently).
