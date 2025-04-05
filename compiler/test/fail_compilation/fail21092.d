// https://issues.dlang.org/show_bug.cgi?id=21092

/*
TEST_OUTPUT:
---
fail_compilation/fail21092.d(15): Error: can only `*` a pointer, not a `(real[], real[])`
fail_compilation/fail21092.d(22): Error: can only `*` a pointer, not a `(real, real[])`
---
*/

real[] T;
real[] U = [];
real erf()
{
    *(T, U);
}

real gammaStirling()
{
    static real[] SmallStirlingCoeffs = [];
    real w;
    *(w, SmallStirlingCoeffs);
}
