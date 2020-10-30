"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AnalizarJava = void 0;
var Gramatica = require("../Gramatica/gramatica");
var GrafoAST_1 = require("./ast/grafo/GrafoAST");
function AnalizarJava(entrada) {
    console.log("***********************************");
    console.log(entrada);
    console.log("***********************************");
    var codigo = " \n        numeric a=0.0;\n        while(true){ \n            a = \"hola\"+\":)\"+59.5*12.2+(10.9*12.12-56.56/0.1);\n            print(a+b||c>d);\n        }\n    ";
    // Analisis Lexico y Sintactico
    var ast = Gramatica.parse(codigo);
    //Generacion de grafo
    var nuevoCodigo = ast.translate();
    console.log("\n\n---------------- TRADUCCION ----------------\n");
    console.log(nuevoCodigo);
    console.log("\n--------------------------------------------\n");
    //Inicia la generacion del grafo
    var grafoAST = new GrafoAST_1.GrafoAST(ast);
    var txtDotAST = grafoAST.getGrafo();
    console.log("\n\n------------------- GRAFO -------------------\n");
    console.log(txtDotAST);
    console.log("\n--------------------------------------------\n");
    return nuevoCodigo;
}
exports.AnalizarJava = AnalizarJava;
