%{
	#include"parser.tab.h"
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include<ctype.h>

	int whileLableCounter = 1;
	int forLableCounter = 1;
	int ifLableCounter = 1;
	int tempVar = 1;
	char strBuffer[16];

	void yyerror (char const *s);
%}
%start Program 				//The start symbol of the grammar
%union{
    char str[200];
	int lableIndex;
}


/*KeywL_ords*/
%token INT DOUBLE					//token for Type decleration
%token <lableIndex> WHILE FOR IF	//statment
%token <str> LT LTE GT GTE EQ NEQ	//Tokens for Relational Operators
%token <str> L_AND L_OR L_NOT		//Tokens Logical Operators
%token <str> B_AND B_OR B_NOT B_XOR	//Tokens Bitwise Operators



/*Data type tokens*/
%token <str> ID
%token <str> INTEGER_NUM
%token <str> DOUBLE_NUM


/*Grammar's Variable(Non-terminal) types*/
%type <str> Expr Term Decl Ids


/*Operator Associativity and Precedence*/
%right '='
%left L_OR
%left L_AND
%left B_OR
%left B_XOR
%left B_AND
%left EQ NEQ
%left LT LTE GT GTE
%left '-' '+'
%left '*' '/' '%'
%left L_NOT B_NOT
%left NEGATION


%%

Program:
	Block   {;}
	;

Block: 
	{printf("{\n");}'{' Stmts '}'     {printf(";\n}\n");}
	;

Stmts:
	Stmts Stmt					{;}
	|%empty						{;}
	;

Stmt:
	Decl ';'	{printf(";\n");}
	|Expr ';'	{printf("");}


	|IF '(' Expr ')' 
	{
		printf("{\n");
		printf("if (%s==false) goto IF_END%d;\n", $3, $1);
	} 
	Stmt	
	{
		printf("}\n");
		printf("IF_END%d:\n", $1);
	}


	|WHILE 
	{
		printf("WHILE_BEGIN%d:\n", $1=whileLableCounter++);
		printf("{\n");
	}
	'(' Expr ')'
	{
		printf("if (%s==false) goto WHILE_END%d;\n", $4, $1);
	}
	Stmt                    
	{
		printf("goto WHILE_BEGIN%d;\n", $1);
		printf("}\n");
		printf("WHILE_END%d:\n", $1);
	}


	|FOR 
	{
		printf("FOR_BEGIN%d:\n", $1=forLableCounter++);
		printf("{\n");
	}
	'(' Expr ';' 
	{
		printf("FOR_CONDITION%d:\n", $1);
	}
	Expr 
	{
		printf("if(%s == false) goto FOR_END%d;\n", $7, $1);
		printf("goto FOR_CODE%d;\n", $1);
	}
	';' 
	{
		printf("FOR_STEP%d:\n", $1);
	}
	Expr
	{
		printf("goto FOR_CONDITION%d;\n", $1);
	}
	')'
	{
		printf("FOR_CODE%d:\n", $1);
	}
	Stmt    
	{
		printf("goto FOR_STEP%d;\n", $1);
		printf("}\n");
		printf("FOR_END%d:\n", $1);
	}


	|Block			{;}
	;

Decl:
	INT Ids			{printf("int %s", $2);}
	|DOUBLE Ids		{printf("double %s", $2);}
	;

Ids:    
	Ids ',' ID				{sprintf($$, "%s, %s", $$, $3);} 
	|Ids ',' ID '=' Expr	{sprintf($$, "%s, %s = %s", $$, $3, $5);}
	|ID						{sprintf($$, "%s",$1);}
	|ID '=' Expr			{sprintf($$, "%s = %s", $1, $3);}
	;

Expr:
	ID '=' Expr 	{strcpy($$, $3); printf("%s = %s;\n", $1, $3);}
	|Term			{strcpy($$, $1);}
	;

Term:
    Term LT Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|Term LTE Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|Term GT Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|Term GTE Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|Term EQ Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|Term NEQ Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|Term L_AND Term	{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|Term L_OR Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|L_NOT Term			{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s;\n", $$, $1, $2);}
	|Term B_AND Term	{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|Term B_OR Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}
	|B_NOT Term			{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s;\n", $$, $1, $2);}
	|Term B_XOR Term	{sprintf($$, "t%d", tempVar++); printf("int %s = %s %s %s;\n", $$, $1, $2, $3);}

	|Term '*' Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s * %s;\n", $$, $1, $3);}
	|Term '/' Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s / %s;\n", $$, $1, $3);}
	|Term '%' Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s % %s;\n", $$, $1, $3);}
	|Term '+' Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s + %s;\n", $$, $1, $3);}
	|Term '-' Term		{sprintf($$, "t%d", tempVar++); printf("int %s = %s - %s;\n", $$, $1, $3);}
	|'-' Term %prec NEGATION	{sprintf($$, "t%d", tempVar++); printf("int %s = -%s;\n", $$, $2);}
	|'(' Expr ')'    			{strcpy($$, $2);}
	|INTEGER_NUM   				{strcpy($$, $1);}
	|ID             			{strcpy($$, $1);}
	;


%%


void yyerror (char const *s) {
	fprintf(stderr, "===============================================================================\n");
	fprintf (stderr, "| ErrL_or => %-66s |\n",s);
	fprintf(stderr, "===============================================================================\n");
}

int yywrap(){
	return 1;
}

int main(){
	yyparse();
}