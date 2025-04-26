/*
REQUIRED_ARGS: -preview=tuples
TEST_OUTPUT:
---
fail_compilation/tuple_assign.d(26): Error: cannot implicitly convert expression `t.__expand_field_0` of type `string` to `int`
fail_compilation/tuple_assign.d(26): Error: cannot resolve type for b = t.__expand_field_0 , c = t.__expand_field_1
fail_compilation/tuple_assign.d(28): Error: right hand side of unpack statement must resolve to a tuple or expression sequence, not `int`
fail_compilation/tuple_assign.d(30): Error: cannot modify constant `2`
fail_compilation/tuple_assign.d(30): Error: cannot resolve type for (Tuple!int __tup38 = __tup38 = 0 , __tup38.this(1);) , 2 ...
fail_compilation/tuple_assign.d(31): Error: incompatible number of components for unpack statement (`1` vs. `2`)
fail_compilation/tuple_assign.d(33): Error: cannot implicitly convert expression `0` of type `int` to `string`
fail_compilation/tuple_assign.d(33): Error: cannot resolve type for b = 0 , a = 0
fail_compilation/tuple_assign.d(34): Error: incompatible number of components for unpack statement (`2` vs. `1`)
fail_compilation/tuple_assign.d(36): Error: cannot specify `enum` for unpack statement components
fail_compilation/tuple_assign.d(37): Error: right hand side of unpack statement must resolve to a tuple or expression sequence, not `string`
fail_compilation/tuple_assign.d(37): Error: cannot resolve type for (int m = 12;) , (n,) = "val"
---
*/

void main()
{
    string a;
    int b, c;
    auto t = ("two", 3);
    (a, b) = t; // OK
    (b, c) = t; // b type error

    (b,) = 1; // wrong RHS
    (b,) = (1,); // OK
    (2,) = (1,); // not lvalue
    (b,) = (1, 2); // too many

    (b, a) = Seq!(0, 0); // a type error
    (b, c) = Seq!1; // too few

    (int k, enum (l,)) = Seq!(1, (2,)); // enum decl not allowed inside statement
    (int m, (n,)) = Seq!(12, "val"); // nested init not tuple
}

alias Seq(A...) = A;
