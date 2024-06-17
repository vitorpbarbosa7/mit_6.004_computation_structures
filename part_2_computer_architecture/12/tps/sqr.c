#include <stdio.h>

int nthodd(int n) { 
    int tmp = 0;
    if (n == 0) return 0;
    tmp = n + n - 1;
    printf("%d\n  : ", tmp);
    return tmp;
}

int sqr(int j) { 
    int s = 0;
    int k = j;
    // to sum the number as many times as wished
    while (k != 0) {
        s = s + nthodd(k);
        k = k - 1;
    }
    return s;
}

int main() {
    int number = 4;
    int result = 0;

    result = sqr(number);

    printf("%d\n", result);

    return 0;
}
