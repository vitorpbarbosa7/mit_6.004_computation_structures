### Question:
so the seg_base for which process will be different right?

each process, like the 0 and 1 will have virtual address starting at 0x0 or 0x4, they can have different seg_bounds sizes, wchih will determine the seg_base of next, that is, the real location from which we have to shift?

give example of two process with their virtual, seg_base and seg_bounds, and also their real physical addresses 

Yes, each process will have its own `SEG_BASE` and `SEG_BOUNDS` values, which define its virtual address space and how that space is mapped to physical memory.

### Example with Two Processes

Let's consider two processes, Process 0 and Process 1. Both processes have their own virtual address space starting from `0x0`, but they are mapped to different regions of physical memory.

#### Process 0
- **SEG_BASE**: `0x1000` (The base physical address where Process 0's memory starts)
- **SEG_BOUNDS**: `0x200` (Process 0's memory space size)

#### Process 1
- **SEG_BASE**: `0x3000` (The base physical address where Process 1's memory starts)
- **SEG_BOUNDS**: `0x100` (Process 1's memory space size)

### Address Mapping

#### **Process 0**

- **Virtual Address (VA)**: `0x0`
  - **Physical Address (PA)**: `SEG_BASE + VA = 0x1000 + 0x0 = 0x1000`
  
- **Virtual Address (VA)**: `0x4`
  - **Physical Address (PA)**: `SEG_BASE + VA = 0x1000 + 0x4 = 0x1004`
  
- **Virtual Address (VA)**: `0x1FF` (Just before hitting the boundary)
  - **Physical Address (PA)**: `SEG_BASE + VA = 0x1000 + 0x1FF = 0x11FF`

- **Virtual Address (VA)**: `0x200` (This would cause a segmentation fault as it equals SEG_BOUNDS)
  - **Physical Address (PA)**: **Segmentation Fault** (Address exceeds `SEG_BOUNDS`)

#### **Process 1**

- **Virtual Address (VA)**: `0x0`
  - **Physical Address (PA)**: `SEG_BASE + VA = 0x3000 + 0x0 = 0x3000`
  
- **Virtual Address (VA)**: `0x4`
  - **Physical Address (PA)**: `SEG_BASE + VA = 0x3000 + 0x4 = 0x3004`
  
- **Virtual Address (VA)**: `0xFF` (Just before hitting the boundary)
  - **Physical Address (PA)**: `SEG_BASE + VA = 0x3000 + 0xFF = 0x30FF`

- **Virtual Address (VA)**: `0x100` (This would cause a segmentation fault as it equals SEG_BOUNDS)
  - **Physical Address (PA)**: **Segmentation Fault** (Address exceeds `SEG_BOUNDS`)

### Summary

- **Process 0** has a larger virtual address space (`0x200` bytes) mapped starting at physical address `0x1000`.
- **Process 1** has a smaller virtual address space (`0x100` bytes) mapped starting at physical address `0x3000`.
- Both processes start their virtual addresses at `0x0`, but they map to different regions of physical memory.
- **Segmentation faults** occur if a process tries to access memory beyond its `SEG_BOUNDS`.

This example shows how two processes can have the same virtual addresses but different physical addresses based on their `SEG_BASE` and `SEG_BOUNDS`.