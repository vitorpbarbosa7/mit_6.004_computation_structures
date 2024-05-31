#include <stdio.h>

int main() {
    int num1 = 5;
    int num2 = 7;
    int sum = num1 + num2;

    printf("The sum of %d and %d is %d\n", num1, num2, sum);

    return 0;
}

// clang -S -o asm convert_assembly.c