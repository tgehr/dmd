void main()
{
    // literal
    auto tup = (4, 5);
    assert(tup[0] == 4);
    assert(tup[1] == 5);

    // unpacking
    auto (x, y, z) = (1, 2, 3);
    assert(x == 1);
    assert(y == 2);
    assert(z == 3);

    // tuple type
    (int, int) t = (6, 7);
    assert(t == (6, 7));
    t = (8, 9);
    assert(t == (8, 9));
    assert(t[0] == 8);
    assert(t[1] == 9);

    // ensure no explicit import needed
    static assert(!__traits(compiles, std.typecons));
}
