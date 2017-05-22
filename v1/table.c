#include <string.h>

struct symbole
{
  char id[16];
  int init;
  int depth;
};

struct table
{
  struct symbole tab[2048];
  int index;
  int cache;
	int depth_ac;
}tab_sym;

void Ajout_symbole (int init,char* val) {
printf("On fait les trucs \n");
strcpy(tab_sym.tab[tab_sym.index].id,val);
tab_sym.tab[tab_sym.index].init = init;
tab_sym.tab[tab_sym.index].depth = tab_sym.depth_ac;
tab_sym.index++;
}
