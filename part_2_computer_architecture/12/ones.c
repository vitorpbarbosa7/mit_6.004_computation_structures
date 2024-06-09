#include <stdio.h>

// procedure
int ones(int x) {
    int lowbit = x & 1; //low bit of x
    int rest = x >> 1; // shift other bits right
    if (x == 0) return 0;
    else return ones(rest) + lowbit;
    }

int main() {
    int count_ones;
    count_ones = ones(0b00110);
    printf("%d", count_ones);
    return 0;
}