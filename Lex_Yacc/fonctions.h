#ifndef FONCTIONS_H
#define FONCTIONS_H

#include <string.h>
#include <stdio.h>

struct pile_adresses_retour {
	int index;
	int tab[2048];
} tab_retour;

struct struct_fonction {
	char id[16];
	int nb_args;
	int index_definition;
};

struct tableau_f {
	int index;
	struct struct_fonction tab[256];
} tab_fonctions;

void Init_fonctions();
void empiler_retour(int ligne);
int depiler_retour();

void ajout_fonction(char* id, int index_definition);
void incremente_nb_args();
int get_index_definition(char* id);
int get_nb_args(char* id);


#endif

