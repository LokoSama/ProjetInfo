%{ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "table.h"
#include "asm.h"
#include "boucle.h"

// TODO : Affectation , Invocation, if, while ... 
int yylex(void);
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }

int depth_act;

%}
 
%union {
	int xInt;	
	float xFloat;
	char * str;
}
%start Start

%error-verbose
%token tAo
%token tAf
%token tPo
%token tPf
%token tCo
%token tCf
%token <str>tId
%token <xInt>tNb
%token tIf

%token <xInt> tInt
%token tPvir
%token tElse
%token tVir
%token tWhile
%token tReturn
%token tEqLog
%token tInclude
%token tConst
%token tMain
%token <xFloat> tFloat

%right tEq
%right tInf tSup
%left tPlus tMoins
%left tStar tDiv
%left tOr tAnd
%left tNot

/* TODO : déclaration de fonctions
					invocation de fonctions
					pointeurs ?
					
*/

%%
Start : Fonction Start {printf("Start\n");}
|
;
Fonction : tInt tId tPo Args tPf Body
;
Args :
	  | Arg ListeArgs
;

ListeArgs : tVir Arg ListeArgs
		  | //peut être vide
;

Arg : tInt tId
;

Body : tAo {depth_act = augmentation_profondeur(depth_act);} Instrus tAf {depth_act = Suppression_symboles(depth_act);}
;

Instrus : 
    | Instru Instrus 
;
Instru : Declaration 
    | BoucleIf
    | While
    | Affectation
    | Invocation
;
Invocation : tId tPo Params tPf tPvir
;
Param : ExpArithm
;
Params : 
| Param
    | Param tVir ParamsNext
;

ParamsNext : Param
| Param tVir ParamsNext
;

BoucleIf : If Else
;

If :  tIf tPo ExpArithm tPf {Jump(JMPC);} Body {tab_code.tab[depiler()][1] = tab_code.index +1; Jump(JMP);}
;

Else : {tab_code.tab[depiler()][1] = tab_code.index;}
		| tElse Body {tab_code.tab[depiler()][1] = tab_code.index;}
;

While : tWhile tPo ExpArithm tPf {empiler(tab_code.index); Jump(JMPC);} Body {tab_code.tab[depiler()][1] = tab_code.index +1; add_instru(JMP, depiler(), NOTU, NOTU);}
;

ExpArithm : ExpArithm tPlus ExpArithm {OperationArith(ADD);}
    | ExpArithm tMoins ExpArithm 			{OperationArith(SOU);}
    | ExpArithm tStar ExpArithm 			{OperationArith(MUL);}
    | ExpArithm tDiv ExpArithm 				{OperationArith(DIV);}
    | ExpArithm tOr ExpArithm 				{Or();}
    | ExpArithm tAnd ExpArithm 				{And();}
    | ExpArithm tEq tEq ExpArithm			{ComparaisonLogique(EQU);}
    | ExpArithm tInf ExpArithm				{ComparaisonLogique(INF);}
    | ExpArithm tSup ExpArithm				{ComparaisonLogique(SUP);}
    | ExpArithm tInf tEq ExpArithm		{ComparaisonLogique(INFE);}
    | ExpArithm tSup tEq ExpArithm		{ComparaisonLogique(SUPE);}
    | tNot ExpArithm									{Not();}
    | tPo ExpArithm tPf								//rien à faire
    | tNb															{add_instru(AFC, 0, $1, NOTU);
    																	 add_instru(STORE, tab_sym.tmp_var, 0, NOTU);
    																	 tab_sym.tmp_var++;}
    | tId 														{add_instru(LOAD, 0, index_of($1), NOTU);
    																	 add_instru(STORE, tab_sym.tmp_var, 0, NOTU);
    																	 tab_sym.tmp_var++;}
    | Invocation											//TODO
;

Affectation : tId tEq ExpArithm tPvir {Affecte($1);}
;

Declaration : tInt Decls tPvir 
;

Decl1: tId			 {Ajout_symbole (0,$1, depth_act);}
	|tId tEq ExpArithm  {Ajout_symbole (1,$1, depth_act);}
	
;
Decls : Decl1
    | Decl1 tVir Decls
;

%%

int main(void) {
	  depth_act = Init_table();
	  Init_asm();
	  yyparse();
	  print_code();
	  print_table(3);
}
