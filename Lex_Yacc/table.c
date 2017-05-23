#include "table.h"


int Init_table () {
	tab_sym.index = 0;
	tab_sym.tmp_var = 0;
  return 0;
}

void Ajout_symbole (int init, char *val,int depth_ac) {
	int i=0;
	int found=0;
	while(found == 0 && i < tab_sym.index) {
		if (strcmp(tab_sym.tab[i].id, val) == 0 && tab_sym.tab[i].depth == depth_ac) {
			found = 1;
			printf("Impossible d'ajouter la variable : déjà déclarée à la même profondeur\n");
		}
		i++;
	}
  if (found==0) {
    printf ("Ajout symbole \n");
    strcpy (tab_sym.tab[tab_sym.index].id, val);
    tab_sym.tab[tab_sym.index].init = init;
    tab_sym.tab[tab_sym.index].depth = depth_ac;
    incr_index_sym();
    tab_sym.tmp_var = tab_sym.index;
  }
}

int Suppression_symboles (int depth_ac) {
	while(tab_sym.tab[tab_sym.index-1].depth == depth_ac) {
  	decr_index_sym();
  	tab_sym.tmp_var = tab_sym.index;
  }
  printf ("Suppression_symboles \n");
  return depth_ac-1;
}

void Affecte(char * nom) {
	int i = index_of(nom);
	tab_sym.tab[i].init = 1;
	add_instru(LOADR, 0, BP, tab_sym.tmp_var - 1);
	add_instru(STORR, i, 0, NOTU);
	decr_tmp_var();
}

int augmentation_profondeur (int depth_ac) {
  printf ("Augmentation_profondeur\n");
  depth_ac++;
	return depth_ac;
}

int index_of(char* nom) {
	printf("index_of\n");
	int i = 0;
	while(i < tab_sym.index && strcmp(nom, tab_sym.tab[i].id) != 0) {
		i++;
	}
	if (i == tab_sym.index)
		printf("ERROR: Appel de variable inexistante\n");
	return i;
}

void incr_index_sym() {
	tab_sym.index++;
	add_instru(AFC, 0, 1, NOTU);//SP++
	add_instru(ADD, SP, SP, 0);
}

void decr_index_sym() {
	tab_sym.index--;
	add_instru(AFC, 0, 1, NOTU);//SP--
	add_instru(SOU, SP, SP, 0);	
}

void incr_tmp_var() {
	tab_sym.tmp_var++;
	add_instru(AFC, 0, 1, NOTU);//SP++
	add_instru(ADD, SP, SP, 0);
}

void decr_tmp_var() {
	tab_sym.tmp_var--;
	add_instru(AFC, 0, 1, NOTU);//SP--
	add_instru(SOU, SP, SP, 0);	
}

void print_table (int max) {
  int i = 0;
  for (i = 0; i < max; i++) {
  	printf ("Index : %d , Id : %s ,Init ? :  %d , Profondeur :%d \n",	i, tab_sym.tab[i].id, tab_sym.tab[i].init, tab_sym.tab[i].depth);
  }
}
