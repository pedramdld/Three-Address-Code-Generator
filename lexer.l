%{
    #include"parser.tab.h"
    #include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include<ctype.h>

    extern char yyval;

	void yyerror(char*);
%}

digit [0-9]
letter [a-zA-Z]
whitespace [ \t\n\r]

%%

{whitespace}+			{printf(yytext);}
{digit}+				{printf("%s(INTEGER_NUM)", yytext); strcpy(yylval.str, yytext); return INTEGER_NUM;}
{digit}+"."{digit}+		{printf("%s(DOUBLE_NUM)", yytext); strcpy(yylval.str, yytext); return DOUBLE_NUM;}
[(){}]					{printf("%s(other)", yytext); return *yytext;}	

"+"			{printf("%s(Add)", yytext); strcpy(yylval.str, yytext); return *yytext;}
"-"			{printf("%s(Sub)", yytext); strcpy(yylval.str, yytext); return *yytext;}
"*"			{printf("%s(Mul)", yytext); strcpy(yylval.str, yytext); return *yytext;}
"/"			{printf("%s(Div)", yytext); strcpy(yylval.str, yytext); return *yytext;}
"%"			{printf("%s(Mod)", yytext); strcpy(yylval.str, yytext); return *yytext;}
"="			{printf("%s(Assign)", yytext); strcpy(yylval.str, yytext); return *yytext;}
","			{printf("%s(Comma)", yytext); strcpy(yylval.str, yytext); return *yytext;}
";"			{printf("%s(SemiC)", yytext); strcpy(yylval.str, yytext); return *yytext;}

"<"         {printf("%s(LT)", yytext); strcpy(yylval.str, yytext); return LT;}
"<="        {printf("%s(LTE)", yytext); strcpy(yylval.str, yytext); return LTE;}
">"         {printf("%s(GT)", yytext); strcpy(yylval.str, yytext); return GT;}
">="        {printf("%s(GTE)", yytext); strcpy(yylval.str, yytext); return GTE;}
"=="        {printf("%s(EQ)", yytext); strcpy(yylval.str, yytext); return EQ;}
"!="        {printf("%s(NEQ)", yytext); strcpy(yylval.str, yytext); return NEQ;}
"!"         {printf("%s(NOT)", yytext); strcpy(yylval.str, yytext); return NOT;}
"&&"        {printf("%s(AND)", yytext); strcpy(yylval.str, yytext); return AND;}
"||"        {printf("%s(OR)", yytext); strcpy(yylval.str, yytext); return OR;}

"int"       {printf("%s(INT)", yytext); return INT;}
"double"    {printf("%s(DOUBLE)", yytext); return DOUBLE;}
"for"       {printf("%s(FOR)", yytext); return FOR;}
"while"     {printf("%s(WHILE)", yytext); return WHILE;}
"if"        {printf("%s(IF)", yytext); return IF;}

{letter}({letter}|{digit})*     {printf("%s(ID)", yytext); strcpy(yylval.str, yytext); return ID;}
.                               {printf(yytext); yyerror("Invalid Command");}


%%
