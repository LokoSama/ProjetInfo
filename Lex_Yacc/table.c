#include "table.h"


int Init_table ()
{
	tab_sym.index = 0;
	tab_sym.tmp_var = 0;
  return 0;
}

void Ajout_symbole (int init, char *val,int depth_ac)
{
  printf ("Ajout symbole \n");
  strcpy (tab_sym.tab[tab_sym.index].id, val);
  tab_sym.tab[tab_sym.index].init = init;
  tab_sym.tab[tab_sym.index].depth = depth_ac;
  tab_sym.index++;
  tab_sym.tmp_var = tab_sym.index;
}

int Suppression_symboles (int depth_ac)
{
	  while(tab_sym.tab[tab_sym.index-1].depth == depth_ac) {
  	  	tab_sym.index --;
  	  	tab_sym.tmp_var = tab_sym.index;
  	  }
  printf ("Suppression_symboles \n");
  return depth_ac-1;
}

void Affecte(char * nom) {
	int i = index_of(nom);
	tab_sym.tab[i].init = 1;
	add_instru(LOAD, 0, tab_sym.tmp_var - 1, NOTU);
	add_instru(STORE, i, 0, NOTU);
}

int augmentation_profondeur (int depth_ac)
{
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
		i = -1;
	return i;
}

void print_table (int max)
{
  int i = 0;
  for (i = 0; i < max; i++)
    {
      printf ("Index : %d , Id : %s ,Init ? :  %d , Profondeur :%d \n",
	      i, tab_sym.tab[i].id, tab_sym.tab[i].init,
	      tab_sym.tab[i].depth);
    }
}
