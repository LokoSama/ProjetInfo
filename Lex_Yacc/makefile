SRC= test.c table.c asm.c boucle.c
#SRC contient les fichiers C
OBJ=$(SRC:.c=.o)
all: compilator
clean:
	rm *.o compilator test
y.pdf : y.dot
	dot -Tpdf y.dot > y.pdf
y.tab.c y.tab.h y.dot y.output : source.yacc
	yacc -dvg source.yacc
lex.yy.c : source.lex y.tab.h
	flex source.lex
compilator : y.tab.o lex.yy.o $(OBJ)
	gcc y.tab.o lex.yy.o $(OBJ) -ll -o  compilator
test : compilator
	./compilator < test.c
