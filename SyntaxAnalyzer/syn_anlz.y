%token IDENTIFIER CONSTANT EQ_TO OPERATOR SEMICOLON
%start statement

%{
	#include <stdio.h>
	#include <string.h>

	extern int yylex();
	int yyerror(char *s);

%}

%%

statement : IDENTIFIER EQ_TO expression SEMICOLON { printf("statement encounter\n"); }
	  ;

expression : CONSTANT { printf("constant encounter\n"); }
	   ;

expression : IDENTIFIER { printf("identifier encounter\n"); }
	   ;

expression : expression OPERATOR expression { printf("sub-expression encounter\n"); }
	   ;

%%

int yydebug = 0;
char input_str[500];

int yyerror(char *s){
	printf("%s", input_str);
	fflush(stdout);
	printf("\n%s\n", s);
	return(1);
}

int main(int argc, char **argv){
	int ret_val;

	if(argc != 2){
		printf("Usage : %s <_statement_>\n", argv[0]);
		return (1);
	}

	strcpy(input_str, argv[1]);

	ret_val = yyparse();

	if(ret_val == 0){
		printf("%s\nSyntax correct [O]\n", input_str);
	}
	else{
		printf("Syntax incorrect [X]\n");
	}

	return (0);
}
