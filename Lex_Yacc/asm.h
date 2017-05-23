#ifndef ASM_H
#define ASM_H

#include <stdio.h>
#include "table.h"

#define ADD 1
#define MUL 2
#define SOU 3
#define DIV 4
#define COP 5
#define AFC 6
#define LOAD 7
#define STORE 8
#define EQU 9
#define INF 10
#define INFE 11
#define SUP 12
#define SUPE 13
#define JMP 14
#define JMPC 15
#define LOADR 16
#define STORR 17
#define JMPR 18

//definition pour le registre BasePile
#define BP 13

#define NOTU -10  //NOT_USED

struct tab_instrus {
	int tab[2048][4];
	int index;
} tab_code;

void Init_asm();
void set_mainJump();
void add_instru(int a, int b, int c, int d);
void OperationArith (int typeOperation);
void Or();
void And();
void ComparaisonLogique(int operateur);
void Not();
void print_code();


#endif

