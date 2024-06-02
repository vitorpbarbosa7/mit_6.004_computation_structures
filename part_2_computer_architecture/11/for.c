#include <stdio.h>

int main() {
    int sum;
    long a[5]; 
    int i;

    a[0] = 1;
    a[1] = 2;
    a[2] = 3;
    a[3] = 4;
    a[4] = 5;

    sum = 0;
    
    /*
    for (i=0; i<5; i =i+1) {
        sum = sum + a[i];
    }
    */
    
    i = 0; 
    while (i<5) {
        sum = sum + a[i];
        i = i + 1;
    }

    printf("sum = %d", sum);
}



