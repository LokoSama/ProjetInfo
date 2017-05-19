#include "asm.h"

void
Init_asm ()
{
// Tableau contenant le code ASM
  tab_code.index = 0;
}

//ajout d'une instruction a b c d à la fin du code
void
add_instru (int a, int b, int c, int d)
{
  tab_code.tab[tab_code.index][0] = a;
  tab_code.tab[tab_code.index][1] = b;
  tab_code.tab[tab_code.index][2] = c;
  tab_code.tab[tab_code.index][3] = d;
  tab_code.index++;
}

//TODO Le résultat de l'addition est stocké dans R0 pour le moment, le mettre dans $$ ?
//typeOperation = ADD, MUL, SOU, DIV
void
OperationArith (int typeOperation)
{
  //on récupère les valeurs dans la mémoire tmp
  add_instru (LOAD, 0, tab_sym.tmp_var - 1, NOTU);
  add_instru (LOAD, 1, tab_sym.tmp_var - 2, NOTU);
  //on effectue l'opération arithmétique et on stocke le résultat dans tmp
  add_instru (typeOperation, 0, 0, 1);
  //stockage du résultat
  add_instru (STORE, tab_sym.tmp_var - 2, 0, NOTU);
  tab_sym.tmp_var--;
}

void Or() {
	//on récupère les valeurs dans la mémoire tmp
  add_instru (LOAD, 0, tab_sym.tmp_var - 1, NOTU);
  add_instru (LOAD, 1, tab_sym.tmp_var - 2, NOTU);
  //on effectue l'opération logique
  add_instru(AFC, 2, 0, NOTU);
  add_instru(EQU, 0, 0, 2);
  add_instru(EQU, 1, 1, 2);
  add_instru(MUL, 0, 0, 1);
  add_instru(EQU, 0, 0, 2);
  //stockage du résultat
	add_instru(STORE, tab_sym.tmp_var -2, 0, NOTU);
	tab_sym.tmp_var--;
}

void And() {
	//on récupère les valeurs dans la mémoire tmp
  add_instru (LOAD, 0, tab_sym.tmp_var - 1, NOTU);
  add_instru (LOAD, 1, tab_sym.tmp_var - 2, NOTU);
  //on effectue l'opération logique
  add_instru(AFC, 2, 0, NOTU);
  add_instru(EQU, 1, 1, 2); //R1 = ((R1 == 0) == 0);
  add_instru(EQU, 1, 1, 2);
  add_instru(MUL, 0, 0, 1);
  //stockage du résultat
	add_instru(STORE, tab_sym.tmp_var -2, 0, NOTU);
	tab_sym.tmp_var--;
}

//les operateurs valides sont : EQU, INF, INFE, SUP, SUPE
void ComparaisonLogique(int operateur) {
	//on récupère les valeurs dans la mémoire tmp
  add_instru (LOAD, 0, tab_sym.tmp_var - 1, NOTU);
  add_instru (LOAD, 1, tab_sym.tmp_var - 2, NOTU);
  //on effectue l'opération logique
  add_instru(operateur, 0, 0, 1);
  //stockage du résultat
	add_instru(STORE, tab_sym.tmp_var -2, 0, NOTU);
	tab_sym.tmp_var--;      	
}

void Not(){
//on récupère la valeur dans la mémoire tmp
add_instru (LOAD, 0, tab_sym.tmp_var - 1, NOTU);;
//on effectue l'opération logique
add_instru(AFC,1,0,NOTU);
add_instru(EQU,0,0,1);
add_instru(STORE, tab_sym.tmp_var -1, 0, NOTU);
}

void Jump(int typeJump) { //typeJump attend JMP ou JMPC
	switch (typeJump) {
		case JMP:
			empiler(tab_code.index);
			add_instru(JMP, -2, NOTU, NOTU);
			break;
		case JMPC:
			//on récupère la condition dans la mémoire tmp
			add_instru(AFC, 1, 0, NOTU);
			add_instru(LOAD, 0, tab_sym.tmp_var - 1, NOTU);
			add_instru(EQU, 0, 0, 1); //on inverse le booléen "condition" (R0)
			empiler(tab_code.index); //on empile l'index de la ligne de code asm actuelle pour y retourner
			add_instru(JMPC, -2, 0, NOTU);
			tab_sym.tmp_var--;
			break;
		default:
			printf("Erreur dans asm.c/Jump: argument typeJump incorrect\n");
			break;
	}
}

void
print_code ()
{
  FILE *asmcode;
  printf ("ENTREE print_code\n");
  asmcode = fopen ("./code.asm", "w+");
  int i;
  for (i = 0; i < tab_code.index; i++)
    {
      if (tab_code.tab[i][2] == NOTU)
      	fprintf (asmcode, "%d %d _ _\n", tab_code.tab[i][0], tab_code.tab[i][1]);
      else if (tab_code.tab[i][3] == NOTU)
				fprintf (asmcode, "%d %d %d _\n", tab_code.tab[i][0],
					 tab_code.tab[i][1], tab_code.tab[i][2]);
      else
				fprintf (asmcode, "%d %d %d %d \n", tab_code.tab[i][0],
					 tab_code.tab[i][1], tab_code.tab[i][2], tab_code.tab[i][3]);
      //printf ("SORTIE print_code\n");
    }

  if (fclose (asmcode))
    {
      printf ("c'est l'echec \n ");
    }
}