#include <stdio.h>
#include "show_bytes.c"

int main(){

    int x = 0x1234;
    short y = 0x12;

    // to create the pointer type, you must cast it 
    pointer pointer_x = (pointer)&x;
    pointer pointer_y = (pointer)&y;

    printf("bytes of this integer %d\n", x);
    show_bytes(pointer_x, sizeof(x));

    printf("bytes of this short %d\n", y);
    show_bytes(pointer_y, sizeof(y));

}
