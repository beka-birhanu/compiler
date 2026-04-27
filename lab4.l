%{
#include <stdio.h>
int nchar = 0, nword = 0, nline = 0;
%}

%option noyywrap

%%

\n           { nline++; nchar++; }
[^ \t\n]+    { nword++; nchar += yyleng; }
.            { nchar++; }

%%

int main(void) {
    yylex();
    printf("chars: %d\twords: %d\tlines: %d\n", nchar, nword, nline);
    return 0;
}
