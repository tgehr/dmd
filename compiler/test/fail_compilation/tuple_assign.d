/*
REQUIRED_ARGS: -preview=tuples
TEST_OUTPUT:
---
fail_compilation/tuple_assign.d(18): Error: cannot assign `Tuple!(string, int)` to expression sequence `(int, int)`
fail_compilation/tuple_assign.d(20): Error: cannot assign `int` to expression sequence `(int)`
fail_compilation/tuple_assign.d(22): Error: cannot modify constant `2`
fail_compilation/tuple_assign.d(23): Error: cannot assign `Tuple!(int, int)` to expression sequence `(int)`
---
*/

void main()
{
    string a;
    int b,c;
    auto t = ("two", 3);
    (a, b) = t; // OK
    (b, c) = t; // b type error

    (b,) = 1; // wrong RHS
    (b,) = (1,); // OK
    (2,) = (1,); // not lvalue
    (b,) = (1, 2); // too many
}
