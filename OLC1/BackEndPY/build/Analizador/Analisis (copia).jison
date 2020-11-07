
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

"int"                   return 'int';
"double"                return 'double';
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

.                       {console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
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

INICIO : TIPOBLOQUE EOF { 
    var padre = new Nodo("s","");
    //padre.hijos.push($1);
    //Analisis.raiz = padre;
}
;

TIPOBLOQUE : CLASES {
//$$ = new Nodo("TIPOBLOQUE", "$1");

        }
	    | INTERFAZ {
//$$ = new Nodo("TIPOBLOQUE", "$1");
        }
        | EOF{}
;
INTERFACES : INTERFACES INTERFAZ {
   // $$ = new Nodo("INTERFACES", "");
     //                       $$.hijos.push($1);
       //                     $$.hijos.push($2);
       }
        | INTERFAZ {
           // $$ = new Nodo("INTERFACES", "");
             //               $$.hijos.push($1);
                            }
        ;

INTERFAZ : public interface identificador lla FUNCIONES llc {
// $$ = new Nodo("INTERFAZ", "");
                          //   $$.hijos.push(new Nodo("ID", $3));
                  //           $$.hijos.push($5);
        }
        | interface identificador lla FUNCIONES llc {
// $$ = new Nodo("INTERFAZ", "");
                   //          $$.hijos.push(new Nodo("ID", $2));
                   //          $$.hijos.push($4);
        }
;
FUNCIONES : FUNCIONES FUNCIO { 
   //  $$ = new Nodo("FUNCIONES", "");
      //                       $$.hijos.push($1);
       //                      $$.hijos.push($2);
       }
              | FUNCIO { 
                  // $$ = new Nodo("FUNCIONES", "");
                          //   $$.hijos.push($1);
                            }
              | error puntocoma{
                CError.Errores.add(new CNodo_Error.NodoError("Error Sintáctico","No se esperaba el caracter: "+ yytext, this._$.first_line-2,this._$.first_column-2));}
;

FUNCIO : public void identificador para PARAMETROS parc puntocoma { 
  //   $$ = new Nodo("FUNCION", ""); 
    //     $$.hijos.push(new Nodo("ID", $3));
    //     $$.hijos.push($5);
        }
	| public TIPO identificador para PARAMETROS parc puntocoma  {
      //   $$ = new Nodo("FUNCION", ""); 
     //    $$.hijos.push($2);
     //    $$.hijos.push(new Nodo("ID", $3));
     //    $$.hijos.push($5);
    }
	| void identificador para PARAMETROS parc {
      //   $$ = new Nodo("FUNCION", ""); 
       
     //    $$.hijos.push(new Nodo("ID", $2));
      //   $$.hijos.push($4);
    }
	| TIPO identificador para PARAMETROS puntocoma  {
     //    $$ = new Nodo("FUNCION", ""); 
       //  $$.hijos.push($1);
        // $$.hijos.push(new Nodo("ID", $2));
        // $$.hijos.push($4);
    }
;
CLASES: CLASES CLASE {
    $$ = new Nodo("CLASES", "");
                         //    $$.hijos.push($1);
                        //     $$.hijos.push($2);
                            }
    | CLASE {$$ = new Nodo("CLASES", "");
                          //   $$.hijos.push($1);
                            }
    ;
CLASE: public class identificador lla INSTRUCCIONES llc {   
  //   $$ = new Nodo("CLASE", ""); 
 
      //   $$.hijos.push(new Nodo("ID", $3));
      //   $$.hijos.push($5);
}
	|  class identificador lla INSTRUCCIONES llc {
      //   $$ = new Nodo("CLASE", ""); 
      //   $$.hijos.push(new Nodo("ID", $2));
       //  $$.hijos.push($4);
    }
;
INSTRUCCIONES : INSTRUCCIONES INSTRUCCION {
 //    $$ = new Nodo("INSTRUCCIONES", "");
              //               $$.hijos.push($1);
              //               $$.hijos.push($2);
}
              | INSTRUCCION {
               //    $$ = new Nodo("INSTRUCCIONES", "");
                      //       $$.hijos.push($1);
                      }
;

INSTRUCCION : METODO {//$$=$1;
}
            | SENTENCIAS {//$$=$1;
            }
;
METODO : public void identificador para PARAMETROS parc lla SENTENCIAS llc {
   //  $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push(new Nodo("ID", $3));
     //    $$.hijos.push($5);
     //    $$.hijos.push($8);
        }
       | public void identificador para parc lla SENTENCIAS llc {
   //  $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push(new Nodo("ID", $3));
     //    $$.hijos.push($5);
     //    $$.hijos.push($8);
        }
	
	| void identificador para PARAMETROS parc lla SENTENCIAS llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push(new Nodo("ID", $2));
     //    $$.hijos.push($4);
     //    $$.hijos.push($7);
    }
    |void identificador para parc lla SENTENCIAS llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push(new Nodo("ID", $2));
     //    $$.hijos.push($4);
     //    $$.hijos.push($7);
    }
    | public TIPO identificador para PARAMETROS parc lla SENTENCIAS llc {
     //    $$ = new Nodo("METODO", ""); 
      //   $$.hijos.push($2);
      //   $$.hijos.push(new Nodo("ID", $3));
      //   $$.hijos.push($5);
     //    $$.hijos.push($8);
        }
    | TIPO identificador para PARAMETROS parc lla SENTENCIAS llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push($1);
     //    $$.hijos.push(new Nodo("ID", $2));
      //   $$.hijos.push($4);
      //   $$.hijos.push($7);
    }
    | TIPO identificador para parc lla SENTENCIAS llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push($1);
     //    $$.hijos.push(new Nodo("ID", $2));
      //   
      //   $$.hijos.push($6);
    }
    | public TIPO identificador para parc lla SENTENCIAS llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push($2);
     //    $$.hijos.push(new Nodo("ID", $3));
      //   
      //   $$.hijos.push($7);
    }
	| public TIPO identificador para PARAMETROS parc puntocoma  {
    //     $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push($2);
     //    $$.hijos.push(new Nodo("ID", $3));
      //   $$.hijos.push($5);
         
    } 
    | TIPO identificador para PARAMETROS parc puntocoma  {$$ = new Nodo("METODO", ""); 
      //   $$.hijos.push($1);
      //   $$.hijos.push(new Nodo("ID", $2));
       //  $$.hijos.push($4);
      //   $$.hijos.push($7);
        }
    | public void identificador para PARAMETROS parc puntocoma  {
      //   $$ = new Nodo("METODO", ""); 
        
      //   $$.hijos.push(new Nodo("ID", $3));
      //   $$.hijos.push($5);
  
    }
    | void identificador para PARAMETROS parc puntocoma  {
      //   $$ = new Nodo("METODO", ""); 

     //    $$.hijos.push(new Nodo("ID", $2));
       //  $$.hijos.push($4);
    }
    | public static void main para string cora corc args parc lla SENTENCIAS llc {
      //   $$ = new Nodo("METODO", ""); 

     //   $$.hijos.push($11);
    }
    | static void main para string cora corc args parc lla SENTENCIAS llc { 
      //   $$ = new Nodo("METODO", ""); 

      //   $$.hijos.push($11);
    }
    | static void main para string cora corc args parc lla  llc { 
      //   $$ = new Nodo("METODO", ""); 

      //   $$.hijos.push($11);
    }
    | public static void main para string cora corc args parc lla SENTENCIAS llc { 
      //   $$ = new Nodo("METODO", ""); 

      //   $$.hijos.push($11);
    }
    | public void identificador para  parc puntocoma  {
      //   $$ = new Nodo("METODO", ""); 
        
      //   $$.hijos.push(new Nodo("ID", $3));
      //   $$.hijos.push($5);
  
    }
    | void identificador para parc puntocoma  {
      //   $$ = new Nodo("METODO", ""); 

     //    $$.hijos.push(new Nodo("ID", $2));
       //  $$.hijos.push($4);
    }
    | public void identificador para PARAMETROS parc lla llc {
   //  $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push(new Nodo("ID", $3));
     //    $$.hijos.push($5);
     //    $$.hijos.push($8);
        }
       | public void identificador para parc lla  llc {
   //  $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push(new Nodo("ID", $3));
     //    $$.hijos.push($5);
     //    $$.hijos.push($8);
        }
	
	| void identificador para PARAMETROS parc lla  llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push(new Nodo("ID", $2));
     //    $$.hijos.push($4);
     //    $$.hijos.push($7);
    }
    |void identificador para parc lla  llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push(new Nodo("ID", $2));
     //    $$.hijos.push($4);
     //    $$.hijos.push($7);
    }
    | public TIPO identificador para PARAMETROS parc lla  llc {
     //    $$ = new Nodo("METODO", ""); 
      //   $$.hijos.push($2);
      //   $$.hijos.push(new Nodo("ID", $3));
      //   $$.hijos.push($5);
     //    $$.hijos.push($8);
        }
    | TIPO identificador para PARAMETROS parc lla llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push($1);
     //    $$.hijos.push(new Nodo("ID", $2));
      //   $$.hijos.push($4);
      //   $$.hijos.push($7);
    }
    | TIPO identificador para parc lla  llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push($1);
     //    $$.hijos.push(new Nodo("ID", $2));
      //   
      //   $$.hijos.push($6);
    }
    | public TIPO identificador para parc lla  llc {
     //    $$ = new Nodo("METODO", ""); 
     //    $$.hijos.push($2);
     //    $$.hijos.push(new Nodo("ID", $3));
      //   
      //   $$.hijos.push($7);
    }
;
TIPO : int {// $$ = new Nodo("TIPO", "$1");
}
	| boolean {// $$ = new Nodo("TIPO", "$1");
    }
	| double {// $$ = new Nodo("TIPO", "$1");
    }
	| string {// $$ = new Nodo("TIPO", "$1");
    }
	| char {// $$ = new Nodo("TIPO", "$1");
    }
;
INVOCACIONES: INVOCACIONES coma EXPRESION {
  //   $$ = new Nodo("P_INVOCACIONES", ""); 
      //   $$.hijos.push($1);
       //  $$.hijos.push($3);
    }
	| EXPRESION {$$ = $1;

    }
;
INVOCACION:  identificador para EXPRESION parc {
   //  $$ = new Nodo("INVOCACIONES", ""); 
       //  $$.hijos.push($1);

}
| identificador para parc {
  //   $$ = new Nodo("INVOCACIONES", ""); 
       //  $$.hijos.push($1);

}
| identificador para PARAMETROS parc {
  //   $$ = new Nodo("INVOCACIONES", ""); 
       //  $$.hijos.push($1);

}

;
RETURN: return {//  $$= new Nodo("RETURN", "");
}
	| return EXPRESION  {// $$ = new Nodo("RETURN", ""); 
                       //      $$.hijos.push($2);
                       }

  //| return SENTENCIA {// $$ = new Nodo("RETURN", ""); 
                       //      $$.hijos.push($2);
    //                   }
;

PARAMETROS: PARAMETROS coma PARAMETRO {// $$ = new Nodo("PARAMETROS", ""); 
       //  $$.hijos.push($1);
      //   $$.hijos.push($3);
      }
	| PARAMETRO {// $$ = new Nodo("PARAMETRO", "");
                         //    $$.hijos.push($1);
                            }
;

PARAMETRO: TIPO identificador {// $$ = new Nodo("PARAMETRO", ""); 
                         //    $$.hijos.push($1);
                         //    $$.hijos.push(new Nodo("ID", $2)); 
                            }
              | EXPRESION {}
            
            //| INVOCACION {
              // $$ = new Nodo("PARAMETRO", ""); 
                         //    $$.hijos.push($1);
            }
            | IDS{}         
            
;

SENTENCIAS: SENTENCIAS SENTENCIA {// $$ = new Nodo("SENTENCIAS", "");
                         //    $$.hijos.push($1);
                         //    $$.hijos.push($2);
                         }
	| SENTENCIA {// $$ = new Nodo("SENTENCIAS", "");
                         //    $$.hijos.push($1);
}
;

SENTENCIA: DECLARACION puntocoma {// $$=$1;
}
	| ASIGNACION puntocoma // {$$=$1;
    }
	| INVOCACION puntocoma {// $$=$1;
    }
	| PRINT puntocoma {// $$=$1;
    }
	| IF {// $$=$1;
    }
	| FOR {// $$=$1;
    }
	| WHILE {// $$=$1;
    }
	| DOWHILE {// $$=$1;
    }
	| RETURN puntocoma {// $$=$1;
    }
	| BREAK puntocoma {// $$=$1;
    }
	| CONTINUE puntocoma {// $$=$1;
    }
   // | error puntocoma{CError.Errores.add(new CNodo_Error.NodoError("Error Sintáctico S","No se esperaba el caracter: "+ yytext, this._$.first_line-2,this._$.first_column-2));}
;
DECLARACION: TIPO lIDS {// $$ = new Nodo("DECLARACION", "");
                         //    $$.hijos.push($1);
                        //     $$.hijos.push($2);
                            }
;
ASIGNACION: TIPO lIDS EXPRES {
  //  $$ = new Nodo("ASIGNACION", ""); 
                        //     $$.hijos.push(new Nodo("ID", $1)); 
                        //     $$.hijos.push($2);
                         //    $$.hijos.push($3);
}
| TIPO identificador EXPRES {
   //  $$ = new Nodo("ASIGNACION", ""); 
                         //    $$.hijos.push(new Nodo("ID", $1)); 
                         //    $$.hijos.push($2);
}
	| ITERACION {//$$ = $1;
    }
    | lIDS EXPRES {//$$ = new Nodo("ASIGNACION", ""); 
                          //   $$.hijos.push($1);
                          //   $$.hijos.push($2);
                            }
;
lIDS: lIDS IDS {//$$ = new Nodo("LISTA IDS", "");
                         //    $$.hijos.push($1);
                          //   $$.hijos.push($2);
                            }
| IDS {//$$ = new Nodo("LISTA IDS", "");
}
;
IDS: identificador coma {//$$ = new Nodo("IDS", "");
                           // $$.hijos.push($1);

                            }
 	| identificador {//$$ = $1;
     }
;

EXPRES: igual EXPRESION  {// $$ = new Nodo("EXPRES", "");
                           //  $$.hijos.push($1);
                         //    $$.hijos.push($2);
                            }
;
EXPRESION: INVOCACION {// $$ = $1;
    }
    | EXPRESION mas EXPRESION {// $$ = new Nodo("+", $2);
                          //   $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| EXPRESION menos EXPRESION {// $$ = new Nodo("-", $2);
                           //  $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| EXPRESION por EXPRESION {// $$ = new Nodo("*", $2);
                           //  $$.hijos.push($1);
                           //  $$.hijos.push($3);
                            }
	| EXPRESION dividido EXPRESION {// $$ = new Nodo("/", $2);
                           //  $$.hijos.push($1);
                           //  $$.hijos.push($3);
                            }

	| EXPRESION potencia EXPRESION {// $$ = new Nodo("^", $2);
                          //   $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| EXPRESION mayorque EXPRESION {// $$ = new Nodo(">", $2);
                           //  $$.hijos.push($1);
                           //  $$.hijos.push($3);
                            }
	| EXPRESION menorque EXPRESION {// $$ = new Nodo("<", $2);
                          //   $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| EXPRESION igualdad EXPRESION {// $$ = new Nodo("=", $2);
                          //   $$.hijos.push($1);
                           //  $$.hijos.push($3);
                            }
	| EXPRESION mayorigualque EXPRESION {// $$ = new Nodo(">=", $2);
                           //  $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| EXPRESION menorigualque EXPRESION {// $$ = new Nodo("<=", $2);
                          //   $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| EXPRESION notque EXPRESION {// $$ = new Nodo("!=", $2);
                          //   $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| EXPRESION or EXPRESION {// $$ = new Nodo("||", $2);
                           //  $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| EXPRESION and EXPRESION {// $$ = new Nodo("&&", $2);
                           //  $$.hijos.push($1);
                          //   $$.hijos.push($3);
                            }
	| para EXPRESION parc {// $$ = new Nodo("ANIDADA", "()");
                         //    $$.hijos.push($2);
                            }
	| menos EXPRESION {// $$ = new Nodo("NEGATIVO", $1);
                         //    $$.hijos.push($2);
                            }
	| not EXPRESION {// $$ = new Nodo("NEGACION", $1);
                         //    $$.hijos.push($2);
                            }
	| lIDS {// $$ = new Nodo("ID", $1);
    }
	| cadena {// $$ = new Nodo("cadena", $1);
    }
	| caracter {// $$ = new Nodo("caracter", $1);
    }
	| decimal {// $$ = new Nodo("decimal", $1);
    }
	| entero {// $$ = new Nodo("entero", $1);
    }
	| true {// $$ = new Nodo("true", $1);
    }
	| false {// $$ = new Nodo("false", $1);
    }
	
;


PRINT: sout para parc {
  //   $$ = new Nodo("PRINT", ""); 
}
	| sout CONDICION {
       //  $$ = new Nodo("PRINT", ""); 
       //  $$.hijos.push($2);
}
    | soutln CONDICION {
      //   $$ = new Nodo("PRINT", ""); 
       //  $$.hijos.push($2);
}
;

CONDICION: para EXPRESION parc {
    $$ = new Nodo("CONDICION", ""); 
                          //   $$.hijos.push($2);
}
;

BODY: lla llc {
   // $$ = new Nodo("BODY", ""); 
}
	| lla SENTENCIAS llc {//$$ = new Nodo("BODY", ""); 
                          //   $$.hijos.push($2);

                            }
;

IF: if CONDICION BODY {  $$ = new Nodo("IF", ""); 
                         //    $$.hijos.push($2);
                          //   $$.hijos.push($3);

}
	| if CONDICION BODY else IF  {$$ = new Nodo("IF", ""); 
                          //   $$.hijos.push($2);
                          //   $$.hijos.push($3);
                          //   $$.hijos.push($5);
    }
	| if CONDICION BODY else BODY {$$ = new Nodo("IF", ""); 
                          //   $$.hijos.push($2);
                         //    $$.hijos.push($3);
                          //   $$.hijos.push($5);

    }
;
FOR: for para TIPO identificador EXPRES puntocoma EXPRESION puntocoma ITERACION parc BODY {
                          //   $$ = new Nodo("FOR", ""); 
                          //   $$.hijos.push($3);
                          //   $$.hijos.push(new Nodo("ID", $3));
                          //   $$.hijos.push($5);
                          //   $$.hijos.push($7);
                          //   $$.hijos.push($9);
                          //   $$.hijos.push($11);

}
	| for para identificador EXPRES puntocoma EXPRESION puntocoma ITERACION parc BODY {
      //   $$ = new Nodo("FOR", ""); 
                         //    $$.hijos.push(new Nodo("ID", $3));
                         //    $$.hijos.push($4);
                         //    $$.hijos.push($6);
                         //    $$.hijos.push($8);
                        //     $$.hijos.push($10);
    }
;
WHILE: while CONDICION BODY {
                //     $$ = new Nodo("WHILE", ""); 
                          //   $$.hijos.push($2);
                          //   $$.hijos.push($3);
    
}
;
DOWHILE: do BODY while CONDICION puntocoma {

                           //  $$ = new Nodo("DOWHILE", ""); 
                           //  $$.hijos.push($2);
                         //    $$.hijos.push($4);
}
;

BREAK: break { //  $$= new Nodo("BREAK", "");
}
;

ITERACION: identificador aumento puntocoma {
  //   $$= new Nodo("AUMENTO", "");
  //   $$.hijos.push($1);
}
	| identificador disminucion puntocoma {
      //   $$= new Nodo("DISMINUCION", "");
      //   $$.hijos.push($1);
    }
    |identificador aumento  {
  //   $$= new Nodo("AUMENTO", "");
  //   $$.hijos.push($1);
}
	| identificador disminucion {
      //   $$= new Nodo("DISMINUCION", "");
      //   $$.hijos.push($1);
    }
;

CONTINUE: continue  {
   //  $$= new Nodo("CONTINUE", "");
}

;














