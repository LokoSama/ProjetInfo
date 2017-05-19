/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tAo = 258,
    tAf = 259,
    tPo = 260,
    tPf = 261,
    tCo = 262,
    tCf = 263,
    tId = 264,
    tNb = 265,
    tIf = 266,
    tInt = 267,
    tPvir = 268,
    tElse = 269,
    tVir = 270,
    tWhile = 271,
    tReturn = 272,
    tEqLog = 273,
    tInclude = 274,
    tConst = 275,
    tMain = 276,
    tFloat = 277,
    tEq = 278,
    tInf = 279,
    tSup = 280,
    tPlus = 281,
    tMoins = 282,
    tStar = 283,
    tDiv = 284,
    tOr = 285,
    tAnd = 286,
    tNot = 287
  };
#endif
/* Tokens.  */
#define tAo 258
#define tAf 259
#define tPo 260
#define tPf 261
#define tCo 262
#define tCf 263
#define tId 264
#define tNb 265
#define tIf 266
#define tInt 267
#define tPvir 268
#define tElse 269
#define tVir 270
#define tWhile 271
#define tReturn 272
#define tEqLog 273
#define tInclude 274
#define tConst 275
#define tMain 276
#define tFloat 277
#define tEq 278
#define tInf 279
#define tSup 280
#define tPlus 281
#define tMoins 282
#define tStar 283
#define tDiv 284
#define tOr 285
#define tAnd 286
#define tNot 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 19 "source.yacc" /* yacc.c:1909  */

	int xInt;	
	float xFloat;
	char * str;

#line 124 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
