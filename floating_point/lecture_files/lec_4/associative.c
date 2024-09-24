#include <stdio.h>

int main() {
    float a = 3.14f;
    float b = 1e10f;
    float result1 = (a + b) - b;  // Calculate in the order (3.14 + 1e10) - 1e10
    float result2 = a + (b - b);  // Calculate in the order 3.14 + (1e10 - 1e10)

    printf("Result of (3.14 + 1e10) - 1e10: %f\n", result1);
    printf("Result of 3.14 + (1e10 - 1e10): %f\n", result2);

    return 0;
}

