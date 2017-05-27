# Projet Informatique : compilateur C et processeur RISC pipeliné

BASSO Jérémy et BUGEL Sandor
INSA Toulouse 4 IR A2
2016/2017


## Compilateur

### Exécution :

make : compilation du compilateur

make test : compilation du compilateur + exécution avec le fichier test.c

make clean : cleanup des fichiers de compilation

### Fonctionnalités implémentées :

* Déclaration et affectation de variables
* Type integer
* Expression arithmétiques
* Boucles if et while
* Main et fonctions


## Microprocesseur

### Exécution
Exécute le code ASM présent dans le fichier notrecode.hex via l'IDE Xilinx-Ise

### Fonctionnalités implémentées
* Exécution de la totalité des instructions assembleur ci-dessous
* Détection et gestion des aléas

## Jeu d'instructions assembleur

**Addition** 0x01 ADD Ri Rj Rk

**Multpilication** 0x02 MUL Ri Rj Rk

**Soustraction** 0x03 SOU Ri Rj Rk

**Division** 0x04 DIV Ri Rj Rk

**Copie** 0x05 COP Ri Rj 

**Affectation** 0x06 AFC Ri j 

**Chargement** 0x07 LOAD Ri @j

**Sauvegarde** 0x08 STORE @i Rj 

**Egalité** 0x09 EQU Ri Rj Rk

**Inférieur** 0x0A INF Ri Rj Rk

**Inférieur égal** 0x0B INFE Ri Rj Rk

**Supérieur** 0x0C SUP Ri Rj Rk

**Supérieur égal** 0x0D SUPE Ri Rj Rk

**Saut** 0x0E JMP @i

**Saut conditionnel** 0x0F JMPC @i Ri


**Chargement registre** 0x10 LOADR Rx offset Ry

**Sauvegarde registre** 0x11 STORR Rx Ry offset

**Jump registre** 0x12 JMPR Rx


