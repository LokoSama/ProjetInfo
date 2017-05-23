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
	add_instru(STORR, BP, tab_sym.tmp_var, 0); 						//on empile l'adresse de retour
	add_instru(STORR, BP, tab_sym.tmp_var + 1, BP); 			//on empile BP
	add_instru(AFC, BP, tab_sym.tmp_var + 2, NOTU);				//BP <- sommet de pile
}

void lire_args(char* idFonc) {
	int nbreArgs = get_nb_args(idFonc);
	int i;
	for (i = 0; i < nbreArgs; i++) {
		add_instru(LOADR, 0, BP, -2-nbreArgs+i); // on récupère les args et on les stocke en haut de la pile
		add_instru(STORR, BP, i, 0);
	}
}

void ajout_fonction(const char* id, int index_definition) {
  int i = 0;
	int found = 0;
	printf("***\n");
	while(found == 0 && i < tab_fonctions.index) {
		printf("Entree while: i=%d, index=%d\n", i, tab_fonctions.index);
		printf("strcmp: %d\n", strcmp(tab_fonctions.tab[i].id, id));
  	if (strcmp(tab_fonctions.tab[i].id, id) == 0) {
  	  found = 1;
  	  printf("Impossible d'ajouter la fonction : déjà déclarée\n");
  	}
  	printf("apres if\n");
		i++;
  }
  if (found == 0) {
  	strcpy (tab_fonctions.tab[tab_fonctions.index].id, id);
  	tab_fonctions.tab[tab_fonctions.index].nb_args = 0;
  	tab_fonctions.tab[tab_fonctions.index].index_definition = index_definition;
  	tab_fonctions.index++;
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


