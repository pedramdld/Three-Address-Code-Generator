{
    int a, b = 10;
    int c = 2;

    while (a < b)
    {
        c = c * 10;
        a = a + 1;
    }

    if (a == 10)
    {
        c = 10;
    }

    for (a = 0; a < b; a = a + 1)
    {
        c = c * 10;
    }
}