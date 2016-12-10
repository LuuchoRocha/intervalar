### Interval Arithmetics

An implementation of interval arithmetics using C to writte an API and assembler to implement their operations.
We provide:
  * A C header with definitions of the structs and operations declarations.
  * An Implementation of the operations written in assembler.
  * An Interval arithmetics calculator written in C.
  * A test suite written in C.

### Execution

If you want to run the test suite, there is a script named "run_test_suite.sh".
Just set the execution permissions and run it:
 * `$ chmod +x run_test_suite.sh`
 * `$ ./run_test_suite.sh`

If you want to run the calculator, there is another script named "run_calculator.sh".
To run it, you have to set execution permissions and then run it:
 * `$ chmod +x run_calculator.sh`
 * `$ ./run_calculator.sh`

### Compilation

If you want to compile only library, you can do it with:
 * `nasm -f elf32 -D ELF_TYPE interval_impl.asm`
This will generate a file named `interval_impl.o`.
Then if you want to include it in your program, you have to include the header:
 * `#include "interval.h"`

And when compile your program the command should be like:
 * `gcc -m32 my_program.c interval_impl.o`

