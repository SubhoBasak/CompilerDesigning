LETTER [A-Za-z]
DIGIT [0-9]
WS [ \n\t]

%{
    #define INT_TOKEN 1
    #define CHAR_TOKEN 2
    #define FLOAT_TOKEN 3
    #define IDENTIFIER_TOKEN 4
%}

%%

"int" {return (INT_TOKEN);}
"char" {return (CHAR_TOKEN);}
"float" {return (FLOAT_TOKEN);}
{LETTER}({LETTER}|{DIGIT})* {return (IDENTIFIER_TOKEN);}
{WS} {;}
. {;}

%%

#include <stdio.h>

int main(int argc, char **argv){
    FILE *fp;
    int ret_val;

    if(argc != 2){
        printf("Usage %s <input file>", argv[0]);
        exit(1);
    }

    fp = fopen(argv[1], "r");

    if(fp == NULL){
        printf("File %s not exist", argv[1]);
        exit(1);
    }

    yyin = fp;

    while(1){
        if((ret_val = yylex()) == 0){
            break;
        }

        switch(ret_val){
            case INT_TOKEN:
                printf("Lexem = [%s] \t Size = %d Token is INT_TOKEN\n", yytext, yyleng);
                break;

            case CHAR_TOKEN:
                printf("Lexem = [%s] \t Size = %d Token is CHAR_TOKEN\n", yytext, yyleng);
                break;

            case FLOAT_TOKEN:
                printf("Lexem = [%s] \t Size = %d Token is FLOAT_TOKEN\n", yytext, yyleng);
                break;

            case IDENTIFIER_TOKEN:
                printf("Lexem = [%s] \t Size = %d Token is IDENTIFIER_TOKEN\n", yytext, yyleng);
                break;

        }
    }

    return 0;
}
