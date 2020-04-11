digit [0-9]
alpha [a-zA-Z]
%%
[ \t] ;
[ \n]   { yylineno = yylineno + 1;}
int return INT;
float return FLOAT;
char return CHAR;
void return VOID;
for return FOR;
while return WHILE;
switch return SWITCH;
case return CASE;
break return BREAK;
default return DEFAULT;
if return IF;
else return ELSE;
scanf return SCANF;
printf  return PRINTF;
return return RETURN;
"%d"|"%s"|"%c"|"%d"|"%f" return ESC;
"," return COMMA;
"&" return AMP;
"\"" return QUOTE;
struct return STRUCT;
^"#include ".+ ;
{digit}+       return NUM;
{alpha}({alpha}|{digit})* return ID;
"&&"    return AND;
"||"    return OR;
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
\/\/.* ;
\/\*(.*\n)*.*\*\/ ;
.       return yytext[0];
%%


