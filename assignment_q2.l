%option noyywrap

%{
#include <stdio.h>
#include <string.h>
int positive_n_count = 0;
int negative_n_count = 0;
int positive_i_count = 0;
int negative_i_count = 0;
%}

digit       [0-9]
pos_integer {digit}+
neg_integer -{digit}+
pos_number  {digit}+(\.{digit}+([Ee][+-]?{digit}+)?)?
neg_number  -{pos_number}

%%

{neg_number}  { negative_n_count++; if (!strchr(yytext, '.')) negative_i_count++; }
{pos_number}  { positive_n_count++; if (!strchr(yytext, '.')) positive_i_count++; }
.             { /* ignore */ }
\n            { /* ignore */ }

%%

int main(void) {
    yylex();
    printf("Positive numbers:  %d\n", positive_n_count);
    printf("Negative numbers:  %d\n", negative_n_count);
    printf("Positive integers: %d\n", positive_i_count);
    printf("Negative integers: %d\n", negative_i_count);
    return 0;
}
