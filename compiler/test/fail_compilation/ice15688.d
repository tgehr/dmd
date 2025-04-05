// REQUIRED_ARGS: -o-
/*
TEST_OUTPUT:
---
fail_compilation/ice15688.d(11): Error: undefined identifier `mappings`
---
*/

void main()
{
    (mappings, 0)();
}
