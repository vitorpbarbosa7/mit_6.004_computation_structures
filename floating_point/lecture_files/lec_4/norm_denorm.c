#include <stdio.h>
#include <float.h>

int main() {
    printf("Smallest normalized float: %e\n", FLT_MIN);
    printf("Smallest denormalized float: %e\n", FLT_TRUE_MIN);  // FLT_TRUE_MIN gives the smallest denormalized positive float.
    return 0;
}

