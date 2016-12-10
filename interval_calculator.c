#define RESET   "\033[0m"
#define BOLDRED     "\033[1m\033[31m"
#define BOLDGREEN   "\033[1m\033[32m"
#define BOLDYELLOW  "\033[1m\033[33m"
#define BOLDCYAN    "\033[1m\033[36m"
#define BOLDWHITE   "\033[1m\033[37m"

#include <stdio.h>
#include <inttypes.h>
#include "interval.h"

int main( ) {
  Interval16 x, y, add, sub, inf, sup;
  Interval32 mul;

  clear();

  while (1) {
    printf(BOLDGREEN "Ingrese el limite inferior de X: " BOLDWHITE);
    scanf("%" SCNd16, &x.lower);
    printf(BOLDGREEN "Ingrese el limite superior de X: " BOLDWHITE);
    scanf("%" SCNd16, &x.upper);
    if (x.lower > x.upper){
      printf(BOLDRED "El límite superior debe ser mayor o igual al límite inferior\n" RESET);
    } else {
      break;
    }
  }

  printf("\n");

  while (1) {
    printf(BOLDGREEN "Ingrese el limite inferior de Y: " BOLDWHITE);
    scanf("%" SCNd16, &y.lower);
    printf(BOLDGREEN "Ingrese el limite superior de Y: " BOLDWHITE);
    scanf("%" SCNd16, &y.upper);
    if (y.lower > y.upper){
      printf(BOLDRED "El límite superior debe ser mayor o igual al límite inferior\n" RESET);
    } else {
      break;
    }
  }

  clear();

  add = add_asm(x, y);
  sub = sub_asm(x, y);
  mul = mul_asm(x, y);
  inf = inf_asm(x, y);
  sup = sup_asm(x, y);

  printf(BOLDCYAN "===== Números Intervalares ingresados: =====\n\n");
  printf(BOLDGREEN "X" BOLDWHITE " = [%d; %d]\n", x.lower, x.upper);
  printf(BOLDGREEN "Y" BOLDWHITE " = [%d; %d]\n\n", y.lower, y.upper);
  printf(BOLDCYAN "================ Resultados ================\n\n");
  printf(BOLDYELLOW "ADD(x, y)" BOLDWHITE " = [%d; %d]\n\n", add.lower, add.upper);
  printf(BOLDYELLOW "SUB(x, y)" BOLDWHITE " = [%d; %d]\n\n", sub.lower, sub.upper);
  printf(BOLDYELLOW "MUL(x, y)" BOLDWHITE " = [%d; %d]\n\n", mul.lower, mul.upper);
  printf(BOLDYELLOW "INF(x, y)" BOLDWHITE " = [%d; %d]\n\n", inf.lower, inf.upper);
  printf(BOLDYELLOW "SUP(x, y)" BOLDWHITE " = [%d; %d]\n\n" RESET, sup.lower, sup.upper);

  return 0;
}

void clear()
{
    system("@cls||clear");
}
