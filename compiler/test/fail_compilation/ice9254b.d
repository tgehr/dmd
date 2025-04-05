/*
TEST_OUTPUT:
---
fail_compilation/ice9254b.d(12): Error: expression `tuple(2, 3, 4, 8, 7, 9)` of type `(int, int, int, int, int, int)` does not have a boolean value
---
*/

class C
{
    synchronized void foo()
    {
        foreach(divisor; !(2, 3, 4, 8, 7, 9))
        {
            // ice in ForeachRangeStatement::usesEH()
            foreach (v; 0..uint.max) {}

            // ice in WhileStatement::usesEH()
            while (1) {}
        }
    }
}
