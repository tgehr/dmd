/*
REQUIRED_ARGS: -preview=tuples
*/

struct Tuple(T...)
{
    T expand;
    alias this = expand;
}
auto tuple(T...)(T args) => Tuple!T(args);

void main()
{
    string[1] b;
    auto t = tuple(1, "2");
    (ref a, b[0]) = t;
    a++;
    assert(t[0] == 2);
    assert(b[0] == "2");

    // nested UnpackExp
    string d;
    double e, h;
    (int c, (d, e)) = tuple(1, tuple("4", 3.0));
    (int f, (auto g, h)) = tuple(1, tuple("4", 3.0));
    assert(c == 1 && f == c);
    assert(d == "4" && g == d);
    assert(e == 3.0 && h == e);

    // nested UnpackDeclaration
    int i;
    ref get() => i;
    (auto (j,), get) = tuple(tuple("5"), 1);
    assert(j == "5");
    assert(get == 1);
}
