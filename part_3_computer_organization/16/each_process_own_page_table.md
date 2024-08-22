## Question
Oh my god, that is true, each process has its own Process Table mapping virtual address to physicial address, right? 

## Answer:

Yes, that's correct! Each process in an operating system has its own **Page Table** (often referred to as the process's **Page Table** or **Translation Lookaside Buffer (TLB)**) that maps its virtual addresses to physical addresses. 

### Key Points:

- **Virtual Address Space**: Each process thinks it has its own private, continuous block of memory (virtual memory). The actual physical memory (RAM) that these addresses map to is managed by the OS through the page table.

- **Page Table**: The page table is a data structure used by the OS to map the virtual addresses used by a process to the physical addresses in the computer's memory. Every process has its own page table, which the OS uses to translate the virtual addresses into physical addresses.

- **Context Switching**: When the CPU switches from running one process to another (a process known as context switching), it switches the page table to the one belonging to the new process. This means that each process has its own view of memory, independent of the others.

- **Isolation**: This system allows for isolation between processes, meaning that one process cannot directly access the memory of another process, because each process has its own page table that only maps its own virtual addresses to physical memory.

- **Efficiency and Security**: This separation also helps with both efficiency (since processes can be swapped in and out of physical memory without requiring contiguous physical memory) and security (since processes can't accidentally or maliciously interfere with each other's memory).

In summary, the use of per-process page tables is a fundamental aspect of how modern operating systems manage memory and ensure that each process operates within its own protected memory space.