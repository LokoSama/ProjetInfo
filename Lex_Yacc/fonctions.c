#include "fonctions.h"

void Init_fonctions() {
	tab_fonctions.index=0;
}

void empiler_contexte(int arg) {
	add_instru(AFC, 0, arg, NOTU);
	add_instru(STORR, LR, 0, NOTU);
	add_instru(AFC, 0, 1, NOTU);
	add_instru(ADD, LR, LR, 0);
}

int depiler_contexte(char* id) {
	
	return 0;
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


