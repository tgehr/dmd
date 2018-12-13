/*
REQUIRED_ARGS: -preview=tuples -vcolumns
TEST_OUTPUT:
---
fail_compilation/unpacking.d(26,14): Error: unpacked variable `b` needs a type or at least one storage class, did you mean `auto b`?
fail_compilation/unpacking.d(27,15): Error: unpacked variable `b` needs a type or at least one storage class, did you mean `auto b`?
fail_compilation/unpacking.d(27,18): Error: unpacked variable `c` needs a type or at least one storage class, did you mean `auto c`?
fail_compilation/unpacking.d(28,23): Error: unpacked variable `c` needs a type or at least one storage class, did you mean `auto c`?
fail_compilation/unpacking.d(30,16): Error: variable name expected after type `(a,b)`, not `,`
fail_compilation/unpacking.d(30,16): Error: found `,` instead of statement
fail_compilation/unpacking.d(31,10): Error: unexpected identifier `a` in declarator
fail_compilation/unpacking.d(31,17): Error: unexpected identifier `b` in declarator
fail_compilation/unpacking.d(33,17): Error: expected identifier after type `int` in unpack declaration
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

    (char a, int) = t; // error
}
