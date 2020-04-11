%{
#include <stdio.h>
#include<string.h>
#include <stdlib.h>
%}
%token LE GE EQ NE OR AND INT FLOAT CHAR VOID FOR WHILE IF ELSE PRINTF SCANF STRUCT NUM ID INCLUDE SWITCH CASE DEFAULT BREAK QUOTE ESC AMP COMMA RETURN
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'
%%
Q:S
;
S: f    |Type E ';'
| E ';'  
| call ';'
| ID'['E']' ';'
| Type ID'['E']' ';'  

    | sw
|'*' ID ';'
|Type '*' ID ';'
;
f:
func f
|structure f
|func f structure f
|
;
E: ID '=' E
| ID '=' call
| ID '=' ID'['E']'
| ID'['E']' '=' E
| E ',' E
| E '+' E
| E '-' E
| E '*' E
| E '/' E
| E '<' E
| E'>' E
| E LE E
| E GE E
| E EQ E
| E NE E
    | E OR E
    | E AND E
    | E '+' '+'
    | E '-' '-'
| '(' E ')'
| '-' NUM
| '-' ID
|   NUM
|   ID
| ID '['E']'
|'*' ID
|'&' ID
;
sw  : SWITCH '(' ID ')' '{' B '}'
    ;
call : ID'('')'
| ID'('E')'

;
B   : C
    | C D
|
    ;
C   : C C
    | CASE NUM ':' E ';' BREAK ';'
|
    ;
D   : DEFAULT  ':' E ';' BREAK ';'
    ;

func: Type ID '(' ArgListOpt ')' DES
;
DES:'{' Stmt RETURN ID ';' '}'
|'{' Stmt RETURN NUM ';' '}'
|'{' Stmt '}'
|'{' Stmt RETURN ID'['E']' '}'
;
ArgListOpt: Type ID V
|Type '*' ID V
|
;
V:V COMMA Type ID
|V COMMA Type '*' ID 
|
;
Stmt: Stmt Stmt
    | WhileStmt
| Type E ';'
| E ';'  
| call ';'
| ID'['E']' ';'
| Type ID'['E']' ';'  
| structure ';'
| ForStmt
| IfStmt
| PRINTF '(' G ')' ';'
    | SCANF '(' Ex ')' ';'
| ';'
    |sw

|Type E2
|
;
E2:ID
|NUM
|E2 COMMA E2
|ID'['NUM']'
|
;
Stmt2:
    WhileStmt
| Type E ';'
| E ';'  
| call ';'
| ID'['E']' ';'
| Type ID'['E']' ';'  
| structure ';'
| ForStmt
| IfStmt
| PRINTF '(' G ')' ';'
    | SCANF '(' Ex ')' ';'
| ';'
    |sw
|
;
Ex:QUOTE ESC IK QUOTE L
|
;
IK:ESC IK
|ESC
|
;
L:L COMMA AMP ID
|
;
G:QUOTE ESC IK QUOTE H
|E
|
|QUOTE E QUOTE
;
H:H COMMA ID
|H COMMA AMP ID
|H COMMA '*'
|
;
Type: INT
| FLOAT
| CHAR
| VOID

;
WhileStmt : WHILE '(' E ')' DEF  
;
ForStmt : FOR '(' E ';' E ';' E ')' DEF
       | FOR '(' E ')' DEF
;
DEF : '{' Stmt '}'
|
Stmt2
;
IfStmt : IF '(' E ')' DEF
|IF '(' E ')' DEF ElseStmt
|IF '(' E ')' DEF Elseif
;
ElseStmt:ELSE DEF
;
Elseif:Elseif ELSE IF '(' E ')' DEF ElseStmt
|
;
structure : STRUCT ID '{' Type E ';''}'';'  
;
%%
#include"lex.yy.c"
int main()
{
yyin = fopen("a.txt", "r");

  if(!yyparse())
{
printf("parsing done");
}
else
{
printf("error\n");
}
    return 0;
}
yyerror(char *s) {
//printf("error\n");
printf("%d %s  %s\n",yylineno,s,yytext);
}        



