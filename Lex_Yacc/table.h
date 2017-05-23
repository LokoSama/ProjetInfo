#ifndef TABLE_H
#define TABLE_H

#include <string.h>
#include <stdio.h>
#include "asm.h"

struct symbole {
  char id[16];
  int init;
  int depth;
};

struct table {
  struct symbole tab[2048];
  int index;
  int tmp_var;
} tab_sym;

int Init_table ();
void Affecte(char * nom); //affecte la var nom à la valeur de tmp_var -1
void Ajout_symbole (int init, char *val,int depth_ac);
int Suppression_symboles (int depth_ac);
int augmentation_profondeur (int depth_ac);
void print_table (int max);
int index_of(char* nom);

void incr_tmpvar();
void decr_tmpvar();

#endif

