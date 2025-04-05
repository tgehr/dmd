/+
TEST_OUTPUT:
---
fail_compilation/must_use_comma.d(18): Error: template `tuple` is not callable using argument types `!()(S, void)`
$p:phobos/std/typecons.d$($n$):        Candidate is: `tuple(Names...)`
$p:phobos/std/typecons.d$($n$):          - Containing: `tuple(Args...)(Args args)`
---
+/
import core.attribute;

@mustuse struct S {}

S fun() { return S(); }
void sideEffect() {}

void test()
{
    (fun(), sideEffect());
}
