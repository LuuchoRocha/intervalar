#include <stdio.h>
#include "interval.h"

int main( ) {
  Interval16 x, y, add, sub, inf, sup;
  int16_t min, max;

  x.lower = 1;
  x.upper = 5;

  y.lower = 4;
  y.upper = 6;

  add = add_asm(x, y);
  sub = sub_asm(x, y);
  inf = inf_asm(x, y);
  sup = sup_asm(x, y);
  min = min_asm(x.lower, y.lower);
  max = max_asm(x.upper, y.upper);

  printf("X: [%d;%d]\n", x.lower, x.upper);
  printf("Y: [%d;%d]\n\n", y.lower, y.upper);
  printf("ADD(x, y) = [%d;%d]\n", add.lower, add.upper);
  printf("SUB(x, y) = [%d;%d]\n\n", sub.lower, sub.upper);
  printf("MIN(%d, %d) = %d\n", x.lower, y.lower, min);
  printf("MAX(%d, %d) = %d\n\n", x.upper, y.upper, max);
  printf("INF(x, y) = [%d;%d]\n", inf.lower, inf.upper);
  printf("SUP(x, y) = [%d;%d]\n", sup.lower, sup.upper);

  return 0;
}
