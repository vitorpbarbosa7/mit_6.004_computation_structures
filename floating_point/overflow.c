#pragma GCC push_options
#pragma GCC optimize ("O0")

#include <stdio.h>
#include <limits.h>  // For INT_MIN and INT_MAX

int main() {
    int x = INT_MIN / 2;  // A large negative number close to the lower limit

    printf("x = %d\n", x);
    printf("x * 2 = %d\n", x * 2);

    if (x < 0 && (x * 2) > 0) {
        printf("Overflow occurred! x < 0 but x * 2 > 0.\n");
    } else {
        printf("No overflow occurred.\n");
    }

    return 0;
}

#pragma GCC pop_options
