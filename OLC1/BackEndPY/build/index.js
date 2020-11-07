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
var lexicoPython_1 = require("./Python/lexicoPython");
var sintacticoPython_1 = __importDefault(require("./Python/sintacticoPython"));
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
    // console.log(resultado);
    // consola="";
    // console.log(resultado);
    if (Errores_1.Errores.Vacio()) {
        consola = "";
        // recorrer_tree_uno(resultado);
        //pyton(entrada); 
        cadena = "";
        //  graficar(resultado);
        // Tokens.clear();
        //Tokenss(resultado);
        var nada = "";
        //Errores.mostrar();
        var tree1 = JSON.stringify(resultado, null, 2);
        tree1 = tree1.split('descripcion').join('text').split('lista_Nodo').join('children');
        res.json({ arbol: tree1, MostrarError: Errores_1.Errores.mostrar(), MostrarEPython: sintacticoPython_1.default.EnviarErrores(),
            Rerror: Errores_1.Errores.mostrar_Lista().toString(), RerrorP: sintacticoPython_1.default.mostrar_Lista().toString(),
            Reporte_uno: consola, Reporte_dos: Tokens_1.Tokens.mostrar_Lista().toString(), ast: contenido });
        //  Errores.clear();  
    }
    else {
        consola = "";
        //  recorrer_tree_uno(resultado);
        //pyton(entrada); 
        Errores_1.Errores.clear();
        cadena = "";
        //graficar(resultado);
        //Tokens.clear();
        //Tokenss(resultado);
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
            res.json({ arbol: tree1, MostrarError: Errores_1.Errores.mostrar(), MostrarEPython: sintacticoPython_1.default.EnviarErrores(),
                Rerror: "nada", RerrorP: sintacticoPython_1.default.mostrar_Lista().toString(), Reporte_uno: consola,
                Reporte_dos: Tokens_1.Tokens.mostrar_Lista().toString(), ast: contenido });
        }
        else {
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
            // console.log(Nodos.tipo,Nodos.descripcion.toString(), Nodos.fila.toString(), Nodos.columna.toString());
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
function pyton(texto) {
    try {
        lexicoPython_1.scanner.ejecutar(texto);
        var resultado = sintacticoPython_1.default.ejecutar(lexicoPython_1.scanner);
        console.log(resultado.Traduccion);
    }
    catch (error) {
    }
}
/*----------------------------------------Reportes Copias clases--------------------------------*/
function recorrer_tree_uno(temporal) {
    try {
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
    catch (error) {
    }
}
var server = app.listen(9100, function () {
    console.log('Servidor Python escuchando en puerto 9100...');
});
function prueba(texto) {
    try {
        return gramatica.parse(texto);
    }
    catch (error) {
        return "Error en compilacion de Entrada: " + error.toString();
    }
}
