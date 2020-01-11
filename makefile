test: all clean
	./a.out < input.c > output.c

all: flex bison parser.tab.h
	gcc parser.tab.c lex.yy.c -w

flex: lexer.l
	flex -i lexer.l

bison: parser.y
	bison -v -d parser.y

clean:
	rm lex.yy.c parser.tab.c parser.tab.h parser.output