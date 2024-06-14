#include <stdio.h>

int ffo(unsigned v, int b){
    if (v==0) return b;
    else return ffo(v>>1, b+1);
}

int main(){
    int result;
    result = ffo(3, 100);
    printf("%d", result);
}