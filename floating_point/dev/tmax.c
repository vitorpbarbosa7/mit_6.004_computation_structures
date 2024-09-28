#include <stdio.h>

int isTmax(int x){
  int res;
  int Tmin;
  Tmin = x + 1;

  res = !(~Tmin ^ x);
  return res;
}

int main(){
  int x = 0x7FFFFFFF;
  int res;
  res = isTmax(x);
  printf("%d", res);
}

