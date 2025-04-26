/*
REQUIRED_ARGS: -preview=tuples -vcolumns
TEST_OUTPUT:
---
fail_compilation/unpacking.d(32,14): Error: unpacked variable `b` needs a type or at least one storage class, did you mean `auto b`?
fail_compilation/unpacking.d(33,15): Error: unpacked variable `b` needs a type or at least one storage class, did you mean `auto b`?
fail_compilation/unpacking.d(33,18): Error: unpacked variable `c` needs a type or at least one storage class, did you mean `auto c`?
fail_compilation/unpacking.d(34,23): Error: unpacked variable `c` needs a type or at least one storage class, did you mean `auto c`?
fail_compilation/unpacking.d(36,16): Error: variable name expected after type `(a,b)`, not `,`
fail_compilation/unpacking.d(36,16): Error: declaration expected, not `,`
fail_compilation/unpacking.d(37,10): Error: unexpected identifier `a` in declarator
fail_compilation/unpacking.d(37,17): Error: unexpected identifier `b` in declarator
fail_compilation/unpacking.d(37,19): Error: variable name expected after type `(int,int)`, not `,`
fail_compilation/unpacking.d(37,19): Error: declaration expected, not `,`
fail_compilation/unpacking.d(39,17): Error: expected identifier after type `int` in unpack declaration
fail_compilation/unpacking.d(41,16): Error: `auto ref` unpacked variables are not supported
fail_compilation/unpacking.d(42,25): Error: unpacking `auto ref` parameters is not supported
fail_compilation/unpacking.d(43,21): Error: unpacking `lazy` parameters is not supported
fail_compilation/unpacking.d(43,34): Error: unpacking `out` parameters is not supported
---
*/

struct Tuple(T...)
{
    T expand;
    alias this = expand;
}
auto tuple(T...)(T args) => Tuple!T(args);

private // test parser errors
{
    (int a, b) = tuple(1, "2"); // error
    (int a, (b, c)) = tuple(1, tuple("2", 3.0)); // error
    (int a, (auto b, c)) = tuple(1, tuple("2", 3.0)); // error

    auto (a, b), c = t; // error
    (int a, int b), c = t; // error

    (char a, int) = t; // error

    (auto ref a,) = t; // error
    alias a = (auto ref (x,)) {}; // error
    alias a = (lazy (x,), y, out (z,)) {}; // error
}
