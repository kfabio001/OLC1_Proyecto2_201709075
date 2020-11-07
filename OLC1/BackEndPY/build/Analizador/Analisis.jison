
%{
 const {Nodo} = require('../NodoArbol/Nodo');
    let CNodo_Error = require('../Reportes/Nodo_Error');
    let CError = require('../Reportes/Errores');
    let count = 0;

 
%}



%lex

%options case-sensitive

%%


[ \r\t]+            {}
\n                  {}

"//".*   {};

[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]    {};

"int"                   {return 'int';console.log("enteroooo");}
"double"                {return 'double';console.log("enteroooo");}
"boolean"               return 'boolean';
"char"                  return 'char';
"String"                return 'string';
"float"				    return 'float';


"if"                    return 'if';
"else"                  return 'else';
"while"                 return 'while';
"do"                    return 'do';
"for"                   return 'for';
"void"                  return 'void';
"return"                return 'return';
"break"                 return 'break';
"main"                  return 'main';
"continue"              return'continue';
"System.out.println"    return'soutln';
"System.out.print"      return'sout';

"public"                return 'public';
"interface"             return 'interface';
"import"                return'import';
"class"                 return'class';
"true"                  return'true';
"false"                 return'false';
"default"               return'default';

"static"                return 'static';
"main"                  return 'main';
"args"                  return 'args';

"{"                     return 'lla';
"}"                     return 'llc';
";"                     return 'puntocoma';
"("                     return 'para';
")"                     return 'parc';
"["                     return 'cora';
"]"                     return 'corc';
","                     return 'coma';
":"                     return 'dospuntos';

"&&"                    return 'and';
"||"                    return 'or';
"!="                    return 'notque';
"=="                    return 'igualdad';
">="                    return 'mayorigualque';
"<="                    return 'menorigualque';

"++"                    return 'aumento';
"--"                    return 'disminucion';

">"                     return 'mayorque';
"<"                     return 'menorque';
"="                     return 'igual';
"!"                     return 'not';


"+"                     return 'mas'; 
"-"                     return 'menos';
"*"                     return 'por';
"/"                     return 'dividido';
"%"                     return 'modulo';
"^"                     return 'potencia';

[0-9]+("."[0-9]+)       return 'decimal';

[0-9]+\b                return 'entero';




(\"[^"]*\")             return 'cadena';
(\'[^']\')              return 'caracter';



([a-zA-Z]|[_])[a-zA-Z0-9_]* return 'identificador';



<<EOF>>                 return 'EOF';

.                       {console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); 
                       CError.Errores.add(new CNodo_Error.NodoError("Error Lexico","No se esperaba el caracter: "+ yytext, yylloc.first_line,yylloc.first_column)); }
/lex                  

%left or
%left and
%left igualdad, distinto
%left mayorigualque, menorigualque, menorque, mayorque
%left mas, menos
%left por, dividido, modulo
%left potencia
%right not
%left UMENOS

%start INICIO
%% 

INICIO : TIPOBLOQUES EOF {
    $$=$1; return $$; 
    var padre = new Nodo("s","",this._$.first_line-1,this._$.first_column-1);
    padre.hijos.push($1);
    Analisis.raiz = padre;
}
;
TIPOBLOQUES: TIPOBLOQUES TIPOBLOQUE {}
| TIPOBLOQUE {}
;

TIPOBLOQUE : TIPOBLOQUE CLASE {
     $$ = new Nodo("CLASE", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push($2);
        }
        | CLASE {
            $$ = new Nodo("CLASE", "" ,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
        }
	    | TIPOBLOQUE INTERFAZ{
            $$ = new Nodo("INTERFAZ", "INTEFAZ",this._$.first_line-1,this._$.first_column-1);
                           $$.hijos.push($1);
                            $$.hijos.push($2);

        }
        | INTERFAZ {
            $$ = new Nodo("INTERFAZ", "INTERFAZ",this._$.first_line-1,this._$.first_column-1);
                            $$.hijos.push($1);
        }
        | PANIC {}
     //   | EOF{} 
;
CLASES: CLASES CLASE {
    $$ = new Nodo("CLASE", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push($2);
                            }
    | CLASE {$$ = new Nodo("CLASE", "" ,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                            }
   // | PANIC {}
    ;
INTERFACES : INTERFACES INTERFAZ {
    $$ = new Nodo("INTERFAZ", "INTEFAZ",this._$.first_line-1,this._$.first_column-1);
                           $$.hijos.push($1);
                            $$.hijos.push($2);
       }
        | INTERFAZ {
            $$ = new Nodo("INTERFAZ", "INTERFAZ",this._$.first_line-1,this._$.first_column-1);
                            $$.hijos.push($1);
                            }
      //  | PANIC {}
        ;

INTERFAZ : public interface identificador lla FUNCIONES llc {
 $$ = new Nodo("INTERFAZ", "INTERFAZ",this._$.first_line-1,this._$.first_column-1);
                            $$.hijos.push(new Nodo("PUBLIC", $1,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push(new Nodo("LLAVE A", $4,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($5);
                             $$.hijos.push(new Nodo("LLAVE C", $6,this._$.first_line-1,this._$.first_column-1));
        }
        | interface identificador lla FUNCIONES llc {
 $$ = new Nodo("INTERFAZ", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push(new Nodo("LLAVE A", $3,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($4);
                             $$.hijos.push(new Nodo("LLAVE C", $5,this._$.first_line-1,this._$.first_column-1));
        }
;
PANIC:  puntocoma {}//{ CError.Errores.add(new CNodo_Error.NodoError("Error Sintáctico","No se esperaba el caracter: "+ yytext, this._$.first_line-1,this._$.first_column-1)); }
      | error llc { CError.Errores.add(new CNodo_Error.NodoError("Error Sintáctico","No se esperaba el caracter: "+ yytext, this._$.first_line-1,this._$.first_column-1)); }
      | error puntocoma { CError.Errores.add(new CNodo_Error.NodoError("Error Sintáctico","No se esperaba el caracter: "+ yytext, this._$.first_line-1,this._$.first_column-1)); }
      ;

FUNCIONES : FUNCIONES FUNCIO { 
     $$ = new Nodo("FUNCION", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                            $$.hijos.push($2);
       }
              | FUNCIO { 
                   $$ = new Nodo("FUNCION", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                            }
              | PANIC FUNCIONES {}
        ;

FUNCIO : public void identificador para LPARAMETROS parc puntocoma { 
     $$ = new Nodo("FUNCION", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1,this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $2,this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($5);
          $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
         
         $$.hijos.push(new Nodo("PUNTOCOMA", $7,this._$.first_line-1,this._$.first_column-1));
        }
	| public TIPO identificador para LPARAMETROS parc puntocoma  {
         $$ = new Nodo("FUNCION", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("PUBLIC", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($2);
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($5);
         $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $7,this._$.first_line-1,this._$.first_column-1));
    }
	| void identificador para LPARAMETROS parc {
         $$ = new Nodo("FUNCION", "",this._$.first_line-1,this._$.first_column-1); 
        $$.hijos.push(new Nodo("VOID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
    }
	| TIPO identificador para LPARAMETROS parc puntocoma  {
         $$ = new Nodo("FUNCION", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push($1);
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $6,this._$.first_line-1,this._$.first_column-1));
    }
;

CLASE: public class identificador lla INSTRUCCIONES llc {   
     $$ = new Nodo("CLASE", "class ",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1,this._$.first_line-1,this._$.first_column-1));
  
     $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $4,this._$.first_line-1,this._$.first_column-1));
         
         $$.hijos.push($5);
         $$.hijos.push(new Nodo("LLAVE C", $6,this._$.first_line-1,this._$.first_column-1));
}
	|  class identificador lla INSTRUCCIONES llc {
         $$ = new Nodo("CLASE", "class  ",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("LLAVE C", $5,this._$.first_line-1,this._$.first_column-1));
    }
;
INSTRUCCIONES : INSTRUCCIONES INSTRUCCION {
     $$ = new Nodo("INSTRUCCIONES", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push($2);
}
              | INSTRUCCION {
                   $$ = new Nodo("INSTRUCCIONES", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                      }
;

INSTRUCCION : METODO {$$=$1;
}
            | SENTENCIAS {$$=$1;
            }
;
METODO : public void identificador para LPARAMETROS parc lla SENTENCIAS llc {
     $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $2, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($5);
         $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $7,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($8);
        $$.hijos.push(new Nodo("LLAVE C", $9,this._$.first_line-1,this._$.first_column-1));
        }
       | public void identificador para parc lla SENTENCIAS llc {
     $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $2, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($7);
         $$.hijos.push(new Nodo("LLAVE C", $8,this._$.first_line-1,this._$.first_column-1));
        }
	
	| void identificador para LPARAMETROS parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("VOID", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($7);
         $$.hijos.push(new Nodo("LLAVE C", $8,this._$.first_line-1,this._$.first_column-1));
    }
    |void identificador para parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1);    
         $$.hijos.push(new Nodo("VOID", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $5,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($6);
        $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
    }
    | public TIPO identificador para LPARAMETROS parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
      //   $$.hijos.push($2);
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($5);
         $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $7,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($8);
         $$.hijos.push(new Nodo("LLAVE C", $9,this._$.first_line-1,this._$.first_column-1));
        }
    | TIPO identificador para LPARAMETROS parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO_T", ""); 
       //  $$.hijos.push($1);
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($7);
         $$.hijos.push(new Nodo("LLAVE C", $8,this._$.first_line-1,this._$.first_column-1));
    }
    | TIPO identificador para parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
       //  $$.hijos.push($1);
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($6);
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
    }
    | public TIPO identificador para parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
       //  $$.hijos.push($2);
       $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($7);
         $$.hijos.push(new Nodo("LLAVE C", $8,this._$.first_line-1,this._$.first_column-1));
    }
	| public TIPO identificador para LPARAMETROS parc puntocoma  {
         $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
      //   $$.hijos.push($2);
      $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($5);
         $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $7,this._$.first_line-1,this._$.first_column-1));
         
    } 
    | TIPO identificador para LPARAMETROS parc puntocoma  {
        $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
       //  $$.hijos.push($1);
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $6,this._$.first_line-1,this._$.first_column-1));
         //$$.hijos.push($7);
        }
    | public void identificador para LPARAMETROS parc puntocoma  {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
       $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($5);
         $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $7,this._$.first_line-1,this._$.first_column-1));
  
    }
    | void identificador para LPARAMETROS parc puntocoma  {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("VOID", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $6,this._$.first_line-1,this._$.first_column-1));
    }
    | public static void main para string cora corc args parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("STATIC", $2, this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("VOID", $3, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", "main",this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("STRINGM", "string",this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("CORCHETE ABRE", $7,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("CORCHETE CIERRA", $8,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ARGS", $9,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $10,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("LLAVE A", $11,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($12);
        $$.hijos.push(new Nodo("LLAVE C", $13,this._$.first_line-1,this._$.first_column-1));
    }
    | static void main para string cora corc args parc lla SENTENCIAS llc { 

         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("STATIC",  $1,this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $2, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", "main",this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("STRINGM", "string",this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("CORCHETE ABRE", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("CORCHETE CIERRA", $7,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ARGS", $8,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $9,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("LLAVE A", $10,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($11);
        $$.hijos.push(new Nodo("LLAVE C", $12,this._$.first_line-1,this._$.first_column-1));
    }
    | static void main para string cora corc args parc lla  llc { 
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("STATIC", $1, this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $2, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", "main",this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("STRINGM", "string",this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("CORCHETE ABRE", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("CORCHETE CIERRA", $7,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ARGS", $8,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $9,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("LLAVE A", $10,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("LLAVE C", $11,this._$.first_line-1,this._$.first_column-1));
        
    }
    | public static void main para string cora corc args parc lla SENTENCIAS llc { 
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("STATIC", $2, this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $3, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", "main",this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("PARENTESIS A", $5,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("STRINGM", "string",this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("CORCHETE ABRE", $7,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("CORCHETE CIERRA", $8,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ARGS", $9,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("PARENTESIS C", $10,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($12);
        $$.hijos.push(new Nodo("LLAVE A", $11,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("LLAVE C", $13,this._$.first_line-1,this._$.first_column-1));
    }
    | public void identificador para  parc puntocoma  {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
        $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $2, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $6,this._$.first_line-1,this._$.first_column-1));
    }
    | void identificador para parc puntocoma  {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("VOID", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $5,this._$.first_line-1,this._$.first_column-1));
         
    }
    | public void identificador para LPARAMETROS parc lla llc {
     $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $2, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($5);
         $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $7,this._$.first_line-1,this._$.first_column-1))
         $$.hijos.push(new Nodo("LLAVE C", $8),this._$.first_line-1,this._$.first_column-1);;
        }
       | public void identificador para parc lla  llc {
     $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("VOID", $2, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
         
        }
	
	| void identificador para LPARAMETROS parc lla  llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("VOID", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
         
    }
    |void identificador para parc lla  llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("VOID", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE C", $6,this._$.first_line-1,this._$.first_column-1));
        
    }
    | public TIPO identificador para LPARAMETROS parc lla  llc {
         $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
        // $$.hijos.push($2);
        $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($5);
         $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $7,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE C", $8,this._$.first_line-1,this._$.first_column-1));
        
        }
    | TIPO identificador para LPARAMETROS parc lla llc {
         $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
       //  $$.hijos.push($1);
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
         
    }
    | TIPO identificador para parc lla  llc {
         $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
        // $$.hijos.push($1);
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $5,this._$.first_line-1,this._$.first_column-1));
         
         $$.hijos.push(new Nodo("LLAVE C", $6,this._$.first_line-1,this._$.first_column-1));
    }
    | public TIPO identificador para parc lla  llc {
         $$ = new Nodo("METODO_T", "",this._$.first_line-1,this._$.first_column-1); 
        // $$.hijos.push($2);
        $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));

         $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
    }
    //hhhhh
    | public  identificador para LPARAMETROS parc lla SENTENCIAS llc {
     $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));

         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($7);
        $$.hijos.push(new Nodo("LLAVE C", $8,this._$.first_line-1,this._$.first_column-1));
        }
       | public  identificador para parc lla SENTENCIAS llc {
     $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
 
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($6);
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
        }
	
	| identificador para LPARAMETROS parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 

         $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($3);
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($6);
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
    }
    | identificador para parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1);    
         
         $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $4,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($5);
        $$.hijos.push(new Nodo("LLAVE C", $6,this._$.first_line-1,this._$.first_column-1));
    }
    | public  identificador para LPARAMETROS parc lla SENTENCIAS llc {
     $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));

         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($4);
         $$.hijos.push(new Nodo("PARENTESIS C", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $6,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($7);
        $$.hijos.push(new Nodo("LLAVE C", $8,this._$.first_line-1,this._$.first_column-1));
        }
       | public  identificador para parc lla SENTENCIAS llc {
     $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PUBLIC", $1, this._$.first_line-1,this._$.first_column-1));
    
         $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($6);
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
        }
	
	|  identificador para LPARAMETROS parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1); 
         
         $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($3);
         $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $5,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push($6);
         $$.hijos.push(new Nodo("LLAVE C", $7,this._$.first_line-1,this._$.first_column-1));
    }
    | identificador para parc lla SENTENCIAS llc {
         $$ = new Nodo("METODO", "",this._$.first_line-1,this._$.first_column-1);    
         
         $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $3,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("LLAVE A", $4,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($5);
        $$.hijos.push(new Nodo("LLAVE C", $6,this._$.first_line-1,this._$.first_column-1));
    }
    | PANIC {}
;
TIPO : int { $$ = new Nodo("INT", $1,this._$.first_line-1,this._$.first_column-1);
}
	| boolean { $$ = new Nodo("BOOLEAN", $1,this._$.first_line-1,this._$.first_column-1);
    }
	| double { $$ = new Nodo("DOUBLE", $1,this._$.first_line-1,this._$.first_column-1);
    }
	| string { $$ = new Nodo("STRING", $1,this._$.first_line-1,this._$.first_column-1);
    }
	| char { $$ = new Nodo("CHAR", $1,this._$.first_line-1,this._$.first_column-1);
    }
;
INVOCACIONES: INVOCACIONES coma {
     $$ = new Nodo("INVOCACIONES", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push($1);
         $$.hijos.push(new Nodo("COMA", $2,this._$.first_line-1,this._$.first_column-1));

    }
	//| EXPRESION {$$ = new Nodo("EXPRESION", "",this._$.first_line-1,this._$.first_column-1); 
       //  $$.hijos.push($1);

   // }
    | INVOCACION{$$ = new Nodo("INVOCACIONES", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push($1);}
;
INVOCACION:  identificador para EXPRESION parc {
     $$ = new Nodo("INVOCACIONES", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($3);
        $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
}
| identificador para parc {
     $$ = new Nodo("INVOCACIONES", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS C", $3,this._$.first_line-1,this._$.first_column-1));

}
| identificador para LPARAMETROS parc {
     $$ = new Nodo("INVOCACIONES", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push($3);
        $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
}

;

LPARAMETROS: LPARAMETROS PARAMETROS { $$ = new Nodo("PARAMETRO", "",this._$.first_line-1,this._$.first_column-1); 
        $$.hijos.push($1);
         $$.hijos.push($2);
      }
	| PARAMETROS { $$ = new Nodo("PARAMETRO", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                            }
;

PARAMETROS: PARAMETROS coma { $$ = new Nodo("PARAMETRO", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push($1);
         $$.hijos.push(new Nodo("COMA", $2,this._$.first_line-1,this._$.first_column-1));
        
      }
	| PARAMETRO { $$ = new Nodo("PARAMETRO", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                            }
;

PARAMETRO: TIPO identificador { $$ = new Nodo("PARAMETRO", "",this._$.first_line-1,this._$.first_column-1); 
                             $$.hijos.push($1);
                             $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1)); 
                            }
              | EXPRESION {$$ = new Nodo("EXPRESION", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push($1);}
            | lIDS {$$ = new Nodo("IDS", "",this._$.first_line-1,this._$.first_column-1);
                           $$.hijos.push($1);
                             }         
            
;

SENTENCIAS: SENTENCIAS SENTENCIA { $$ = new Nodo("SENTENCIA", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push($2);
                         }
	| SENTENCIA { $$ = new Nodo("SENTENCIA", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
}
;

SENTENCIA: DECLARACION puntocoma { $$=$1;
$$.hijos.push(new Nodo("PUNTOCOMA", $2,this._$.first_line-1,this._$.first_column-1));
}
	| ASIGNACION puntocoma  {$$=$1;
    $$.hijos.push(new Nodo("PUNTOCOMA", $2,this._$.first_line-1,this._$.first_column-1));
    }
    | LASIG puntocoma  {$$=$1;
    $$.hijos.push(new Nodo("PUNTOCOMA", $2,this._$.first_line-1,this._$.first_column-1));
    }
	| INVOCACION puntocoma { $$=$1;
    $$.hijos.push(new Nodo("PUNTOCOMA", $2,this._$.first_line-1,this._$.first_column-1));
    }
	| PRINT puntocoma { $$=$1;
    $$.hijos.push(new Nodo("PUNTOCOMA", $2,this._$.first_line-1,this._$.first_column-1));
    }
	| IF { $$=$1;
    }
	| FOR { $$=$1;
    }
	| WHILE { $$=$1;
    }
	| DOWHILE { $$=$1;
    }
	| RETURN puntocoma { $$=$1;
    $$.hijos.push(new Nodo("PUNTOCOMA", $2,this._$.first_line-1,this._$.first_column-1));
    }
	| BREAK puntocoma { $$=$1;
    $$.hijos.push(new Nodo("PUNTOCOMA", $2,this._$.first_line-1,this._$.first_column-1));
    }
	| CONTINUE puntocoma { $$=$1;
    $$.hijos.push(new Nodo("PUNTOCOMA", $2,this._$.first_line-1,this._$.first_column-1));
    }
    | ITERACION {$$ = $1;
    }
    | PANIC {}
   
    ;
DECLARACION: TIPO lIDS { $$ = new Nodo("DECLARACION", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push($2);
                            }
;
LASIG: LASIG ASIG {  $$ = new Nodo("ASIGNACION", "",this._$.first_line-1,this._$.first_column-1); 
        $$.hijos.push($1);
         $$.hijos.push($2);
         }
| ASIG { $$ = new Nodo("ASIGNACION", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             }
;
ASIG: ASIG coma { $$ = new Nodo("ASIGNACION", "",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push($1);
         $$.hijos.push(new Nodo("COMA", $2,this._$.first_line-1,this._$.first_column-1));

}
| ASIGNACION { $$ = new Nodo("ASIGNACION", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);

}
;
ASIGNACION: TIPO lIDS EXPRES {
    $$ = new Nodo("ASIGNACION", "",this._$.first_line-1,this._$.first_column-1); 
                             $$.hijos.push($1); 
                             $$.hijos.push($2);
                             $$.hijos.push($3);
}
| ITERACION {$$ = $1;
    }
| TIPO identificador EXPRES {
     $$ = new Nodo("ASIGNACION", "",this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push($1);
                             $$.hijos.push(new Nodo("ID", $2,this._$.first_line-1,this._$.first_column-1)); 
                             $$.hijos.push($3);
}
	
    | lIDS EXPRES {$$ = new Nodo("ASIGNACION", "",this._$.first_line-1,this._$.first_column-1); 
                             $$.hijos.push($1);
                             $$.hijos.push($2);
                            }
;
lIDS: lIDS IDS {$$ = new Nodo("IDS", "",this._$.first_line-1,this._$.first_column-1);
                           $$.hijos.push($1);
                             $$.hijos.push($2);
                            }
| IDS {$$ = new Nodo("IDS", "",this._$.first_line-1,this._$.first_column-1);
$$.hijos.push($1);
}
;
IDS: identificador coma {$$ = new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1);
                            //$$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
                            $$.hijos.push(new Nodo("COMA", $2,this._$.first_line-1,this._$.first_column-1));
                            }
 	| identificador {$$ = new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1);
                            //$$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
     }
;

EXPRES: igual EXPRESION  { $$ = new Nodo("EXPRES", "",this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push(new Nodo("=", $1,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($2);
                            }
;
RETURN: return {  $$= new Nodo("RETURN", "return ",this._$.first_line-1,this._$.first_column-1);
}
	| return EXPRESION  { $$ = new Nodo("RETURN", "",this._$.first_line-1,this._$.first_column-1); 
                             $$.hijos.push($2);
                       }
  //  | return identificador aumento  {   $$= new Nodo("AUMENTO", "",this._$.first_line-1,this._$.first_column-1);
    // $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
    // $$.hijos.push(new Nodo("AUMENTO", $2,this._$.first_line-1,this._$.first_column-1));
   //                    }
   // | return identificador disminucion  {  $$= new Nodo("DISMINUCION", "",this._$.first_line-1,this._$.first_column-1);
    //    $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
     //   $$.hijos.push(new Nodo("DISMINUCION", $2,this._$.first_line-1,this._$.first_column-1));
      //                 }
;
EXPRESION: 
    INVOCACIONES { $$ = $1;
    }
    | EXPRESION mas EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push( new Nodo("+", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION menos EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                            $$.hijos.push(new Nodo("-", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION por EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push(new Nodo("*", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION dividido EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push(new Nodo("/", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }

	| EXPRESION potencia EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                           $$.hijos.push(new Nodo("^", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION mayorque EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push(new Nodo(">", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION menorque EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                          $$.hijos.push(new Nodo("<", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION igualdad EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                            $$.hijos.push(new Nodo("==", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION mayorigualque EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                           $$.hijos.push(new Nodo(">=", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION menorigualque EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                           $$.hijos.push(new Nodo("<=", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION notque EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                            $$.hijos.push(new Nodo("!=", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION or EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                        $$.hijos.push(new Nodo("||", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| EXPRESION and EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                          $$.hijos.push(new Nodo("&&", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
    | EXPRESION not EXPRESION { $$ = new Nodo("E", $2,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push($1);
                             $$.hijos.push(new Nodo("NEGACION", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                            }
	| para EXPRESION parc { $$ = new Nodo("E", "()",this._$.first_line-1,this._$.first_column-1);
                            $$.hijos.push(new Nodo("PARENTESIS A", $1,this._$.first_line-1,this._$.first_column-1));
                            // $$.hijos.push(new Nodo("ANIDADA", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($2);
                             $$.hijos.push(new Nodo("PARENTESIS C", $3,this._$.first_line-1,this._$.first_column-1));
                            }
	| menos EXPRESION { $$ = new Nodo("E", $1,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push(new Nodo("NEGATIVO", $1,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($2);
                            }
	| not EXPRESION { $$ = new Nodo("NEGACION", $1,this._$.first_line-1,this._$.first_column-1);
                             $$.hijos.push(new Nodo("NEGACION", $1,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($2);
                            }
    | EXPRESION aumento { $$ = new Nodo("AUMENTO", $2,this._$.first_line-1,this._$.first_column-1);
                             
                             $$.hijos.push($1);
                             $$.hijos.push(new Nodo("AUMENTO", $2,this._$.first_line-1,this._$.first_column-1));
                             
                            }
    | EXPRESION disminucion { $$ = new Nodo("DISMINUCION", $2,this._$.first_line-1,this._$.first_column-1);
                             
                             $$.hijos.push($1);
                             $$.hijos.push(new Nodo("DISMINUCION", $2,this._$.first_line-1,this._$.first_column-1));
                             
                            }
	
	|lIDS { $$ = $1;
    }
	| cadena { $$ = new Nodo("cadena", $1,this._$.first_line-1,this._$.first_column-1);
    }
	| caracter { $$ = new Nodo("caracter", $1,this._$.first_line-1,this._$.first_column-1);
    }
	| decimal { $$ = new Nodo("decimal", $1,this._$.first_line-1,this._$.first_column-1);
    }
	| entero { $$ = new Nodo("entero", $1,this._$.first_line-1,this._$.first_column-1);
    }
	| true { $$ = new Nodo("true", $1,this._$.first_line-1,this._$.first_column-1);
    }
	| false { $$ = new Nodo("false", $1,this._$.first_line-1,this._$.first_column-1);
    }
	
;


PRINT: sout para parc {
     $$ = new Nodo("PRINT", $1,this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("PARENTESIS C", $3,this._$.first_line-1,this._$.first_column-1));
}
|soutln para parc {
     $$ = new Nodo("PRINT", $1,this._$.first_line-1,this._$.first_column-1); 
     $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("PARENTESIS C", $3,this._$.first_line-1,this._$.first_column-1));
}
	| sout CONDICION {
         $$ = new Nodo("PRINT", $1,this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push($2);
}
    | soutln CONDICION {
        $$ = new Nodo("PRINT", $1,this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push($2);
}
;

CONDICION:  EXPRESION  {
    $$ = new Nodo("CONDICION", "",this._$.first_line-1,this._$.first_column-1); 
                             $$.hijos.push($1);
                           //  $$.hijos.push(new Nodo("PARENTESIS A", $1,this._$.first_line-1,this._$.first_column-1));
    // $$.hijos.push(new Nodo("PARENTESIS C", $3,this._$.first_line-1,this._$.first_column-1));
}
;

BODY: lla llc {
    $$ = new Nodo("BODY", "",this._$.first_line-1,this._$.first_column-1); 
    $$.hijos.push(new Nodo("LLAVE A", $1,this._$.first_line-1,this._$.first_column-1));
    $$.hijos.push(new Nodo("LLAVE C", $2,this._$.first_line-1,this._$.first_column-1));
}
	| lla SENTENCIAS llc {$$ = new Nodo("BODY", "",this._$.first_line-1,this._$.first_column-1); 
    $$.hijos.push(new Nodo("LLAVE A", $1,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($2);
    
    $$.hijos.push(new Nodo("LLAVE C", $3,this._$.first_line-1,this._$.first_column-1));
                            }
;

IF: if para EXPRESION parc BODY {  $$ = new Nodo("IF", "if ",this._$.first_line-1,this._$.first_column-1); 
$$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
     
                            $$.hijos.push($3);
                            $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($5);

}
	| if para EXPRESION parc BODY else IF  {$$ = new Nodo("IF", "if ",this._$.first_line-1,this._$.first_column-1); 
    $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
    
                             $$.hijos.push($3);
                             $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($5);
                             $$.hijos.push(new Nodo("ELSE", $6,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($7);
    }
	| if para EXPRESION parc BODY else BODY {$$ = new Nodo("IF", "if ",this._$.first_line-1,this._$.first_column-1); 
    $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
    
                             $$.hijos.push($3);
                              $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($5);
                             $$.hijos.push(new Nodo("ELSE", $6,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($7);

    }
;
FOR: for para TIPO identificador EXPRES puntocoma EXPRESION puntocoma ITERACION parc BODY {
                            
                             $$ = new Nodo("FOR", "for ",this._$.first_line-1,this._$.first_column-1); 
                             $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($3);
                             $$.hijos.push(new Nodo("ID", $4,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($5);
                             $$.hijos.push(new Nodo("PUNTOCOMA", $6,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($7);
                             $$.hijos.push(new Nodo("PUNTOCOMA", $8,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($9);
                             $$.hijos.push(new Nodo("PARENTESIS C", $10,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($11);

}
	| for para identificador EXPRES puntocoma CONDICION puntocoma ITERACION parc BODY {
         $$ = new Nodo("FOR", "for ",this._$.first_line-1,this._$.first_column-1); 
         $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push(new Nodo("ID", $3,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($4);
                             $$.hijos.push(new Nodo("PUNTOCOMA", $5,this._$.first_line-1,this._$.first_column-1));
                           $$.hijos.push($6);
                           $$.hijos.push(new Nodo("PUNTOCOMA", $7,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($8);
                             $$.hijos.push(new Nodo("PARENTESIS C", $9,this._$.first_line-1,this._$.first_column-1));
                           $$.hijos.push($10);
    }
;
WHILE: while para CONDICION parc BODY {
                     $$ = new Nodo("WHILE", "while ",this._$.first_line-1,this._$.first_column-1); 
                     $$.hijos.push(new Nodo("PARENTESIS A", $2,this._$.first_line-1,this._$.first_column-1));
     
                            $$.hijos.push($3);
                            $$.hijos.push(new Nodo("PARENTESIS C", $4,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($5);
    
}
;
DOWHILE: do BODY while para EXPRESION parc puntocoma {

                             $$ = new Nodo("DOWHILE", " do ",this._$.first_line-1,this._$.first_column-1); 
                             $$.hijos.push($2);
                             $$.hijos.push(new Nodo("WHILE", $3,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push(new Nodo("PARENTESIS A", $4,this._$.first_line-1,this._$.first_column-1));
                             $$.hijos.push($5);
     $$.hijos.push(new Nodo("PARENTESIS C", $6,this._$.first_line-1,this._$.first_column-1));
                             
                             $$.hijos.push(new Nodo("PUNTOCOMA", $7,this._$.first_line-1,this._$.first_column-1));
}
;

BREAK: break {   $$= new Nodo("BREAK", "break ",this._$.first_line-1,this._$.first_column-1);
}
;

ITERACION: identificador aumento  {
     $$= new Nodo("AUMENTO", "",this._$.first_line-1,this._$.first_column-1);
     $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("AUMENTO", $2,this._$.first_line-1,this._$.first_column-1));
}
	| identificador disminucion {
        $$= new Nodo("DISMINUCION", "",this._$.first_line-1,this._$.first_column-1);
        $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
        $$.hijos.push(new Nodo("DISMINUCION", $2,this._$.first_line-1,this._$.first_column-1));
    }
    | identificador aumento puntocoma {
    $$= new Nodo("AUMENTO", "",this._$.first_line-1,this._$.first_column-1);
     $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("AUMENTO", $2,this._$.first_line-1,this._$.first_column-1));
     $$.hijos.push(new Nodo("PUNTOCOMA", $3,this._$.first_line-1,this._$.first_column-1));
}
	| identificador disminucion puntocoma {
         $$= new Nodo("DISMINUCION", "",this._$.first_line-1,this._$.first_column-1);
         $$.hijos.push(new Nodo("ID", $1,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("DISMINUCION", $2,this._$.first_line-1,this._$.first_column-1));
         $$.hijos.push(new Nodo("PUNTOCOMA", $3,this._$.first_line-1,this._$.first_column-1));
    }
    
;

CONTINUE: continue  {
     $$= new Nodo("CONTINUE", "continue ",this._$.first_line-1,this._$.first_column-1); 
}

;














