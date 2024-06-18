#include <stdio.h>

int f(int x, int y){
    int a = (x + y) >> 1;
    if (a==0) return y;
    else return a + f(y, x - a);
}

int main() {
    int x, y, result;
    
    x = 7;
    y = 6;

    result = f(x = x, y = y);
    printf("%d /n", result);
}