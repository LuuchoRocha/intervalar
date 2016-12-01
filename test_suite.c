#include <stdio.h>
#include "interval.h"

int main( ) {
  Interval x, y, add, sub;

  x.lower = 1;
  x.upper = 3;

  y.lower = 4;
  y.upper = 6;

  add = add_asm(x, y);
  sub = sub_asm(x, y);

  printf("X: [%d;%d]\n", x.lower, x.upper);
  printf("Y: [%d;%d]\n\n", y.lower, y.upper);
  printf("ADD(x, y) = [%d;%d]\n", add.lower, add.upper);
  printf("SUB(x, y) = [%d;%d]\n", sub.lower, sub.upper);
  printf("MIN(x.lower, x.upper) = [%d]\n", min_asm(x.lower, x.upper));
  printf("MAX(x.lower, x.upper) = [%d]\n", max_asm(x.lower, x.upper));

  return 0;
}
