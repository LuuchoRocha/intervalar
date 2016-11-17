#include <stdio.h>
#include "interval.h"

int main( ) {
  Interval x, y, z;

  x.lower = 2;
  x.upper = 3;

  y.lower = 7;
  y.upper = 8;

  z = add_asm(x, y);

  printf("[%d;%d]\n", z.lower, z.upper);

  return 0;
}

