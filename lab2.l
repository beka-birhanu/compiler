%{
#include <stdio.h>
%}

%option noyywrap

digit  [0-9]
letter [A-Za-z]
id     {letter}({letter}|{digit})*

%%

{digit}+  { printf("number: %s\n", yytext); }
{id}      { printf("ident:  %s\n", yytext); }
.         { printf("other:  %s\n", yytext); }
\n        { /* skip newlines */ }

%%

int main(void) {
    yylex();
    return 0;
}
