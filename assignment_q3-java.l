D		[0-9]
L		[a-zA-Z_$]
H		[a-fA-F0-9]
E		[Ee][+-]?{D}+
FS		(f|F|d|D)
IS		(l|L)

%{
#include <stdio.h>

void block_comment();
void line_comment();
void javadoc_comment();
%}

%%
"/**"			{ javadoc_comment(); }
"/*"			{ block_comment(); }
"//"			{ line_comment(); }

"abstract"		{ printf("KEYWORD\t\tabstract\n"); }
"assert"		{ printf("KEYWORD\t\tassert\n"); }
"boolean"		{ printf("KEYWORD\t\tboolean\n"); }
"break"			{ printf("KEYWORD\t\tbreak\n"); }
"byte"			{ printf("KEYWORD\t\tbyte\n"); }
"case"			{ printf("KEYWORD\t\tcase\n"); }
"catch"			{ printf("KEYWORD\t\tcatch\n"); }
"char"			{ printf("KEYWORD\t\tchar\n"); }
"class"			{ printf("KEYWORD\t\tclass\n"); }
"const"			{ printf("KEYWORD\t\tconst\n"); }
"continue"		{ printf("KEYWORD\t\tcontinue\n"); }
"default"		{ printf("KEYWORD\t\tdefault\n"); }
"do"			{ printf("KEYWORD\t\tdo\n"); }
"double"		{ printf("KEYWORD\t\tdouble\n"); }
"else"			{ printf("KEYWORD\t\telse\n"); }
"enum"			{ printf("KEYWORD\t\tenum\n"); }
"extends"		{ printf("KEYWORD\t\textends\n"); }
"false"			{ printf("KEYWORD\t\tfalse\n"); }
"final"			{ printf("KEYWORD\t\tfinal\n"); }
"finally"		{ printf("KEYWORD\t\tfinally\n"); }
"float"			{ printf("KEYWORD\t\tfloat\n"); }
"for"			{ printf("KEYWORD\t\tfor\n"); }
"goto"			{ printf("KEYWORD\t\tgoto\n"); }
"if"			{ printf("KEYWORD\t\tif\n"); }
"implements"		{ printf("KEYWORD\t\timplements\n"); }
"import"		{ printf("KEYWORD\t\timport\n"); }
"instanceof"		{ printf("KEYWORD\t\tinstanceof\n"); }
"int"			{ printf("KEYWORD\t\tint\n"); }
"interface"		{ printf("KEYWORD\t\tinterface\n"); }
"long"			{ printf("KEYWORD\t\tlong\n"); }
"native"		{ printf("KEYWORD\t\tnative\n"); }
"new"			{ printf("KEYWORD\t\tnew\n"); }
"null"			{ printf("KEYWORD\t\tnull\n"); }
"package"		{ printf("KEYWORD\t\tpackage\n"); }
"private"		{ printf("KEYWORD\t\tprivate\n"); }
"protected"		{ printf("KEYWORD\t\tprotected\n"); }
"public"		{ printf("KEYWORD\t\tpublic\n"); }
"return"		{ printf("KEYWORD\t\treturn\n"); }
"short"			{ printf("KEYWORD\t\tshort\n"); }
"static"		{ printf("KEYWORD\t\tstatic\n"); }
"strictfp"		{ printf("KEYWORD\t\tstrictfp\n"); }
"super"			{ printf("KEYWORD\t\tsuper\n"); }
"switch"		{ printf("KEYWORD\t\tswitch\n"); }
"synchronized"		{ printf("KEYWORD\t\tsynchronized\n"); }
"this"			{ printf("KEYWORD\t\tthis\n"); }
"throw"			{ printf("KEYWORD\t\tthrow\n"); }
"throws"		{ printf("KEYWORD\t\tthrows\n"); }
"transient"		{ printf("KEYWORD\t\ttransient\n"); }
"true"			{ printf("KEYWORD\t\ttrue\n"); }
"try"			{ printf("KEYWORD\t\ttry\n"); }
"void"			{ printf("KEYWORD\t\tvoid\n"); }
"volatile"		{ printf("KEYWORD\t\tvolatile\n"); }
"while"			{ printf("KEYWORD\t\twhile\n"); }

{L}({L}|{D})*		{ printf("IDENTIFIER\t%s\n", yytext); }

0[xX]{H}+{IS}?		{ printf("HEX_CONSTANT\t%s\n", yytext); }
0[bB][01]+{IS}?		{ printf("BIN_CONSTANT\t%s\n", yytext); }
0[0-7]+{IS}?		{ printf("OCT_CONSTANT\t%s\n", yytext); }
{D}+{IS}?		{ printf("INT_CONSTANT\t%s\n", yytext); }
'(\\.|[^\\'])' 		{ printf("CHAR_CONSTANT\t%s\n", yytext); }

{D}+{E}{FS}?		{ printf("FLOAT_CONSTANT\t%s\n", yytext); }
{D}*"."{D}+({E})?{FS}?	{ printf("FLOAT_CONSTANT\t%s\n", yytext); }
{D}+"."{D}*({E})?{FS}?	{ printf("FLOAT_CONSTANT\t%s\n", yytext); }

\"(\\.|[^\\"])*\"	{ printf("STRING_LITERAL\t%s\n", yytext); }

"..."			{ printf("OPERATOR\t...\n"); }
">>="			{ printf("OPERATOR\t>>=\n"); }
"<<="			{ printf("OPERATOR\t<<=\n"); }
">>>="			{ printf("OPERATOR\t>>>=\n"); }
">>>"			{ printf("OPERATOR\t>>>\n"); }
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
"&&"			{ printf("OPERATOR\t&&\n"); }
"||"			{ printf("OPERATOR\t||\n"); }
"<="			{ printf("OPERATOR\t<=\n"); }
">="			{ printf("OPERATOR\t>=\n"); }
"=="			{ printf("OPERATOR\t==\n"); }
"!="			{ printf("OPERATOR\t!=\n"); }
"->"			{ printf("OPERATOR\t->\n"); }
"::"			{ printf("OPERATOR\t::\n"); }
";"			{ printf("PUNCTUATION\t;\n"); }
"{"			{ printf("PUNCTUATION\t{\n"); }
"}"			{ printf("PUNCTUATION\t}\n"); }
","			{ printf("PUNCTUATION\t,\n"); }
":"			{ printf("PUNCTUATION\t:\n"); }
"="			{ printf("OPERATOR\t=\n"); }
"("			{ printf("PUNCTUATION\t(\n"); }
")"			{ printf("PUNCTUATION\t)\n"); }
"["			{ printf("PUNCTUATION\t[\n"); }
"]"			{ printf("PUNCTUATION\t]\n"); }
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
"@"			{ printf("OPERATOR\t@\n"); }

[ \t\v\n\f]		{ /* skip whitespace */ }
.			{ printf("UNKNOWN\t\t%s\n", yytext); }

%%

void javadoc_comment()
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

	printf("JAVADOC_COMMENT\n");
}

void block_comment()
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

void line_comment()
{
	char c;
	while ((c = input()) != '\n' && c != 0)
		;
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
