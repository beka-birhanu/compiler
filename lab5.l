%{
/* Token type definitions */
#include <stdio.h>

#define IF     256
#define THEN   257
#define ELSE   258
#define ID     259
#define NUMBER 260
#define RELOP  261
#define LT     262
#define LE     263
#define EQ     264
#define NE     265
#define GT     266
#define GE     267

int yylval;

int install_id(void)  { return 0; }
int install_num(void) { return 0; }
%}

%option noyywrap

delim  [ \t\n]
ws     {delim}+
letter [A-Za-z]
digit  [0-9]
id     {letter}({letter}|{digit})*
number {digit}+(\.{digit}+)?(E[+\-]?{digit}+)?

%%

{ws}    { /* skip whitespace */ }
if      { return IF; }
then    { return THEN; }
else    { return ELSE; }
{id}    { yylval = install_id();  return ID; }
{number} { yylval = install_num(); return NUMBER; }
"<"     { yylval = LT; return RELOP; }
"<="    { yylval = LE; return RELOP; }
"="     { yylval = EQ; return RELOP; }
"<>"    { yylval = NE; return RELOP; }
">"     { yylval = GT; return RELOP; }
">="    { yylval = GE; return RELOP; }

%%

static const char *token_name(int tok) {
    switch (tok) {
        case IF:     return "IF";
        case THEN:   return "THEN";
        case ELSE:   return "ELSE";
        case ID:     return "ID";
        case NUMBER: return "NUMBER";
        case RELOP:  return "RELOP";
        default:     return "UNKNOWN";
    }
}

int main(void) {
    int tok;
    while ((tok = yylex()) != 0)
        printf("%-8s  %s\n", token_name(tok), yytext);
    return 0;
}
