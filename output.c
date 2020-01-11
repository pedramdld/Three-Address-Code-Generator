{
int a, b = 10;
int c = 0;
WHILE_BEGIN1:
{
int t1 = a < b;
if (t1==false) goto WHILE_END1;
{
int t2 = c * 10;
c = t2;
int t3 = a + 1;
a = t3;
;
}
goto WHILE_BEGIN1;
}
WHILE_END1:
FOR_BEGIN1:
{
a = 0;
FOR_CONDITION1:
int t4 = a < b;
if(t4 == false) goto FOR_END1;
goto FOR_CODE1;
FOR_STEP1:
int t5 = a + 1;
a = t5;
goto FOR_CONDITION1;
FOR_CODE1:
{
int t6 = c * 10;
c = t6;
;
}
goto FOR_STEP1;
}
FOR_END1:
;
}
