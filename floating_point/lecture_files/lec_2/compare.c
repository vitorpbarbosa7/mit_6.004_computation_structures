#include <stdio.h>
#include <stdbool.h>

int main(){
  short tx = -1;
  unsigned short ux = 0;
  bool comp;

  comp = tx < ux;

  printf("%d\n", comp); 

}
