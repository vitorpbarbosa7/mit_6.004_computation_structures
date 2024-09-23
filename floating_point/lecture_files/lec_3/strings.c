#include <stdio.h>

int main() {
    // Declare a string (array of characters)
    char s[6] = "18213";  // This is the string we want to store, 6th character is '\0' (null terminator)

    // Print out each character and its ASCII value in hexadecimal
    for (int i = 0; i < 6; i++) {
        printf("Character: %c, ASCII (hex): 0x%x\n", s[i], s[i]);
    }

    return 0;
}
