"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var express_1 = __importDefault(require("express"));
var bodyparser = __importStar(require("body-parser"));
var cors_1 = __importDefault(require("cors"));
//import * as gramatica from './Analizador/Analisis';
var gramatica = require("./Analizador/Analisis");
var Errores_1 = require("./Reportes/Errores");
var Tokens_1 = require("./Reportes/Tokens");
var Tokenn_1 = require("./Reportes/Tokenn");
var fss = require("fs");
var execSync = require('child_process').execSync;
var fs = require('fs');
var app = express_1.default();
app.use(bodyparser.json());
app.use(cors_1.default());
app.use(bodyparser.urlencoded({ extended: true }));
var graph = require('d3-graphviz');
var Lista_clase_1;
var Lista_clase_2;
var Lista_clase_contadores_1;
var Lista_clase_contadores_2;
var contador1;
var contador2;
var r1;
var r2;
var i = 0;
var cadena = "";
var consola = "";
var contenido = "";
app.post('/consol/', function (req, res) {
    req.on('end', function () {
        res.end(consola);
    });
});
app.post('/Analizar/', function (req, res) {
    var entrada = req.body.text1;
    var resultado = prueba(entrada);
    // consola="";
    console.log(resultado);
    if (Errores_1.Errores.Vacio()) {
        consola = "";
        recorrer_tree_uno(resultado);
        graficar(resultado);
        Tokens_1.Tokens.clear();
        Tokenss(resultado);
        var nada = "";
        Errores_1.Errores.mostrar();
        var tree1 = JSON.stringify(resultado, null, 2);
        tree1 = tree1.split('descripcion').join('text').split('lista_Nodo').join('children');
        res.json({ arbol: tree1, Rerror: Errores_1.Errores.mostrar_Lista().toString(), Reporte_uno: consola, Reporte_dos: Tokens_1.Tokens.mostrar_Lista().toString(), ast: contenido });
        Errores_1.Errores.clear();
    }
    else {
        consola = "";
        recorrer_tree_uno(resultado);
        Errores_1.Errores.clear();
        graficar(resultado);
        Tokens_1.Tokens.clear();
        Tokenss(resultado);
        if (req.body.text2.toString() == "uno") {
            Lista_clase_1 = [];
            Lista_clase_contadores_1 = [];
            contador1 = 0;
            console.log("uno");
            r1 = resultado;
            //Apartado para el AST
            var tree1 = JSON.stringify(resultado, null, 2);
            tree1 = tree1.split('descripcion').join('text').split('lista_Nodo').join('children');
            // console.log(tree1);
            //recorrer_tree_uno(resultado);
            res.json({ arbol: tree1, Rerror: "nada", Reporte_uno: consola, Reporte_dos: Tokens_1.Tokens.mostrar_Lista().toString(), ast: contenido });
        }
        else {
            //  Lista_clase_2 =[];
            //Lista_clase_contadores_2=[];
            //contador2 = 0;
            // console.log("dos");
            //  r2 =resultado;
            //Apartado para el AST
            //  var tree2 = JSON.stringify(resultado,null,2);
            //   tree2 = tree2.split('descripcion').join('text').split('lista_Nodo').join('children');
            //  res.json({arbol: tree2, Rerror: "nada2", Reporte_uno: Reporte_clase, Reporte_dos: Reporte_funcion});
        }
    }
});
function Tokenss(Nodos) {
    try {
        var padre = "nodo" + i;
        if ((Nodos.descripcion.toString() != "")) {
            if (Nodos.descripcion.toString() == "CLASE") {
                Nodos.descripcion = "class";
            }
            else if (Nodos.tipo.toString() == "E") {
                Nodos.tipo = "EXPRESION";
            }
            else if (Nodos.tipo.toString() == "==") {
                Nodos.tipo = "IGUALDAD";
            }
            else if (Nodos.tipo.toString() == "++") {
                Nodos.tipo = "AUMENTO";
            }
            else if (Nodos.tipo.toString() == "ID") {
                Nodos.tipo = "IDENTIFICADOR";
            }
            else if (Nodos.tipo.toString() == "!=") {
                Nodos.tipo = "NEGACION";
            }
            else if (Nodos.tipo.toString() == "--") {
                Nodos.tipo = "DISMINUCION";
            }
            else if (Nodos.tipo.toString() == "+") {
                Nodos.tipo = "MAS";
            }
            else if (Nodos.tipo.toString() == "-") {
                Nodos.tipo = "MENOS";
            }
            else if (Nodos.tipo.toString() == "*") {
                Nodos.tipo = "MULTIPLICACION";
            }
            else if (Nodos.tipo.toString() == "!") {
                Nodos.tipo = "NEGADO";
            }
            else if (Nodos.tipo.toString() == "&&") {
                Nodos.tipo = "AND";
            }
            else if (Nodos.tipo.toString() == "^") {
                Nodos.tipo = "POTENCIA";
            }
            else if (Nodos.tipo.toString() == "/") {
                Nodos.tipo = "DIVISION";
            }
            else if (Nodos.tipo.toString() == ">") {
                Nodos.tipo = "MAYOR QUE";
            }
            else if (Nodos.tipo.toString() == "<") {
                Nodos.tipo = "MENOR QUE";
            }
            else if (Nodos.tipo.toString() == "<=") {
                Nodos.tipo = "MENOR IGUAL QUE";
            }
            else if (Nodos.tipo.toString() == ">=") {
                Nodos.tipo = "MAYOR IGUAL QUE";
            }
            else if (Nodos.tipo.toString() == "=") {
                Nodos.tipo = "IGUAL";
            }
            var rem = Nodos.descripcion.toString().replace('"', '');
            var reme = rem.replace('"', '');
            Tokens_1.Tokens.add(new Tokenn_1.Tokenn(Nodos.tipo, Nodos.descripcion.toString(), Nodos.fila, Nodos.columna));
            console.log(Nodos.tipo, Nodos.descripcion.toString(), Nodos.fila.toString(), Nodos.columna.toString());
            i = i + 1;
        }
        for (var index = 0; index < Nodos.hijos.length; index++) {
            //cadena= cadena + padre +"->"+"nodo"+(i)+ "\n";
            Tokenss(Nodos.hijos[index]);
        }
    }
    catch (error) {
        console.log(error);
    }
}
function AST(Nodos) {
    var padre = "nodo" + i;
    try {
        var rem = Nodos.descripcion.toString().replace('"', '');
        var reme = rem.replace('"', '');
        cadena += "" + padre + " [label =\"" + i + ") Etiqueta: " + Nodos.tipo + "  Valor:" + reme + "\"]  ";
        i = i + 1;
        //cadena+= padre +"->"+"nodo"+(i)+ "\n";
        //}
        for (var index = 0; index < Nodos.hijos.length; index++) {
            //console.log(Nodos.hijos[index].descripcion.toString());
            //  if((Nodos.descripcion.toString()!="")){
            cadena = cadena + padre + "->" + "nodo" + (i) + " ";
            //  }
            // if((Nodos.hijos[index].descripcion.toString()!="")){ 
            AST(Nodos.hijos[index]);
            //}
        }
    }
    catch (error) {
        console.log(error);
    }
    // if((Nodos.descripcion.toString()!="")){
    //console.log(cadena);
    return cadena;
}
function graficar(Nodos) {
    var nombre = "dot.txt";
    contenido = "digraph G {node[shape= \"box\", style=filled ]" + AST(Nodos) + "}";
    var cmd;
    var cmdd;
    try {
        fss.writeFile(nombre, contenido, function (err) {
            if (err)
                throw err;
            cmdd = execSync('node -v');
            console.log('The file has been saved!');
        });
        cmd = "dot.exe -Tpng " + nombre + ".dot -o " + nombre + ".png";
        //   File path = new File(nombre + ".png");
    }
    catch (error) {
        console.log(error);
    }
    contenido = "'" + contenido + "'";
    return contenido;
}
/*----------------------------------------Reportes Copias clases--------------------------------*/
function recorrer_tree_uno(temporal) {
    if (temporal != null) {
        if (temporal.hijos != null && temporal.hijos.length > 0) {
            for (var index = 0; index < temporal.hijos.length; index++) {
                if (temporal.hijos[index] != null) {
                    try {
                        if (temporal.hijos[index].tipo == "CLASE") {
                            //console.log("class ");
                            consola = consola + "class ";
                            //console.log(temporal.hijos[index].tipo.toString());
                            Lista_clase_1.push(temporal.hijos[index].descripcion);
                            // if(contador1!=0){
                            //   console.log("entra");
                            // Lista_clase_contadores_1.push(contador1);
                            // contador1 = 0;
                            //   }
                            console.log(" -> " + temporal.hijos[index].descripcion);
                        }
                        else if (temporal.hijos[index].tipo == "METODO") {
                            // console.log("function ");
                            consola = consola + "function ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "METODO_T") {
                            // console.log("function ");
                            consola = consola + "function ";
                            contador1 = contador1 + 1;
                        }
                        else if ((temporal.hijos[index].tipo == "ID") && (temporal.hijos[index].descripcion.toString() != "[object Object]")) {
                            //console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + " ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "RETURN") {
                            //console.log("return ");
                            consola = consola + "return ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "WHILE") {
                            // console.log("while ");
                            consola = consola + "while ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "DOWHILE") {
                            consola = consola + "do ";
                            //console.log("do");
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "FOR") {
                            consola = consola + "for ";
                            //console.log("for ");
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "IF") {
                            consola = consola + "if ";
                            //console.log("if ");
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "ELSE") {
                            // console.log("else");
                            consola = consola + "else ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "BREAK") {
                            //console.log("break");
                            consola = consola + "break ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "CONTINUE") {
                            consola = consola + "continue ";
                            //console.log("continue");
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "COMA") {
                            //console.log(",");
                            consola = consola + ", ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "+") {
                            //console.log("+");
                            consola = consola + "+ ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "=") {
                            //console.log("=");
                            consola = consola + "= ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "-") {
                            //console.log("-");
                            consola = consola + "- ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "*") {
                            //console.log("*");
                            consola = consola + "* ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "/") {
                            //console.log("/");
                            consola = consola + "/ ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "^") {
                            //console.log("^");
                            consola = consola + "^ ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == ">") {
                            consola = consola + "> ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "<") {
                            consola = consola + "< ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "==") {
                            //console.log("==");
                            consola = consola + "== ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == ">=") {
                            //console.log(">=");
                            consola = consola + ">= ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "<=") {
                            // console.log("<=");
                            consola = consola + "<= ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "!=") {
                            // console.log("!=");
                            consola = consola + "!= ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "||") {
                            // console.log("||");
                            consola = consola + "|| ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "&&") {
                            //console.log("&&");
                            consola = consola + "&& ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "NEGATIVO") {
                            //console.log("-");
                            consola = consola + "- ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "NEGACION") {
                            //console.log("!");
                            consola = consola + "! ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "INT") {
                            // console.log("var ");
                            consola = consola + "var ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "STRING") {
                            // console.log("var ");
                            consola = consola + "var ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "BOOLEAN") {
                            //console.log("var ");
                            consola = consola + "var ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "CHARACTER") {
                            //console.log("var ");
                            consola = consola + "var ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "DOUBLE") {
                            //console.log("var ");
                            consola = consola + "var ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "cadena") {
                            temporal.hijos[index].descripcion.replace('"', '');
                            // console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + " ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "caracter") {
                            //console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + " ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "decimal") {
                            // console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + " ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "entero") {
                            // console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + " ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "true") {
                            // console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + " ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "false") {
                            //  console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + " ";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "LLAVE A") {
                            //console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + "\n";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "LLAVE C") {
                            // console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + "\n";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "PARENTESIS A") {
                            //console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString();
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "PARENTESIS C") {
                            //console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString();
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "DISMINUCION") {
                            //console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString();
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "AUMENTO") {
                            //console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString();
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "PUNTOCOMA") {
                            // console.log(temporal.hijos[index].descripcion.toString());
                            consola = consola + temporal.hijos[index].descripcion.toString() + "\n";
                            contador1 = contador1 + 1;
                        }
                        else if (temporal.hijos[index].tipo == "PRINT") {
                            // console.log("console.log");
                            consola = consola + "console.log";
                            contador1 = contador1 + 1;
                        } //else if(temporal.hijos[index].tipo == "E"){
                        // console.log(temporal.hijos[index].descripcion.toString());
                        //contador1 = contador1+1;
                        //}
                    }
                    catch (error) {
                    }
                }
                recorrer_tree_uno(temporal.hijos[index]);
            }
        }
    }
    else {
        console.log("Entro");
    }
}
/*
function Buscar_copia_clases(){

    Reporte_clase ="";
    Reporte_clase = "<!DOCTYPE html> ";
    Reporte_clase+="<html lang=\"en\">";
    Reporte_clase+="<head>";
    Reporte_clase+="<meta charset=\"UTF-8\">";
    Reporte_clase+="<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
    Reporte_clase+="<title>Reporte de Clases copia</title>";
    Reporte_clase+="<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\" integrity=\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\" crossorigin=\"anonymous\">";
    Reporte_clase+="<script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js\" integrity=\"sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6\" crossorigin=\"anonymous\"></script>";
    Reporte_clase+="</head>";
    Reporte_clase+="<body>";
    Reporte_clase+="<H1>Reporte de Clases</H1>";
    Reporte_clase+= "<table class=\"table\"><thead class=\"thead-dark\"> \n";
    Reporte_clase+="<tr> \n";
    Reporte_clase+= "<th scope=\"col\">#</th> \n";
    Reporte_clase+= "<th scope=\"col\">Noombre</th> \n";
    Reporte_clase+= "<th scope=\"col\">Metodos/funciones archivo 1</th> \n";
    Reporte_clase+= "<th scope=\"col\">Metodos/funciones archivo 2</th> \n";
    Reporte_clase+= "</tr> \n";
    Reporte_clase+= "</thead> \n";
    Reporte_clase+= "<tbody>";
    var No=1;
    for (let index = 0; index < Lista_clase_1.length; index++) {
        
        for (let index2 = 0; index2 < Lista_clase_2.length; index2++) {
        
            if(Lista_clase_1[index] == Lista_clase_2[index2] ){

                Reporte_clase+= "<tr> \n";
                Reporte_clase+= "<th scope=\"row\">"+No+"</th> \n";
                Reporte_clase+="<td>"+Lista_clase_1[index]+"</td><td>"+
                            Lista_clase_contadores_1[index]+"</td><td>"+
                            Lista_clase_contadores_2[index2]+"</td>\n";
                Reporte_clase+="</tr>\n";
                No=No+1;

                console.log("Se encontro copia de una clase: "+ Lista_clase_2[index2] );
                console.log("Metodos Archivo1 : "+ Lista_clase_contadores_1[index] );
                console.log("Metodos Archivo2 : "+ Lista_clase_contadores_2[index2] );

            }
    
        }
    
        
    }
    Reporte_clase+= "</tbody> \n";
    Reporte_clase+= "</table> \n";
                
    Reporte_clase+="</body>";
    Reporte_clase+="</html>";


}
*/
/*-----------------------------------------Reportes Copia Funciones y Variables----------------------*/
/*function copiafyv(principal:Narbol.Nodo_Arbol,copia:Narbol.Nodo_Arbol){

    try {
        /*Analizo primero el root principal */ /*
principal.lista_Nodo.forEach(element => {
    if (element.tipo=="Clase") {
        MYFPrincipal = [];
        MYFfCopia = [];
        /*por cada calse encontrada, la busco en el otro arbol
        copia.lista_Nodo.forEach(element2 => {
            if (element2.tipo=="Clase") {
                /*Por cada clase que encuentro en el otro root compruebo si son los mismos
                if (element.descripcion==element2.descripcion) {
                    /*recorro para encontrar los metodos y funciones de la clase principal
                    element.lista_Nodo.forEach(element3 => {
                        if(element3.tipo=="Funcion"){
                            MYFPrincipal.push(element3.descripcion);
                            /*encontramos si tiene parametros la funcion
                            element3.lista_Nodo.forEach(parametrosMF => {
                                if(parametrosMF.tipo=="Parametros"){
                                    var parametroslst = returnLst(parametrosMF.lista_Nodo);
                                    element2.lista_Nodo.forEach(fmCopia => {
                                        if (fmCopia.tipo=="Funcion" && element3.tipodato==fmCopia.tipodato) {
                                            fmCopia.lista_Nodo.forEach(paramCopia => {
                                                if (paramCopia.tipo=="Parametros"){
                                                    var parametroslstCopia = returnLst(paramCopia.lista_Nodo);
                                                    if (parametroslst.toString()==parametroslstCopia.toString()) {
                                                        console.log("las funciones "+element3.descripcion+" Son iguales en ambos archivos,por tener los mismos tipos de parametros en el mismo orden"+" de la calse "+element.descripcion);
                                                        MYFfCopia_Clase.push(element.descripcion);
                                                        MYFfCopia.push(element3.descripcion);
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }
                            });
                        }else if(element3.tipo=="Metodo"){
                            MYFPrincipal.push(element3.descripcion);
                            /*encontramos si tiene parametros la funcion
                            element3.lista_Nodo.forEach(parametrosF => {
                                if(parametrosF.tipo=="Parametros"){
                                    var parametroslstM = returnLst(parametrosF.lista_Nodo);
                                    element2.lista_Nodo.forEach(mCopia => {
                                        if (mCopia.tipo=="Metodo" && element3.descripcion==mCopia.descripcion) {
                                            mCopia.lista_Nodo.forEach(paramCopiaM => {
                                                if (paramCopiaM.tipo=="Parametros"){
                                                    var parametroslstCopiaM = returnLst(paramCopiaM.lista_Nodo);
                                                    if (parametroslstM.toString()==parametroslstCopiaM.toString()) {
                                                        console.log("los metodos "+element3.descripcion+" Son iguales en ambos archivos,por tener los mismos tipos de parametros en el mismo orden"+" de la calse "+element.descripcion);
                                                        MYFfCopia.push(element3.descripcion);
                                                        MYFfCopia.push(element3.descripcion);
                                                    }
                                                }
                                            });
                                        }
                                    });
                                }
                            });
                        }
                    });
                    if(MYFPrincipal.toString()==MYFfCopia.toString()){
                        console.log("las clases "+element.descripcion+" Son iguales en ambos archivos");
                    }
                }
            }
        });
    }
});
} catch (error) {

}


}

function rec(){

Reporte_funcion ="";
Reporte_funcion = "<!DOCTYPE html> ";
Reporte_funcion+="<html lang=\"en\">";
Reporte_funcion+="<head>";
Reporte_funcion+="<meta charset=\"UTF-8\">";
Reporte_funcion+="<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
Reporte_funcion+="<title>Reporte de Clases copia</title>";
Reporte_funcion+="<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\" integrity=\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\" crossorigin=\"anonymous\">";
Reporte_funcion+="<script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js\" integrity=\"sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6\" crossorigin=\"anonymous\"></script>";
Reporte_funcion+="</head>";
Reporte_funcion+="<body>";
Reporte_funcion+="<H1>Reporte de Funciones</H1>";
Reporte_funcion+= "<table class=\"table\"><thead class=\"thead-dark\"> \n";
Reporte_funcion+="<tr> \n";
Reporte_funcion+= "<th scope=\"col\">#</th> \n";
Reporte_funcion+= "<th scope=\"col\">Noombre del metodo o funcion copia</th> \n";
Reporte_funcion+= "<th scope=\"col\">Clase copia a la que pertenecen</th> \n";
Reporte_funcion+= "</tr> \n";
Reporte_funcion+= "</thead> \n";
Reporte_funcion+= "<tbody>";
var No=1;
for (let index = 0; index < MYFfCopia.length; index++) {

Reporte_funcion+= "<tr> \n";
Reporte_funcion+= "<th scope=\"row\">"+No+"</th> \n";
Reporte_funcion+="<td>"+MYFfCopia[index]+"</td><td>"+
                       MYFfCopia_Clase[index]+"</td>\n";
Reporte_funcion+="</tr>\n";
No=No+1;

    console.log("------------------------------------------------");
    console.log(MYFfCopia[index]);
    console.log(MYFfCopia_Clase[index]);
    

}
Reporte_funcion+= "</tbody> \n";
Reporte_funcion+= "</table> \n";
            
Reporte_funcion+="</body>";
Reporte_funcion+="</html>";

}

function returnLst(lstLista:Array<Narbol.Nodo_Arbol>):Array<String>{
var temporalLst:Array<String>=[];
if(lstLista.length>0){
lstLista.forEach(element => {
    temporalLst.push(element.tipo);
});
}

return temporalLst;
}
*/
var server = app.listen(9000, function () {
    console.log('Servidor escuchando en puerto 9000...');
});
function prueba(texto) {
    try {
        return gramatica.parse(texto);
    }
    catch (error) {
        return "Error en compilacion de Entrada: " + error.toString();
    }
}
