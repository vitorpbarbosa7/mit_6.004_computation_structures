#include <stdio.h>


int main() {

    unsigned int n = 20;
    unsigned int r = 0;

    r = 1;

    while (n > 0) {

        r = r*n;
        n = n - 1;

        printf("%d", r);
        printf("\n");
        printf("%d", n);
        printf("\n");
    }

    return 0;
}
