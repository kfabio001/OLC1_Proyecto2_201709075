# Dillinger

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Ante el progreso en los lenguajes de programacion, cada vez es mas necesario contar con herramientas que faciliten la migracion de un lenguaje a otro ante este problema surge la salucion de crear un servicio de traduccion en los lenguajes

  - Java -> Python
  - Java -> JavaScript

## Herramientas de desarrollo
* Frontend
      - Go
    - HTML
    - CSS
    - JavaScript
    
 * Backend
  - Traductor Python
	      - NodeJS
	       - Jison
	       - JavaScript
      - Traductor JS
	      - NodeJS
	      - JavaScript 
## La funcion de cada parte se integra en cada servidor
- Servidor Javascript esta corriendo en el puerto 9000
- Servidor Python esta corriendo en el puerto 9100
- Servidor Golang esta corriendo en el puerto 4000

Para las peticiones al servidor se utilizo 
- Express 
Ademas de herramientas de desarrollo como 
- nodemon 
- types 
- cors 
- morgan



El servicio de traducion para el lenguaje Python se utilizo integramente nodejs
 con los metods como preanalizar, analizar y listar los tokens de la cadena de entrada compuesta por senntecias swtich para cada token

El servicio de traduccion se utilizo la herramienta Jison

# La gramatica utilizada

INICIO : TIPOBLOQUES EOF 
TIPOBLOQUES: TIPOBLOQUES TIPOBLOQUE 
| TIPOBLOQUE 

TIPOBLOQUE : TIPOBLOQUE CLASE 
        | CLASE 
	    | TIPOBLOQUE INTERFAZ
        | INTERFAZ 
        | PANIC {}
CLASES: CLASES CLASE 
    | CLASE 
   
INTERFACES : INTERFACES INTERFAZ 
        | INTERFAZ 
INTERFAZ : public interface identificador lla FUNCIONES llc 
        | interface identificador lla FUNCIONES llc 
PANIC:  puntocoma 
      | error llc
      | error puntocoma 
    

FUNCIONES : FUNCIONES FUNCIO 
              | FUNCIO 
              | PANIC FUNCIONES 
FUNCIO : public void identificador para LPARAMETROS parc puntocoma  
	| public TIPO identificador para LPARAMETROS parc puntocoma 
        
	| void identificador para LPARAMETROS parc 
    
	| TIPO identificador para LPARAMETROS parc puntocoma 

CLASE: public class identificador lla INSTRUCCIONES llc 

	|  class identificador lla INSTRUCCIONES llc 
INSTRUCCIONES : INSTRUCCIONES INSTRUCCION 
              | INSTRUCCION 
INSTRUCCION : METODO 

            | SENTENCIAS 

METODO : public void identificador para LPARAMETROS parc lla SENTENCIAS llc 
        
        }
       | public void identificador para parc lla SENTENCIAS llc {
 
	| void identificador para LPARAMETROS parc lla SENTENCIAS llc 
       
    |void identificador para parc lla SENTENCIAS llc 
      
    | public TIPO identificador para LPARAMETROS parc lla SENTENCIAS llc  
    | TIPO identificador para LPARAMETROS parc lla SENTENCIAS llc {

    | TIPO identificador para parc lla SENTENCIAS llc 
    | public TIPO identificador para parc lla SENTENCIAS llc 
	| public TIPO identificador para LPARAMETROS parc puntocoma   
    | TIPO identificador para LPARAMETROS parc puntocoma  
       
    | public void identificador para LPARAMETROS parc puntocoma   
    | void identificador para LPARAMETROS parc puntocoma 

    | public static void main para string cora corc args parc lla SENTENCIAS llc   
    | static void main para string cora corc args parc lla SENTENCIAS llc  
    | static void main para string cora corc args parc lla  llc  
 
    | public static void main para string cora corc args parc lla SENTENCIAS llc 
    | public void identificador para  parc puntocoma  
    | void identificador para parc puntocoma  {
        
    | public void identificador para LPARAMETROS parc lla llc  
       | public void identificador para parc lla  llc {

	| void identificador para LPARAMETROS parc lla  llc 
     
    |void identificador para parc lla  llc  
    | public TIPO identificador para LPARAMETROS parc lla  llc 

    | PANIC 

TIPO : int 
	| boolean 
	| double 
	| string 
	| char 
INVOCACIONES: INVOCACIONES coma 
	//| EXPRESION 
    | INVOCACION
INVOCACION:  identificador para EXPRESION parc 
| identificador para parc 
| identificador para LPARAMETROS parc 

LPARAMETROS: LPARAMETROS PARAMETROS 
	| PARAMETROS
PARAMETROS: PARAMETROS coma 
	| PARAMETRO 
PARAMETRO: TIPO identificador 
              | EXPRESION 
            | lIDS       
            
;

SENTENCIAS: SENTENCIAS SENTENCIA 
	| SENTENCIA
SENTENCIA: DECLARACION puntocoma 
	| ASIGNACION puntocoma  
    | LASIG puntocoma  
	| INVOCACION puntocoma 
	| PRINT puntocoma 
	| IF
	| FOR 
	| WHILE 
	| DOWHILE 
	| RETURN puntocoma 
	| BREAK puntocoma 
	| CONTINUE puntocoma 
    | ITERACION
    | PANIC 
  
DECLARACION: TIPO lIDS 
LASIG: LASIG ASIG 
| ASIG
ASIG: ASIG coma 
| ASIGNACION
ASIGNACION: TIPO lIDS EXPRES 
| ITERACION 
| TIPO identificador EXPRES 
	
    | lIDS EXPRES 
lIDS: lIDS IDS
| IDS 
IDS: identificador coma 
 	| identificador 

EXPRES: igual EXPRESION  
RETURN: return 
 
EXPRESION: 
    INVOCACIONES 
    | EXPRESION mas EXPRESION 
	| EXPRESION menos EXPRESION 
	| EXPRESION por EXPRESION 
	| EXPRESION dividido EXPRESION 
	| EXPRESION potencia EXPRESION 
	| EXPRESION mayorque EXPRESION 
	| EXPRESION menorque EXPRESION 
	| EXPRESION igualdad EXPRESION 
	| EXPRESION mayorigualque EXPRESION 
	| EXPRESION menorigualque EXPRESION 
	| EXPRESION notque EXPRESION
	| EXPRESION or EXPRESION 
	| EXPRESION and EXPRESION 
    | EXPRESION not EXPRESION 
	| para EXPRESION parc 
	| menos EXPRESION 
	| not EXPRESION 
    | EXPRESION aumento 
    | EXPRESION disminucion
	|lIDS 
	| cadena 
	| caracter 
	| decimal 
	| entero 
	| true 
	| false 
	
;


PRINT: sout para parc 
|soutln para parc 
	| sout CONDICION 
    | soutln CONDICION 
CONDICION:  EXPRESION  
BODY: lla llc 
	| lla SENTENCIAS llc 
IF: if para EXPRESION parc BODY 

	| if para EXPRESION parc BODY else IF  

	| if para EXPRESION parc BODY else BODY 

FOR: for para TIPO identificador EXPRES puntocoma EXPRESION puntocoma ITERACION parc BODY 
	| for para identificador EXPRES puntocoma CONDICION puntocoma ITERACION parc BODY 
WHILE: while para CONDICION parc BODY 

DOWHILE: do BODY while para EXPRESION parc puntocoma {

BREAK: break
ITERACION: identificador aumento 
	| identificador disminucion 
    | identificador aumento puntocoma 
	| identificador disminucion puntocoma
CONTINUE: continue  
















