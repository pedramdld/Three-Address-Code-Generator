%{
    #include"parser.tab.h"
    #include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include<ctype.h>

    // extern char yyval;

	void yyerror(char*);
%}

digit [0-9]
letter [a-zA-Z]
whitespace [ \t\n\r]

%%

{whitespace}+			{;}
{digit}+				{strcpy(yylval.str, yytext); return INTEGER_NUM;}
{digit}+"."{digit}+		{strcpy(yylval.str, yytext); return DOUBLE_NUM;}
[+-/*%=,;(){}]			{return *yytext;}	

"<"         {strcpy(yylval.str, yytext); return LT;}
"<="        {strcpy(yylval.str, yytext); return LTE;}
">"         {strcpy(yylval.str, yytext); return GT;}
">="        {strcpy(yylval.str, yytext); return GTE;}
"=="        {strcpy(yylval.str, yytext); return EQ;}
"!="        {strcpy(yylval.str, yytext); return NEQ;}
"&&"        {strcpy(yylval.str, yytext); return L_AND;}
"||"		{strcpy(yylval.str, yytext); return L_OR;}
"~"         {strcpy(yylval.str, yytext); return B_NOT;}
"&"			{strcpy(yylval.str, yytext); return B_AND;}
"|"			{strcpy(yylval.str, yytext); return B_OR;}
"^"			{strcpy(yylval.str, yytext); return B_XOR;}

"int"       {return INT;}
"double"    {return DOUBLE;}
"for"       {return FOR;}
"while"     {return WHILE;}
"if"        {return IF;}

{letter}({letter}|{digit})*     {strcpy(yylval.str, yytext); return ID;}
.                               { yyerror("Invalid Command");}

%%
