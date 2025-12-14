/*
REQUIRED_ARGS: -preview=tuples -verrors=context
TEST_OUTPUT:
---
fail_compilation/tuples.d(25): Error: cannot assign to tuple literal
    a++, (a, b) = (3, 4);
                ^
fail_compilation/tuples.d(29): Error: cannot assign to tuple literal
    mixin("(s, b)") = t2;
                    ^
fail_compilation/tuples.d(32): Error: cannot assign to tuple literal
    (x ? (x, b) : (x, b)) = (true, 2);
                          ^
fail_compilation/tuples.d(34): Error: rvalue `("", 0)` cannot be assigned to `ref t`
    ref t = ("", 0);
        ^
---
*/

// Reject assignment to tuple rvalue.
// Note only a statement starting `TupleLiteralExp =` is an UnpackExp
void main()
{
    int a, b;
    a++, (a, b) = (3, 4);

    auto t2 = ("six", 7);
    string s;
    mixin("(s, b)") = t2;

    bool x;
    (x ? (x, b) : (x, b)) = (true, 2);

    ref t = ("", 0);

    // a field of an rvalue struct is an lvalue
    (5, 6)[0]++;
}
