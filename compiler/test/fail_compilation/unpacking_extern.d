/*
REQUIRED_ARGS: -preview=tuples -vcolumns
TEST_OUTPUT:
---
fail_compilation/unpacking_sem.d(19): Error: variable `unpacking_sem.a` extern symbols cannot have initializers
fail_compilation/unpacking_sem.d(19): Error: variable `unpacking_sem.b` extern symbols cannot have initializers
fail_compilation/unpacking_sem.d(20): Error: variable `unpacking_sem.c` extern symbols cannot have initializers
fail_compilation/unpacking_sem.d(20): Error: variable `unpacking_sem.d` extern symbols cannot have initializers
---
*/

struct Tuple(T...)
{
    T expand;
    alias this = expand;
}
auto tuple(T...)(T args) => Tuple!T(args);

extern (a, b) = tuple(1,2); // error
auto extern (c, d) = tuple(1,2); // error
