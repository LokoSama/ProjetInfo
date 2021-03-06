#include "asm.h"
#include "boucle.h"

void Init_asm () {
	// Tableau contenant le code ASM
	//La premiere ligne du tab_code sera toujours une initialisation de BP
	//La seconde ligne du tab_code sera toujours un JMP au main
	tab_code.index = 2;
}

//ajout d'une instruction a b c d à la fin du code
void add_instru (int a, int b, int c, int d) {
	tab_code.tab[tab_code.index][0] = a;
	tab_code.tab[tab_code.index][1] = b;
	tab_code.tab[tab_code.index][2] = c;
	tab_code.tab[tab_code.index][3] = d;
	tab_code.index++;
}

void set_mainJump() {
	tab_code.tab[0][0] = AFC;
	tab_code.tab[0][1] = BP;
	tab_code.tab[0][2] = 0;
	tab_code.tab[0][3] = NOTU;
	tab_code.tab[1][0] = JMP;
	tab_code.tab[1][1] = tab_code.index;
	tab_code.tab[1][2] = NOTU;
	tab_code.tab[1][3] = NOTU;
}

//typeOperation = ADD, MUL, SOU, DIV
void OperationArith (int typeOperation) {
	//on récupère les valeurs dans la mémoire tmp
	add_instru(LOADR, 0, BP, tab_sym.tmp_var - 2);
	add_instru(LOADR, 1, BP, tab_sym.tmp_var - 1);
	//on effectue l'opération arithmétique et on stocke le résultat dans tmp
	add_instru (typeOperation, 0, 0, 1);
	//stockage du résultat
	add_instru(STORR, BP, tab_sym.tmp_var - 2, 0);
	decr_tmp_var();
}

void Or() {
	//on récupère les valeurs dans la mémoire tmp
	add_instru(LOADR, 0, BP, tab_sym.tmp_var - 2);
	add_instru(LOADR, 1, BP, tab_sym.tmp_var - 1);
	//on effectue l'opération logique
	add_instru(AFC, 2, 0, NOTU);
	add_instru(EQU, 0, 0, 2);
	add_instru(EQU, 1, 1, 2);
	add_instru(MUL, 0, 0, 1);
	add_instru(EQU, 0, 0, 2);
	//stockage du résultat
	add_instru(STORR, BP, tab_sym.tmp_var - 2, 0);
	decr_tmp_var();
}

void And() {
	//on récupère les valeurs dans la mémoire tmp
	add_instru(LOADR, 0, BP, tab_sym.tmp_var - 2);
	add_instru(LOADR, 1, BP, tab_sym.tmp_var - 1);
	//on effectue l'opération logique
	add_instru(AFC, 2, 0, NOTU);
	add_instru(EQU, 1, 1, 2); //R1 = ((R1 == 0) == 0);
	add_instru(EQU, 1, 1, 2);
	add_instru(MUL, 0, 0, 1);
	//stockage du résultat
	add_instru(STORR, BP, tab_sym.tmp_var - 2, 0);
	decr_tmp_var();
}

//les operateurs valides sont : EQU, INF, INFE, SUP, SUPE
void ComparaisonLogique(int operateur) {
	//on récupère les valeurs dans la mémoire tmp
	add_instru(LOADR, 0, BP, tab_sym.tmp_var - 2);
	add_instru(LOADR, 1, BP, tab_sym.tmp_var - 1);
	//on effectue l'opération logique
	add_instru(operateur, 0, 0, 1);
	//stockage du résultat
	add_instru(STORR, BP, tab_sym.tmp_var - 2, 0);
	decr_tmp_var();
}

void Not() {
	//on récupère la valeur dans la mémoire tmp
	add_instru(LOADR, 0, BP, tab_sym.tmp_var - 1);
	//on effectue l'opération logique
	add_instru(AFC,1,0,NOTU);
	add_instru(EQU,0,0,1);
	add_instru(STORR, BP, tab_sym.tmp_var - 1, 0);
}

void Jump(int typeJump) { //typeJump attend JMP ou JMPC
	switch (typeJump) {
		case JMP:
			empiler(tab_code.index);
			add_instru(JMP, -2, NOTU, NOTU);
			break;
		case JMPC:
			//on récupère la condition dans la mémoire tmp
			add_instru(LOADR, 0, BP, tab_sym.tmp_var - 1);
			empiler(tab_code.index); //on empile l'index de la ligne de code asm actuelle pour y retourner
			add_instru(JMPC, -2, 0, NOTU);
			decr_tmp_var();
			break;
		default:
			printf("Erreur dans asm.c/Jump: argument typeJump incorrect\n");
			break;
	}
}

int to_signed (int a) {
	if (a < 0)
		return ((~(-a)) +1 )& 0xff;
	else
		return a;
}

void print_code () {
	FILE *asmcode;
	printf ("ENTREE print_code\n");
	asmcode = fopen ("./code.asm", "w+");
	int i;
	for (i = 0; i < tab_code.index; i++) {
		//On répartit les codes sur 32 bits; le AFC, par exemple, ne s'écrit pas AFC REG VAL16bits NOTU mais bien AFC REG VAL8bits VAL8bits
		if (tab_code.tab[i][0] == AFC || tab_code.tab[i][0] == LOAD) {
			tab_code.tab[i][3] = tab_code.tab[i][2] % 256;
			tab_code.tab[i][2] /= 256;
		} else if (tab_code.tab[i][0] == JMP || tab_code.tab[i][0] == JMPC || tab_code.tab[i][0] == STORE) {
			tab_code.tab[i][2] = tab_code.tab[i][1] % 256;
			tab_code.tab[i][1] /= 256;
		} 

		//À l'issue de ceci, NOTU n'existe que dans "JMP ADR8bits ADR8bits NOTU", "COP REG1 REG2 NOTU" et "JMPR REG NOTU NOTU"
    	fprintf (asmcode, "%.2X%.2X%.2X%.2X\n", to_signed(tab_code.tab[i][0]), to_signed(tab_code.tab[i][1]), to_signed(tab_code.tab[i][2]), to_signed(tab_code.tab[i][3]));
  	}

	if (fclose (asmcode)) {
		printf ("c'est l'echec \n ");
	}
}

