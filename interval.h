#include <stdint.h>

typedef struct Interval {
  int16_t  lower;
  int16_t  upper;
} Interval;

Interval add_asm(Interval x, Interval y);
Interval sub_asm(Interval x, Interval y);
Interval mul_asm(Interval x, Interval y);
Interval div_asm(Interval x, Interval y);
Interval sup_asm(Interval x, Interval y);
Interval inf_asm(Interval x, Interval y);
