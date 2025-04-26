/*
REQUIRED_ARGS: -preview=tuples
*/

void main()
{
    // literal
    auto tup = (4, 5);
    assert(tup == (4, 5));
    assert(tup[0] == 4);
    assert(tup[1] == 5);

    auto st = ("one",);
    assert(st[0] == "one");
    assert(st.length == 1);

    // unpacking
    auto (x, const y, z) = (1, 2L, "three");
    static assert(is(typeof(x) == int));
    static assert(is(typeof(y) == const long));
    static assert(is(typeof(z) == string));
    assert(x == 1);
    assert(y == 2L);
    assert(z == "three");

    (string a, int b) = ("four", 5);
    assert(a == "four");
    assert(b == 5);

    (auto c, const uint d, immutable e) = (true, 7u, 8);
    static assert(is(typeof(c) == bool));
    static assert(is(typeof(d) == const uint));
    static assert(is(typeof(e) == immutable int));
    assert(c);
    assert(d == 7u);
    assert(e == 8);

    // unpack to existing lvalues
    (a, b) = ("two", 3);
    assert(a == "two");
    assert(b == 3);
    // nesting
    ((a, b), c) = (("five", 6), false);
    assert(a == "five");
    assert(b == 6);
    assert(!c);

    // tuple type
    (int, char) t = (6, '7');
    assert(t == (6, '7'));
    assert(t[0] == 6);
    assert(t[1] == '7');
    t = (8, '9');
    assert(t == (8, '9'));
    assert(t[0] == 8);
    assert(t[1] == '9');
    // assign
    ref f() => x;
    (f(), b) = t; // int,int = int,char
    assert(x == 8);
    assert(b == '9');

    (int,) t2;
    static assert(t2.length == 1);
    static assert(is(typeof(t2[0]) == int));
    t2 = (5,);
    assert(t2[0] == 5);
    // assign
    (t[0],) = t2;
    assert(t[0] == 5);

    () t3 = ();
    t3 = ();
    () = t3; // LHS is TupleLiteralExp, but it's a no-op anyway
    static assert(t3.length == 0);

    // foreach unpacking
    auto tc = (0, "");
    foreach ((i, s); [(1, "one"), (2, "two")])
    {
        tc[0] += i;
        tc[1] ~= s;
    }
    assert(tc[0] == 3);
    assert(tc[1] == "onetwo");

    // parameter unpacking
    // TODO
    //int foo((int x, int y), int z) => [x, y, z];
    alias foo = ((int x, int y), int z) => [x, y, z];
    assert(foo((1, 2), 3) == [1, 2, 3]);

    alias dg = (x, (y, z)) => [x, y, z];
    assert(dg(1, (2, 3)) == [1, 2, 3]);

    // ensure no explicit import needed
    static assert(!__traits(compiles, std.typecons));
}
