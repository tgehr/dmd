/*
TEST_OUTPUT:
---
fail_compilation/ice9254a.d(10): Error: expression `tuple(2, 3, 4, 8, 7, 9)` of type `(int, int, int, int, int, int)` does not have a boolean value
---
*/

void main()
{
    foreach (divisor; !(2, 3, 4, 8, 7, 9))
    {
        // ice in ForeachRangeStatement::blockExit()
        foreach (v; 0..uint.max) {}

        // ice in WhileStatement::blockExit()
        while (1) {}
    }
}
