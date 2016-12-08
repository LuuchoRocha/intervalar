#include <stdio.h>
#include "interval.h"

int main( ) {
  Interval16 x, y, add, sub, inf, sup;
  Interval32 mul;
  int16_t min, max;

  x.lower = 5 ;
  x.upper = 24;

  y.lower = 2;
  y.upper = 4;

  add = add_asm(x, y);
  sub = sub_asm(x, y);
  mul = mul_asm(x, y);
  inf = inf_asm(x, y);
  sup = sup_asm(x, y);
  min = min_asm(x.lower, y.lower);
  max = max_asm(x.upper, y.upper);

  printf("X: [%d;%d]\n", x.lower, x.upper);
  printf("Y: [%d;%d]\n\n", y.lower, y.upper);
  printf("ADD(x, y) = [%d;%d]\n", add.lower, add.upper);
  printf("SUB(x, y) = [%d;%d]\n\n", sub.lower, sub.upper);
  printf("MUL(x, y) = [%d;%d]\n", mul.lower, mul.upper);
  printf("INF(x, y) = [%d;%d]\n", inf.lower, inf.upper);
  printf("SUP(x, y) = [%d;%d]\n", sup.lower, sup.upper);
  printf("MIN(%d, %d) = %d\n", x.lower, y.lower, min);
  printf("MAX(%d, %d) = %d\n\n", x.upper, y.upper, max);

  return 0;
}
