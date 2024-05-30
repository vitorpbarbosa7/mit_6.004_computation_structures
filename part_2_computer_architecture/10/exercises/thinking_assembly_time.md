it is a bit tricky to imagine that in assembly time the 3*4+5 won't take more time than just pass directly (from user) the 17, because it will have to perform a calculation anyway  ? 


I understand your concern. It might seem counterintuitive that performing a computation like 3*4+5 during assembly time wouldn't take more time than simply using the constant 17 directly. Let me explain how this works:

Efficient Arithmetic Operations: Assembler software is specifically designed to handle basic arithmetic operations efficiently during the assembly process. These operations are typically optimized and don't involve the same level of overhead as executing similar operations at runtime on a CPU.

Single Pass Processing: Assemblers typically perform a single pass through the assembly code, evaluating expressions and generating machine code as they go. This process is optimized for speed and efficiency, and modern assemblers are quite adept at performing these calculations quickly.

Constant Folding: During assembly, constant expressions like 3*4+5 are evaluated through a process called constant folding. This involves simplifying the expression into a single constant value (17 in this case) without the need for executing complex instructions.

Minimal Overhead: While there is indeed some overhead involved in performing arithmetic computations during assembly time, it's typically minimal compared to the overhead of executing similar computations at runtime on a CPU. Assemblers are optimized for these kinds of tasks and aim to minimize any unnecessary processing.

In summary, while there is some computational overhead involved in evaluating expressions during assembly time, modern assemblers are designed to handle these tasks efficiently. The benefits of optimizing the resulting machine code and reducing runtime overhead outweigh the minor costs of performing these computations during assembly.







