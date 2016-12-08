#include <stdio.h>
#include <inttypes.h>
#include "interval.h"

int main( ) {
  Interval16 x, y, add, sub, inf, sup;
  Interval32 mul;

  printf("=============================")
  scanf("%" SCNd32, &x.lower);
  scanf("%" SCNd32, &x.upper);

  add = add_asm(x, y);
  sub = sub_asm(x, y);
  mul = mul_asm(x, y);
  inf = inf_asm(x, y);
  sup = sup_asm(x, y);

  printf("X: [%d;%d]\n", x.lower, x.upper);
  printf("Y: [%d;%d]\n\n", y.lower, y.upper);
  printf("ADD(x, y) = [%d;%d]\n", add.lower, add.upper);
  printf("SUB(x, y) = [%d;%d]\n\n", sub.lower, sub.upper);
  printf("MUL(x, y) = [%d;%d]\n", mul.lower, mul.upper);
  printf("INF(x, y) = [%d;%d]\n", inf.lower, inf.upper);
  printf("SUP(x, y) = [%d;%d]\n", sup.lower, sup.upper);

  return 0;
}
