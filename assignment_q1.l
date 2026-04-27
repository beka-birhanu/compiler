%option noyywrap

%{
#include <stdio.h>

int total = 0;
int vowel_count = 0;
%}

%%

[aeiouAEIOU]  { vowel_count++; total++; }
[a-zA-Z]      { total++; }
.             { /* ignore */ }
\n            { /* ignore */ }

%%

int main(void) {
    yylex();
    printf("Consonants: %d\n", total - vowel_count);
    printf("Vowels:     %d\n", vowel_count);
    return 0;
}
