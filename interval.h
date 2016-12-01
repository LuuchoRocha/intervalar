#include <stdint.h>

typedef struct Interval {
  int16_t  lower;
  int16_t  upper;
} Interval;

extern Interval add_asm(Interval x, Interval y);
extern Interval sub_asm(Interval x, Interval y);
extern Interval mul_asm(Interval x, Interval y);
extern Interval div_asm(Interval x, Interval y);
extern Interval sup_asm(Interval x, Interval y);
extern Interval inf_asm(Interval x, Interval y);
extern int16_t min_asm(int16_t x, int16_t y);
extern int16_t max_asm(int16_t x, int16_t y);
