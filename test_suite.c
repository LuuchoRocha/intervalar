#define RESET   "\033[0m"
#define BOLDGREEN   "\033[1m\033[32m"
#define BOLDYELLOW  "\033[1m\033[33m"
#define BOLDWHITE   "\033[1m\033[37m"

#include <stdio.h>
#include "interval.h"

int main( ) {
  Interval16 x, y;

  x.lower = 5 ;
  x.upper = 7;

  y.lower = 3;
  y.upper = 9;

  printf(BOLDYELLOW "================ Caso 1 ================\n\n" RESET);
  test_suite(x, y);

  x.lower = 0 ;
  x.upper = 1;

  y.lower = -3;
  y.upper = 5;

  printf(BOLDYELLOW "================ Caso 2 ================\n\n" RESET);
  test_suite(x, y);

  x.lower = 548 ;
  x.upper = 11024;

  y.lower = -3098;
  y.upper = -9;

  printf(BOLDYELLOW "================ Caso 3 ================\n\n" RESET);
  test_suite(x, y);

  x.lower = 548 ;
  x.upper = 11024;

  y.lower = -3098;
  y.upper = -9;

  printf(BOLDYELLOW "================ Caso 4 ================\n\n" RESET);
  test_suite(x, y);

  x.lower = 0;
  x.upper = 0;

  y.lower = 1;
  y.upper = 1;

  printf(BOLDYELLOW "================ Caso 5 ================\n\n" RESET);
  test_suite(x, y);

  x.lower = 0;
  x.upper = 0;

  y.lower = 0;
  y.upper = 0;

  printf(BOLDYELLOW "================ Caso 6 ================\n\n" RESET);
  test_suite(x, y);

  x.lower = -32768;
  x.upper = 32767;

  y.lower = 0;
  y.upper = 0;

  printf(BOLDYELLOW "================ Caso 7 ================\n\n" RESET);
  test_suite(x, y);

  return 0;
}

void test_suite(Interval16 x, Interval16 y) {
  Interval16 add, sub, inf, sup;
  Interval32 mul;
  int16_t min, max;

  add = add_asm(x, y);
  sub = sub_asm(x, y);
  mul = mul_asm(x, y);
  inf = inf_asm(x, y);
  sup = sup_asm(x, y);
  min = min_asm(x.lower, y.lower);
  max = max_asm(x.upper, y.upper);

  printf(BOLDGREEN "X" BOLDWHITE " = [%d; %d]\n", x.lower, x.upper);
  printf(BOLDGREEN "Y" BOLDWHITE " = [%d; %d]\n\n", y.lower, y.upper);
  printf(BOLDGREEN "ADD(x, y)" BOLDWHITE " = [%d; %d]\n", add.lower, add.upper);
  printf(BOLDGREEN"SUB(x, y)" BOLDWHITE " = [%d; %d]\n\n", sub.lower, sub.upper);
  printf(BOLDGREEN "MUL(x, y)" BOLDWHITE " = [%d; %d]\n", mul.lower, mul.upper);
  printf(BOLDGREEN "INF(x, y)" BOLDWHITE " = [%d; %d]\n", inf.lower, inf.upper);
  printf(BOLDGREEN "SUP(x, y)" BOLDWHITE " = [%d; %d]\n", sup.lower, sup.upper);
  printf(BOLDGREEN "MIN(%d; %d)" BOLDWHITE " = %d\n", x.lower, y.lower, min);
  printf(BOLDGREEN "MAX(%d; %d)" BOLDWHITE " = %d\n\n" RESET, x.upper, y.upper, max);
}
