#include <stdint.h>

typedef struct Interval16 {
  int16_t  lower;
  int16_t  upper;
} Interval16;

typedef struct Interval32 {
  int32_t  lower;
  int32_t  upper;
} Interval32;


extern Interval16 add_asm(Interval16 x, Interval16 y);
extern Interval16 sub_asm(Interval16 x, Interval16 y);
extern Interval32 mul_asm(Interval16 x, Interval16 y);
extern Interval16 sup_asm(Interval16 x, Interval16 y);
extern Interval16 inf_asm(Interval16 x, Interval16 y);
extern int16_t min_asm(int16_t x, int16_t y);
extern int16_t max_asm(int16_t x, int16_t y);
