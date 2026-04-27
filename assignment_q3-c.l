D		[0-9]
L		[a-zA-Z_]
H		[a-fA-F0-9]
E		[Ee][+-]?{D}+
FS		(f|F|l|L)
IS		(u|U|l|L)*

%{
#include <stdio.h>

void comment();
%}

%%
"/*"			{ comment(); }

"auto"			{ printf("KEYWORD\t\tauto\n"); }
"break"			{ printf("KEYWORD\t\tbreak\n"); }
"case"			{ printf("KEYWORD\t\tcase\n"); }
"char"			{ printf("KEYWORD\t\tchar\n"); }
"const"			{ printf("KEYWORD\t\tconst\n"); }
"continue"		{ printf("KEYWORD\t\tcontinue\n"); }
"default"		{ printf("KEYWORD\t\tdefault\n"); }
"do"			{ printf("KEYWORD\t\tdo\n"); }
"double"		{ printf("KEYWORD\t\tdouble\n"); }
"else"			{ printf("KEYWORD\t\telse\n"); }
"enum"			{ printf("KEYWORD\t\tenum\n"); }
"extern"		{ printf("KEYWORD\t\textern\n"); }
"float"			{ printf("KEYWORD\t\tfloat\n"); }
"for"			{ printf("KEYWORD\t\tfor\n"); }
"goto"			{ printf("KEYWORD\t\tgoto\n"); }
"if"			{ printf("KEYWORD\t\tif\n"); }
"int"			{ printf("KEYWORD\t\tint\n"); }
"long"			{ printf("KEYWORD\t\tlong\n"); }
"register"		{ printf("KEYWORD\t\tregister\n"); }
"return"		{ printf("KEYWORD\t\treturn\n"); }
"short"			{ printf("KEYWORD\t\tshort\n"); }
"signed"		{ printf("KEYWORD\t\tsigned\n"); }
"sizeof"		{ printf("KEYWORD\t\tsizeof\n"); }
"static"		{ printf("KEYWORD\t\tstatic\n"); }
"struct"		{ printf("KEYWORD\t\tstruct\n"); }
"switch"		{ printf("KEYWORD\t\tswitch\n"); }
"typedef"		{ printf("KEYWORD\t\ttypedef\n"); }
"union"			{ printf("KEYWORD\t\tunion\n"); }
"unsigned"		{ printf("KEYWORD\t\tunsigned\n"); }
"void"			{ printf("KEYWORD\t\tvoid\n"); }
"volatile"		{ printf("KEYWORD\t\tvolatile\n"); }
"while"			{ printf("KEYWORD\t\twhile\n"); }

{L}({L}|{D})*		{ printf("IDENTIFIER\t%s\n", yytext); }

0[xX]{H}+{IS}?		{ printf("HEX_CONSTANT\t%s\n", yytext); }
0[0-7]+{IS}?		{ printf("OCT_CONSTANT\t%s\n", yytext); }
{D}+{IS}?		{ printf("INT_CONSTANT\t%s\n", yytext); }
L?'(\\.|[^\\'])+'	{ printf("CHAR_CONSTANT\t%s\n", yytext); }

{D}+{E}{FS}?		{ printf("FLOAT_CONSTANT\t%s\n", yytext); }
{D}*"."{D}+({E})?{FS}?	{ printf("FLOAT_CONSTANT\t%s\n", yytext); }
{D}+"."{D}*({E})?{FS}?	{ printf("FLOAT_CONSTANT\t%s\n", yytext); }

L?\"(\\.|[^\\"])*\"	{ printf("STRING_LITERAL\t%s\n", yytext); }

"..."			{ printf("OPERATOR\t...\n"); }
">>="			{ printf("OPERATOR\t>>=\n"); }
"<<="			{ printf("OPERATOR\t<<=\n"); }
"+="			{ printf("OPERATOR\t+=\n"); }
"-="			{ printf("OPERATOR\t-=\n"); }
"*="			{ printf("OPERATOR\t*=\n"); }
"/="			{ printf("OPERATOR\t/=\n"); }
"%="			{ printf("OPERATOR\t%%=\n"); }
"&="			{ printf("OPERATOR\t&=\n"); }
"^="			{ printf("OPERATOR\t^=\n"); }
"|="			{ printf("OPERATOR\t|=\n"); }
">>"			{ printf("OPERATOR\t>>\n"); }
"<<"			{ printf("OPERATOR\t<<\n"); }
"++"			{ printf("OPERATOR\t++\n"); }
"--"			{ printf("OPERATOR\t--\n"); }
"->"			{ printf("OPERATOR\t->\n"); }
"&&"			{ printf("OPERATOR\t&&\n"); }
"||"			{ printf("OPERATOR\t||\n"); }
"<="			{ printf("OPERATOR\t<=\n"); }
">="			{ printf("OPERATOR\t>=\n"); }
"=="			{ printf("OPERATOR\t==\n"); }
"!="			{ printf("OPERATOR\t!=\n"); }
";"			{ printf("PUNCTUATION\t;\n"); }
("{"|"<%")		{ printf("PUNCTUATION\t{\n"); }
("}"|"%>")		{ printf("PUNCTUATION\t}\n"); }
","			{ printf("PUNCTUATION\t,\n"); }
":"			{ printf("PUNCTUATION\t:\n"); }
"="			{ printf("OPERATOR\t=\n"); }
"("			{ printf("PUNCTUATION\t(\n"); }
")"			{ printf("PUNCTUATION\t)\n"); }
("["|"<:")		{ printf("PUNCTUATION\t[\n"); }
("]"|":>")		{ printf("PUNCTUATION\t]\n"); }
"."			{ printf("OPERATOR\t.\n"); }
"&"			{ printf("OPERATOR\t&\n"); }
"!"			{ printf("OPERATOR\t!\n"); }
"~"			{ printf("OPERATOR\t~\n"); }
"-"			{ printf("OPERATOR\t-\n"); }
"+"			{ printf("OPERATOR\t+\n"); }
"*"			{ printf("OPERATOR\t*\n"); }
"/"			{ printf("OPERATOR\t/\n"); }
"%"			{ printf("OPERATOR\t%%\n"); }
"<"			{ printf("OPERATOR\t<\n"); }
">"			{ printf("OPERATOR\t>\n"); }
"^"			{ printf("OPERATOR\t^\n"); }
"|"			{ printf("OPERATOR\t|\n"); }
"?"			{ printf("OPERATOR\t?\n"); }

[ \t\v\n\f]		{ /* skip whitespace */ }
.			{ printf("UNKNOWN\t\t%s\n", yytext); }

%%

void comment()
{
	char c, c1;

loop:
	while ((c = input()) != '*' && c != 0)
		;

	if ((c1 = input()) != '/' && c != 0)
	{
		unput(c1);
		goto loop;
	}

	printf("COMMENT\n");
}

int yywrap()
{
	return 1;
}

int main()
{
	yylex();
	return 0;
}
