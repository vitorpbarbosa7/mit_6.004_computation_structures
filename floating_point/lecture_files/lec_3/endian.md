Let’s break down your questions one by one to clarify the concepts:

### 1. **What does `&x` do?**

- The `&` operator in C is the **address-of operator**. When you use `&x`, you are getting the **memory address** of the variable `x`, not its value.
- `x` is a 4-byte integer in this case, and `&x` gives you the starting address in memory where these 4 bytes are stored.

**Example:**
```c
unsigned int x = 0x12345678;
unsigned int *p = &x;  // Now p holds the memory address of x.
```
Here, `p` is a pointer to an unsigned integer, and it holds the memory address of `x`.

### 2. **Why is `(unsigned char*)` used?**

- The type of `&x` is `unsigned int*`, which is a pointer to a 4-byte integer (`x`). However, we want to break `x` down into individual bytes (each byte is 1 byte or 8 bits).
- **Casting to `(unsigned char*)`** changes the pointer type from `unsigned int*` (which points to a 4-byte block) to `unsigned char*` (which points to just 1 byte).
  - This way, when we access memory using `*(c + i)`, we are reading one byte at a time, starting from the lowest memory address.

**Example:**
```c
unsigned int x = 0x12345678;
unsigned char *c = (unsigned char*)&x;  // Now c points to the first byte of x.
```

### 3. **What would happen if `(unsigned char*)` was not used?**

- Without the cast `(unsigned char*)`, the pointer `c` would still be an `unsigned int*`, meaning it would point to 4 bytes (the full integer) instead of just 1 byte at a time.
- This would cause problems if you want to access the individual bytes of the integer, because pointer arithmetic with `unsigned int*` moves in **steps of 4 bytes**. So, `*(c + 1)` would access the next 4-byte block in memory, not the next byte.
  
**What happens without the cast:**
```c
unsigned int *p = &x;  // Pointer points to 4-byte chunks
printf("Address: %p, Value: %x\n", (p + 1), *(p + 1));  // Skips 4 bytes ahead
```
- The cast to `unsigned char*` ensures that pointer arithmetic operates at the byte level, i.e., `*(c + 1)` moves just 1 byte ahead, not 4.

### 4. **When `c` is a pointer, does it show the address, and when we use `*c`, does it show the value?**

- **Yes**, this is correct!

- **`c`**: As a pointer, `c` holds the **address** of the memory location it is pointing to.
  - If you print `c`, it will show the memory address.

  **Example:**
  ```c
  printf("Address: %p\n", c);  // This prints the address stored in c
  ```

- **`*c`**: The dereference operator (`*`) is used to **access the value** stored at the memory address pointed to by `c`.
  - If you print `*c`, it will show the value stored at that memory address.

  **Example:**
  ```c
  printf("Value: %x\n", *c);  // This prints the value stored at the address pointed to by c
  ```

### Example Clarification:

```c
#include <stdio.h>

int main() {
    unsigned int x = 0x12345678;  // x stores 0x12345678 (4 bytes)
    unsigned char *c = (unsigned char*)&x;  // c points to the first byte of x

    printf("Address of x: %p\n", (void*)&x);   // prints the address of x
    printf("First byte: %x\n", *c);           // prints the value of the first byte of x
    printf("Second byte: %x\n", *(c + 1));    // prints the value of the second byte
    printf("Third byte: %x\n", *(c + 2));     // prints the value of the third byte
    printf("Fourth byte: %x\n", *(c + 3));    // prints the value of the fourth byte

    return 0;
}
```

### Output (assuming little-endian system):

```
Address of x: 0x7ffee6f25a1c
First byte: 78
Second byte: 56
Third byte: 34
Fourth byte: 12
```

### Conclusion:
- `&x` gives you the **address** of `x`.
- `(unsigned char*)` is used to break down `x` into its component **bytes** by treating the memory as a series of 1-byte chunks.
- Without the cast, pointer arithmetic would not work correctly for byte-level access.
- When you print `c`, you get the **address**, and when you print `*c`, you get the **value** at that address.

I hope this clears up your confusion!
