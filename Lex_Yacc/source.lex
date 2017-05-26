%{
#include "y.tab.h"

%}

%%
main return  tMain ;
int return  tInt ;
float return  tFloat ;
if return  tIf ;
else return tElse ;
while return  tWhile ;
const return  tConst ;
\{ return  tAo ;
\}  return  tAf; 
\( return  tPo ;
\) return  tPf ;
\[ return tCo;
\] return tCf;
\; return  tPvir ;
\< return tInf ;
\> return tSup ;
\= return  tEq ;
\, return  tVir ;
\+ return  tPlus ;
\- return  tMoins ;
\/ return  tDiv ;
\* return  tStar ;
return return  tReturn ;
not | \! return tNot ;
and|\&\& return  tAnd ;
or|\|\| return  tOr ;
#include return  tInclude ;
[-]?[0-9]+ {yylval.xInt = atoi(yytext);return tNb;} ;
[a-zA-Z][a-zA-Z0-9]* {yylval.str = strdup(yytext); return tId;} ;
[ \t] ; /* ignore les blancs et tabulations */
%%

