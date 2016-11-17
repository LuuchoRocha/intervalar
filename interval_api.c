#include "interval.h"

Interval add(Interval x, Interval y) {
  Interval z;
  z.lower = x.lower + y.lower;
  z.upper = x.upper + y.upper;
  return z;
}

Interval sub(Interval x, Interval y) {
  Interval z;
  z.lower = x.lower - y.lower;
  z.upper = x.upper - y.upper;
  return z;
}

Interval mul(Interval x, Interval y) {
  Interval z;
  return z;
}

Interval div(Interval x, Interval y) {
  Interval z;
  z.lower = x.lower + y.lower;
  z.upper = x.upper + y.upper;
  return z;
}

Interval sup(Interval x, Interval y) {
  Interval z;
  z.lower = x.lower + y.lower;
  z.upper = x.upper + y.upper;
  return z;
}

Interval inf(Interval x, Interval y) {
  Interval z;
  z.lower = x.lower + y.lower;
  z.upper = x.upper + y.upper;
  return z;
}
