#include <stdio.h>
#include "interval.h"
#ifndef STDINT_H
#include <stdint.h>
#define STDINT_H
#endif

int main( ) {
  Interval x, y, z;

  x.lower = 1;
  x.upper = 3;

  y.lower = 4;
  y.upper = 6;

  z = add(x, y);

  printf("[%d;%d]\n", z.lower, z.upper);

  return 0;
}

