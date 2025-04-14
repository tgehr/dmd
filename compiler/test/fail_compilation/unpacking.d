/*
REQUIRED_ARGS: -preview=tuples -vcolumns
TEST_OUTPUT:
---
unpacking.d(24,14): Error: unpacked variable `b` needs a type or at least one storage class, did you mean `auto b`?
unpacking.d(25,15): Error: unpacked variable `b` needs a type or at least one storage class, did you mean `auto b`?
unpacking.d(25,18): Error: unpacked variable `c` needs a type or at least one storage class, did you mean `auto c`?
unpacking.d(26,23): Error: unpacked variable `c` needs a type or at least one storage class, did you mean `auto c`?
unpacking.d(28,16): Error: found `,` when expecting `=` following unpack declaration
unpacking.d(29,10): Error: unexpected identifier `a` in declarator
unpacking.d(29,17): Error: unexpected identifier `b` in declarator
---
*/

struct Tuple(T...)
{
    T expand;
    alias this = expand;
}
auto tuple(T...)(T args) => Tuple!T(args);

void main()
{
    (int a, b) = tuple(1, "2"); // error
    (int a, (b, c)) = tuple(1, tuple("2", 3.0)); // error
    (int a, (auto b, c)) = tuple(1, tuple("2", 3.0)); // error

    auto (a, b), c = t; // error
    (int a, int b), c = t; // error

    extern (c, d) = tuple(1,2); // error
    auto extern (e, f) = tuple(1,2); // error
}
