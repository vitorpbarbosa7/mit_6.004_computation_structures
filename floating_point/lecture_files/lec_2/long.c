#include <stdio.h>

int main(){
    int tx = -5;
    unsigned int ux;

    printf("Signed value: %d\n", tx);

    ux = (unsigned int) tx;
    
    // bit pattern reinterpreted
    printf("Unsigned integer: %u\n", ux);

    }



