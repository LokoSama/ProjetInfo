#include "boucle.h"


void Init_tab_boucle(){
tab_boucle.index=0;
}

void empiler(int ligne){
tab_boucle.tab[tab_boucle.index]=ligne;
tab_boucle.index ++;
}

int depiler(){
tab_boucle.index--;
return tab_boucle.tab[tab_boucle.index];
}
