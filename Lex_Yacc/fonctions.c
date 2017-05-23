#include "fonctions.h"

void Init_fonctions() {
	tab_fonctions.index=0;
}

/*
	STORR Rx offset Ry   =>   adr[Rx+offset] <- Ry
	LOADR Rx Ry offset   =>   Rx <- adr[Ry+offset]
	JMPR Rx _ _ 				 =>		JMP [Rx]	
*/

void empiler_contexte(int adresseRetour) {
	add_instru(AFC, 0, adresseRetour, NOTU);
	add_instru(STORR, SP, 0, 0); //on empile SP					SP pointe sur la prochaine case libre (donc la valeur de retour), donc on met adresseRetour à SP+1
	add_instru(STORR, SP, 1, BP); //on empile BP
	add_instru(AFC, 0, 2, NOTU); //SP <- SP + 2
	add_instru(ADD, SP, SP, 0);
	add_instru(COP, BP, SP, NOTU);//BP <- SP
}

void empiler_arg(int arg) {
	add_instru(LOADR, 0, BP, arg);
	add_instru(STORR, SP, 0, 0); //TODO TMPVAR ?
	add_instru(AFC, 0, 1, NOTU); //SP ++
	add_instru(ADD, SP, SP, 0);
}

void lire_args(char* idFonc) {
	int nbreArgs = get_nb_args(idFonc);
	int i;
	for (i = 0; i < nbreArgs; i++) {
		add_instru(LOADR, 0, BP, -(3+i)); // on récupère les args et on les stocke en haut de la pile
		add_instru(STORR, SP, 0, 0);
		add_instru(AFC, 0, 1, NOTU); //SP++
		add_instru(ADD, SP, SP, 0);
	}
}

void ajout_fonction(char* id, int index_definition) {
  int i = 0;
	int found = 0;
	
	while(found == 0 && i < tab_fonctions.index) {
  	if (strcmp(tab_fonctions.tab[i].id, id) == 0) {
  	  found = 1;
  	  printf("Impossible d'ajouter la fonction : déjà déclarée\n");
  	}
  	  i++;
  }
  if (found == 0) {
  	strcpy (tab_fonctions.tab[tab_fonctions.index].id, id);
  	tab_fonctions.tab[tab_fonctions.index].nb_args = 0;
  	tab_fonctions.tab[tab_fonctions.index].index_definition = index_definition;
  	tab_fonctions.index ++;
  }
}

void incremente_nb_args() {
	tab_fonctions.tab[tab_fonctions.index - 1].nb_args ++;
}

int get_index(char* id) {
  int i = 0;
	while(i < tab_fonctions.index && strcmp(id, tab_fonctions.tab[i].id) != 0) {
		i++;
	}
	if (i == tab_fonctions.index)
		printf("ERROR: Appel de fonction inexistante\n");
	
	return i;
}

int get_nb_args(char* id) {
	int i = get_index(id);
	return tab_fonctions.tab[i].nb_args;
}


