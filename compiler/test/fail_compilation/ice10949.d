/*
TEST_OUTPUT:
---
fail_compilation/ice10949.d(13): Error: array index 3 is out of bounds `[5, 5][0 .. 2]`
fail_compilation/ice10949.d(13): Error: template `tuple` is not callable using argument types `!()(bool, int)`
$p:phobos/std/typecons.d$($n$):        Candidate is: `tuple(Names...)`
$p:phobos/std/typecons.d$($n$):          - Containing: `tuple(Args...)(Args args)`
fail_compilation/ice10949.d(13):        while evaluating: `static assert((((([5, 5][3] + global - global) * global / global % global >> global & global | global) ^ global) == 9, [2, 3][17]) || [3, 3, 3][9] is 4 && [[1, 2, 3]][4].length)`
---
*/

int global;
static assert((((((([5,5][3] + global - global)*global/global%global)>>global) &global|global)^global) == 9, [2,3][17]) || ([3,3,3][9] is 4) && ([[1,2,3]][4]).length);
