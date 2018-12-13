/*
REQUIRED_ARGS: -preview=tuples -vcolumns -verrors=0
TEST_OUTPUT:
---
fail_compilation/unpacking.d(31,14): Error: unpacked variable `b` needs a type or at least one storage class, did you mean `auto b`?
fail_compilation/unpacking.d(32,15): Error: unpacked variable `b` needs a type or at least one storage class, did you mean `auto b`?
fail_compilation/unpacking.d(32,18): Error: unpacked variable `c` needs a type or at least one storage class, did you mean `auto c`?
fail_compilation/unpacking.d(33,23): Error: unpacked variable `c` needs a type or at least one storage class, did you mean `auto c`?
fail_compilation/unpacking.d(35,16): Error: variable name expected after type `(a,b)`, not `,`
fail_compilation/unpacking.d(35,16): Error: found `,` instead of statement
fail_compilation/unpacking.d(36,10): Error: unexpected identifier `a` in declarator
fail_compilation/unpacking.d(36,17): Error: unexpected identifier `b` in declarator
fail_compilation/unpacking.d(38,17): Error: expected identifier after type `int` in unpack declaration
fail_compilation/unpacking.d(40,16): Error: `auto ref` unpacked variables are not supported
fail_compilation/unpacking.d(41,25): Error: unpacking `auto ref` parameters is not supported
fail_compilation/unpacking.d(42,21): Error: unpacking `lazy` parameters is not supported
fail_compilation/unpacking.d(42,34): Error: unpacking `out` parameters is not supported
fail_compilation/unpacking.d(44,23): Error: `;` expected after tuple pattern, not `,`
---
*/

struct Tuple(T...)
{
    T expand;
    alias this = expand;
}
auto tuple(T...)(T args) => Tuple!T(args);

void main() // check parse errors
{
    (int a, b) = tuple(1, "2"); // error, lone b
    (int a, (b, c)) = tuple(1, tuple("2", 3.0)); // error
    (int a, (auto b, c)) = tuple(1, tuple("2", 3.0)); // error

    auto (a, b), c = t; // error, pattern missing init
    (int a, int b), c = t; // error

    (char a, int) = t; // error, missing ident

    (auto ref a,) = t; // error, illegal storage
    alias a = (auto ref (x,)) {}; // error
    alias a = (lazy (x,), y, out (z,)) {}; // error

    (int a, int b) = t, c = 1; // error, comma requires storage class
}
