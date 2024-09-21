In C, `&&`, `||`, and `!` are **logical operators**, whereas `&`, `|`, `^`, and `~` are **bitwise operators**. They operate at different levels and have different purposes.

### Logical Operators:
1. **`&&`** (Logical AND): 
   - Used to evaluate **conditions**.
   - Returns true (`1`) if **both** conditions are true, otherwise returns false (`0`).
   - Short-circuiting: If the first condition is false, the second one is not evaluated.

   Example:
   ```c
   if (a && b) {  // Both a and b must be non-zero (true).
       // Do something.
   }
   ```

2. **`||`** (Logical OR):
   - Returns true (`1`) if **either** of the conditions is true, otherwise false (`0`).
   - Short-circuiting: If the first condition is true, the second one is not evaluated.

   Example:
   ```c
   if (a || b) {  // Either a or b (or both) must be non-zero (true).
       // Do something.
   }
   ```

3. **`!`** (Logical NOT):
   - Returns true (`1`) if the condition is false (`0`), and returns false (`0`) if the condition is true (non-zero).

   Example:
   ```c
   if (!a) {  // Executes if a is 0 (false).
       // Do something.
   }
   ```

### Bitwise Operators:
1. **`&`** (Bitwise AND): 
   - Operates on **each bit** of the operands.
   - Returns `1` only if both bits are `1`; otherwise, returns `0`.

   Example:
   ```c
   int result = a & b;  // ANDs each bit of a and b.
   ```

2. **`|`** (Bitwise OR):
   - Operates on **each bit** of the operands.
   - Returns `1` if **either** bit is `1`; otherwise, returns `0`.

   Example:
   ```c
   int result = a | b;  // ORs each bit of a and b.
   ```

3. **`^`** (Bitwise XOR): 
   - Operates on **each bit** of the operands.
   - Returns `1` if the bits are **different**, `0` if they are the same.

   Example:
   ```c
   int result = a ^ b;  // XORs each bit of a and b.
   ```

4. **`~`** (Bitwise NOT):
   - Flips all the bits of the operand (1 becomes 0, and 0 becomes 1).
   
   Example:
   ```c
   int result = ~a;  // Inverts all the bits of a.
   ```

### Summary:
- **Logical operators** (`&&`, `||`, `!`) work at the level of entire expressions and are used to evaluate conditions.
- **Bitwise operators** (`&`, `|`, `^`, `~`) work at the **bit level** of integers and manipulate individual bits of numbers.
  
### Example:
```c
#include <stdio.h>

int main() {
    int a = 5;    // 0101 in binary
    int b = 3;    // 0011 in binary

    // Logical AND (returns true if both conditions are true)
    if (a && b) {
        printf("Logical AND: a && b is true\n");
    }

    // Bitwise AND (operates on each bit of the integers)
    int bitwise_and = a & b;  // 0101 & 0011 = 0001 (1 in decimal)
    printf("Bitwise AND: a & b = %d\n", bitwise_and);

    // Logical OR (returns true if either condition is true)
    if (a || b) {
        printf("Logical OR: a || b is true\n");
    }

    // Bitwise OR (operates on each bit of the integers)
    int bitwise_or = a | b;  // 0101 | 0011 = 0111 (7 in decimal)
    printf("Bitwise OR: a | b = %d\n", bitwise_or);

    // Logical NOT
    if (!0) {
        printf("Logical NOT: !0 is true\n");
    }

    // Bitwise NOT
    int bitwise_not = ~a;  // ~0101 = 1010 (in a 32-bit system, this is interpreted as a large negative number)
    printf("Bitwise NOT: ~a = %d\n", bitwise_not);

    return 0;
}
```

This program demonstrates the difference between logical and bitwise operators.
