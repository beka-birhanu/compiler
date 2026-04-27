%{
#include <stdio.h>
int count = 0;
%}

%option noyywrap

digit  [0-9]
letter [A-Za-z]

%%

{letter}({letter}|{digit})*  { count++; }
.|\n                          { /* ignore non-identifiers */ }

%%

int main(void) {
    yylex();
    printf("The number of identifiers are = %4d\n", count);
    return 0;
}
