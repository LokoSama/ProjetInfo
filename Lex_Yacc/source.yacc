%{ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "table.h"
#include "asm.h"
#include "boucle.h"
#include "fonctions.h"


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
%token <str> tId
%token <xInt> tNb
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

%type <xInt> Params Param ParamsNext


%%
Start : Fonction Start {printf("Start\n");}
			| //peut être vide
;

Fonction : tInt tMain {set_mainJump();} tPo Args tPf BodyReturnMain
			| tInt tId {ajout_fonction($2, tab_code.index);} tPo Args tPf {lire_args($2);} BodyReturn
;

Args : Arg ListeArgs {incremente_nb_args();}
			| //peut être vide
;

ListeArgs : tVir Arg ListeArgs {incremente_nb_args();}
		  | //peut être vide
;

Arg : tInt tId {Ajout_symbole(1, $2, depth_act+1);}
;

BodyReturnMain : tAo {depth_act = augmentation_profondeur(depth_act);} Instrus ReturnMain tAf {depth_act = Suppression_symboles(depth_act);}
;

ReturnMain : tReturn ExpArithm tPvir {
																				add_instru(LOADR, 0, BP, tab_sym.tmp_var - 1);		//R0 <- valeur de retour
																				print_code();
																				print_table(5);
																				exit(0);
																		 }
;

BodyReturn : tAo {depth_act = augmentation_profondeur(depth_act);} Instrus Return tAf {print_table(3);depth_act = Suppression_symboles(depth_act);}
;

Return : tReturn ExpArithm tPvir {
																		add_instru(LOADR, 0, BP, tab_sym.tmp_var - 1);		//R0 <- valeur de retour
																		add_instru(LOADR, 1, BP, -2);											//R1 <- adresse de retour
																		add_instru(LOADR, BP, BP, -1);										//récupération old_BP
																		add_instru(JMPR, 1, NOTU, NOTU);
																 }
;

Body : tAo {depth_act = augmentation_profondeur(depth_act);} Instrus tAf {depth_act = Suppression_symboles(depth_act);}
;

Instrus :  Instru Instrus 
		    | //peut être vide	
;
Instru : Declaration 
    | BoucleIf
    | While
    | Affectation
    | Invocation tPvir													{}
;
Invocation : tId tPo Params tPf									{
																									if($3 != get_nb_args($1)){
																										printf("Argument invalid\n");
																									}
																									else {
																										empiler_contexte(tab_code.index + 5); //on empile l'adresse de retour
																										tab_sym.tmp_var -= $3;								//on baisse le pointeur tmp_var: les variables qui étaient tmp font maintenant partie du contexte
																										add_instru(JMP, tab_fonctions.tab[get_index($1)].index_definition, NOTU, NOTU);
																									}
																								}
;
Param : ExpArithm {$$=1;}
;
Params : {$$=0;} 
| Param {$$=1;}
    | Param tVir ParamsNext {$$ = 1 + $3;}
;

ParamsNext : Param {$$=1;}
| Param tVir ParamsNext {$$ = 1 + $3;}
;

BoucleIf : If Else
;

If :  tIf tPo ExpArithm tPf {Jump(JMPC);} Body {tab_code.tab[depiler()][1] = tab_code.index +1; Jump(JMP);}
;

Else : /*rien*/ {tab_code.tab[depiler()][1] = tab_code.index;}
		| tElse Body {tab_code.tab[depiler()][1] = tab_code.index;}
;

While : tWhile {empiler(tab_code.index);} /*repositionnement de l index du jump */ tPo ExpArithm tPf {Jump(JMPC);} Body {tab_code.tab[depiler()][1] = tab_code.index +1; add_instru(JMP, depiler(), NOTU, NOTU);}
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
    																	 add_instru(STORR, BP, tab_sym.tmp_var, 0);
    																	 tab_sym.tmp_var++;}
    | tId 														{add_instru(LOADR, 0, BP, index_of($1));
    																	 add_instru(STORR, BP, tab_sym.tmp_var, 0);
    																	 tab_sym.tmp_var++;}
    | Invocation											{add_instru(STORR, BP, tab_sym.tmp_var, 0);
    																	 tab_sym.tmp_var++;}
;

Affectation : tId tEq ExpArithm tPvir {Affecte($1);}
;

Declaration : tInt Decls tPvir 
;

Decl1: tId						{Ajout_symbole (0,$1, depth_act);}
	|tId tEq ExpArithm  {Ajout_symbole (1,$1, depth_act);}
	
;
Decls : Decl1
    | Decl1 tVir Decls
;

%%

int main(void) {
	  depth_act = Init_table();
	  Init_asm();
	  Init_tab_boucle();
	  Init_fonctions();
	  yyparse();
}

