#include <stdio.h>
#include "interval.h"

int main( ) {
  Interval16 x, y, add, sub, inf, sup;

  x.lower = 1;
  x.upper = 3;

  y.lower = 4;
  y.upper = 6;

  add = add_asm(x, y);
  sub = sub_asm(x, y);
  inf = inf_asm(x, y);
  sup = sup_asm(x, y);

  printf("X: [%d;%d]\n", x.lower, x.upper);
  printf("Y: [%d;%d]\n\n", y.lower, y.upper);
  printf("ADD(x, y) = [%d;%d]\n", add.lower, add.upper);
  printf("SUB(x, y) = [%d;%d]\n\n", sub.lower, sub.upper);
  printf("MIN(x.upper, y.upper) = [%d]\n", min_asm(x.upper, y.upper));
  printf("MAX(x.lower, x.lower) = [%d]\n\n", max_asm(x.lower, y.lower));
  printf("INF(x, y) = [%d;%d]\n", inf.lower, inf.upper);
  printf("SUP(x, y) = [%d;%d]\n", sup.lower, sup.upper);

  return 0;
}
