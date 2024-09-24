#include <stdio.h>
#include <stdint.h>

// Function to print binary representation of an integer
void print_binary(uint32_t n) {
    for (int i = 31; i >= 0; i--) {
        printf("%d", (n >> i) & 1);  // Extract and print each bit
        if (i % 4 == 0) printf(" "); // Add space for readability every 4 bits
    }
    printf("\n");
}

// Function to print the binary representation of a float
void print_float_binary(float f) {
    // Treat the float as a 32-bit integer to extract its bits
    uint32_t bits;
    // Use pointer casting to reinterpret the float's binary representation
    // as an unsigned 32-bit integer
    bits = *(uint32_t*)&f;

    printf("Float value: %f\n", f);
    printf("Binary representation: ");
    print_binary(bits);
}

int main() {
    float number = 3.14;
    float number2 = 1e10;
    print_float_binary(number);
    print_float_binary(number2);

    return 0;
}

