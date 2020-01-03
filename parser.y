%{
    #include"parser.tab.h"
    #include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include<ctype.h>

	int whileLableCounter = 0;
	int forLableCounter = 0;
	int ifLableCounter = 0;

	void yyerror (char const *s);
%}
%start Program 						//The start symbol of the grammar
%union{
    char str[120];
}


/*Keywords*/
%token INT DOUBLE					//token for Type decleration
%token WHILE FOR IF					//statment
%token <str> LT LTE GT GTE EQ NEQ	//Tokens for Relational Operators
%token <str> AND OR NOT				//Tokens Logical Operators


/*Data type tokens*/
%token <str> ID
%token <str> INTEGER_NUM
%token <str> DOUBLE_NUM


/*Grammar's Variable(Non-terminal) types*/
%type <str> Term
%type <str> Factor


/*Operator Associativity and Precedence*/
%right '='
%left EQ NEQ
%left LT LTE GT GTE

%left OR
%left AND
%left '-' '+'
%left '*' '/' '%'
%left NEGATION
%left NOT


%%

Program:
        Block   {;}
        ;

Block: 
        '{' Stmts '}'     {;}
        ;

Stmts:
        Stmts Stmt					{;}
        |%empty						{;}
        ;

Stmt:
		Decl ';'
        |Expr ';'
        |IF '(' Expr ')' Stmt                       {;}
        |FOR '(' Expr ';' Expr ';' Expr ')' Stmt    {;}
        |WHILE '(' Expr ')' Stmt                    {;}
        |Block                                      {;}
        ;

Decl:
        INT Ids			{;}
		|DOUBLE Ids		{;}
        ;

Ids:    
        Ids ',' ID				{;} 
        |Ids ',' ID '=' Expr	{;}
		|ID						{;}
		|ID '=' Expr			{;}
        ;

Expr:
		Rel '=' Expr    {;}
        |Rel            {;}
        ;

Rel:    
        Rel LT Term		{;}
		|Rel LTE Term	{;}
		|Rel GT Term	{;}
		|Rel GTE Term	{;}
		|Rel EQ Term	{;}
		|Rel NEQ Term	{;}
		|NOT Term		{;}
        |Term			{;}
        ;

Term:
        Term '*' Factor	    {;}
        |Term '/' Factor    {;}
		|Term '%' Factor    {;}
        |Term '+' Factor    {;}
        |Term '-' Factor    {;}
		|Term AND Factor	{;}
		|Term OR Factor		{;}
		|'-' Factor %prec NEGATION	{;}
		|Factor
        ;

Factor:
        '(' Expr ')'    {;}
        |INTEGER_NUM   	{;}
        |ID             {;}
        ;


%%


void yyerror (char const *s) {
	fprintf(stderr, "===============================================================================\n");
	fprintf (stderr, "| Error => %-66s |\n",s);
	fprintf(stderr, "===============================================================================\n");
}

int yywrap(){
	return 1;
}

int main(){
	yyparse();
}