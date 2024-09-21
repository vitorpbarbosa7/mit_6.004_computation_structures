#include <stdio.h>

int main() {
    // Initialize the variables
    unsigned char a = 0x41;  // 0x41 is 01000001 in binary
    unsigned char b = 0x00;
    unsigned char c = 0x69;  // 0x69 is 01101001 in binary
    unsigned char d = 0x55;  // 0x55 is 01010101 in binary

    // Perform the bitwise operations
    unsigned char result1 = ~a;  // Bitwise NOT of 0x41
    unsigned char result2 = ~b;  // Bitwise NOT of 0x00
    unsigned char result3 = c & d;  // Bitwise AND of 0x69 and 0x55
    unsigned char result4 = c | d;  // Bitwise OR of 0x69 and 0x55

    // Print the results in hexadecimal
    printf("~0x41 = 0x%X\n", result1);  // Should print 0xBE
    printf("~0x00 = 0x%X\n", result2);  // Should print 0xFF
    printf("0x69 & 0x55 = 0x%X\n", result3);  // Should print 0x41
    printf("0x69 | 0x55 = 0x%X\n", result4);  // Should print 0x7D

    return 0;
}

