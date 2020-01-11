{
    int a, b = 10;
    int c = 2;
WHILE_BEGIN1:
{
WHILE_CONDITION1:
{
    int t1 = a < b;
    if (t1 == 0)
        goto WHILE_END1;
    goto WHILE_CODE1;
}
WHILE_CODE1:
{
    int t2 = c * 10;
    c = t2;
    int t3 = a + 1;
    a = t3;
    ;
}
    goto WHILE_CONDITION1;
}
WHILE_END1:
IF_BEGIN1:
{
IF_CONDITION1:
{
    int t4 = a == 10;
    if (t4 == 0)
        goto IF_END1;
    goto IF_CODE1;
}
IF_CODE1:
{
    c = 10;
    ;
}
}
IF_END1:
FOR_BEGIN1:
{
    a = 0;
FOR_CONDITION1:
{
    int t5 = a < b;
    if (t5 == 0)
        goto FOR_END1;
    goto FOR_CODE1;
}
FOR_STEP1:
{
    int t6 = a + 1;
    a = t6;
    goto FOR_CONDITION1;
}
FOR_CODE1:
{
    int t7 = c * 10;
    c = t7;
    ;
}
    goto FOR_STEP1;
}
FOR_END1:;
}
