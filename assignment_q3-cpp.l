D		[0-9]
L		[a-zA-Z_]
H		[a-fA-F0-9]
E		[Ee][+-]?{D}+
FS		(f|F|l|L)
IS		(u|U|l|L)*

%{
#include <stdio.h>

void block_comment();
void line_comment();
%}

%%
"/*"			{ block_comment(); }
"//"			{ line_comment(); }

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

"bool"			{ printf("KEYWORD\t\tbool\n"); }
"catch"			{ printf("KEYWORD\t\tcatch\n"); }
"class"			{ printf("KEYWORD\t\tclass\n"); }
"const_cast"		{ printf("KEYWORD\t\tconst_cast\n"); }
"constexpr"		{ printf("KEYWORD\t\tconstexpr\n"); }
"decltype"		{ printf("KEYWORD\t\tdecltype\n"); }
"delete"		{ printf("KEYWORD\t\tdelete\n"); }
"dynamic_cast"		{ printf("KEYWORD\t\tdynamic_cast\n"); }
"explicit"		{ printf("KEYWORD\t\texplicit\n"); }
"export"		{ printf("KEYWORD\t\texport\n"); }
"false"			{ printf("KEYWORD\t\tfalse\n"); }
"final"			{ printf("KEYWORD\t\tfinal\n"); }
"friend"		{ printf("KEYWORD\t\tfriend\n"); }
"inline"		{ printf("KEYWORD\t\tinline\n"); }
"mutable"		{ printf("KEYWORD\t\tmutable\n"); }
"namespace"		{ printf("KEYWORD\t\tnamespace\n"); }
"new"			{ printf("KEYWORD\t\tnew\n"); }
"noexcept"		{ printf("KEYWORD\t\tnoexcept\n"); }
"nullptr"		{ printf("KEYWORD\t\tnullptr\n"); }
"operator"		{ printf("KEYWORD\t\toperator\n"); }
"override"		{ printf("KEYWORD\t\toverride\n"); }
"private"		{ printf("KEYWORD\t\tprivate\n"); }
"protected"		{ printf("KEYWORD\t\tprotected\n"); }
"public"		{ printf("KEYWORD\t\tpublic\n"); }
"reinterpret_cast"	{ printf("KEYWORD\t\treinterpret_cast\n"); }
"static_assert"		{ printf("KEYWORD\t\tstatic_assert\n"); }
"static_cast"		{ printf("KEYWORD\t\tstatic_cast\n"); }
"template"		{ printf("KEYWORD\t\ttemplate\n"); }
"this"			{ printf("KEYWORD\t\tthis\n"); }
"thread_local"		{ printf("KEYWORD\t\tthread_local\n"); }
"throw"			{ printf("KEYWORD\t\tthrow\n"); }
"true"			{ printf("KEYWORD\t\ttrue\n"); }
"try"			{ printf("KEYWORD\t\ttry\n"); }
"typeid"		{ printf("KEYWORD\t\ttypeid\n"); }
"typename"		{ printf("KEYWORD\t\ttypename\n"); }
"using"			{ printf("KEYWORD\t\tusing\n"); }
"virtual"		{ printf("KEYWORD\t\tvirtual\n"); }
"wchar_t"		{ printf("KEYWORD\t\twchar_t\n"); }

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
"->*"			{ printf("OPERATOR\t->*\n"); }
"->="			{ printf("OPERATOR\t->*\n"); }
">>="			{ printf("OPERATOR\t>>=\n"); }
"<<="			{ printf("OPERATOR\t<<=\n"); }
"::"			{ printf("OPERATOR\t::\n"); }
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
".*"			{ printf("OPERATOR\t.*\n"); }
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
