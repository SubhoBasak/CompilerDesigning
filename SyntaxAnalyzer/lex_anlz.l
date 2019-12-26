L [a-zA-Z_]
D [0-9]

%{
	#include <stdio.h>

	#define IDENTIFIER 258
	#define CONSTANT 259
	#define EQ_TO 260
	#define OPERATOR 261
	#define SEMICOLON 262

	extern char input_str[];
	int done = 0;

	#define preturn(val) { \
		printf("Lexem = [%s] Size = %d Token is %s\n", \
			yytext, yyleng, #val); return(val); }

	#define YY_INPUT(buf, result, maxsize) { \
			if(done){ \
				result = 0; } \
			else{ \
				strcpy(buf, input_str); \
				result = strlen(input_str); }\
			done = 1; \
		}

%}

%%

{L}({L}|{D})*	{ preturn(IDENTIFIER); }
{D}+		{ preturn(CONSTANT); }
"="		{ preturn(EQ_TO); }
"+"		{ preturn(OPERATOR); }
"-"		{ preturn(OPERATOR); }
"*"		{ preturn(OPERATOR); }
"/"		{ preturn(OPERATOR); }
";"		{ preturn(SEMICOLON); }
[ \n\t]		{ ; }
.		{ ; }

%%

int yywrap(){
	return(1);
}
