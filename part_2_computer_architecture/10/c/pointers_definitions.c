#include <stdio.h>

int main() {
    long a, *b, **c;

    // Assign some values to variables
    a = 10;
    b = &a;
    c = &b;

    // Print values and memory addresses
    printf("Contents of  'a': %ld, Address of 'a': %p\n", a, (void*)&a);
    printf("Contents of the location pointed to by '*b': %ld, Address stored in 'b': %p\n", *b, (void*)b);
    printf("Contents of the location pointed to by '**c': %ld, Address stored in '*c': %p\n", **c, (void*)*c);
    printf("Address of 'b' itself: %p\n", (void*)&b);
    printf("Address of 'c' itself: %p\n", (void*)&c);

    return 0;
}
