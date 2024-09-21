#include <stdio.h>

int main() {
    unsigned int x = 0x12345678;  // Example 4-byte integer
    unsigned char *c = (unsigned char*)&x;

    printf("Memory addresses and their values:\n");

    for (int i = 0; i < sizeof(x); i++) {
        printf("Address: %p, Value: 0x%x\n", (c + i), *(c + i));
    }

    if (*c == 0x78) {
        printf("\nLittle Endian\n");
    } else {
        printf("\nBig Endian\n");
    }

    return 0;
}
