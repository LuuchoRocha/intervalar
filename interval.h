#ifndef STDINT_H
#include <stdint.h>
#define STDINT_H
#endif

typedef struct Interval {
  int16_t  lower;
  int16_t  upper;
} Interval;

Interval add(Interval x, Interval y);
Interval sub(Interval x, Interval y);
Interval mul(Interval x, Interval y);
Interval div(Interval x, Interval y);
Interval sup(Interval x, Interval y);
Interval inf(Interval x, Interval y);

Interval add_asm(Interval x, Interval y);
Interval sub_asm(Interval x, Interval y);
Interval mul_asm(Interval x, Interval y);
Interval div_asm(Interval x, Interval y);
Interval sup_asm(Interval x, Interval y);
Interval inf_asm(Interval x, Interval y);
