{(other)

    {(other)
        int(INT) a(ID);(SemiC)
    }(other)
    int(INT) a(ID),(Comma) b(ID),(Comma) c(ID);(SemiC)
    double(DOUBLE) d(ID) =(Assign) 2(INTEGER_NUM),(Comma) f(ID) =(Assign) 2(INTEGER_NUM),(Comma) d(ID) =(Assign) 2(INTEGER_NUM);(SemiC)

    if(IF) ((other)!(NOT)a(ID) ==(EQ) -(Sub)1(INTEGER_NUM) &&(AND) a(ID) >=(GTE) 1(INTEGER_NUM) ||(OR) a(ID) !=(NEQ) 2(INTEGER_NUM) &&(AND) ((other)a(ID) %(Mod) 2(INTEGER_NUM))(other) ==(EQ) 1(INTEGER_NUM))(other)
    {(other)
    }(other)

    while(WHILE) ((other)i(ID) >(GT) 3(INTEGER_NUM))(other)
    {(other)
        a(ID) =(Assign) 3(INTEGER_NUM);(SemiC)
    }(other)

    for(FOR) ((other)i(ID) =(Assign) 0(INTEGER_NUM);(SemiC) i(ID) <=(LTE) 10(INTEGER_NUM);(SemiC) i(ID) =(Assign) i(ID) +(Add) 1(INTEGER_NUM))(other)
        b(ID) =(Assign) 1(INTEGER_NUM);(SemiC)
}(other)