"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.miAuxiliar = exports.analizar = void 0;
var Analisis_1 = require("./Analisis");
exports.analizar = function (req, res) {
    //console.log("query: ",req.query.codigo)
    var codigo = req.query.codigo;
    //let respuesta = codigo;
    var respuesta = Analisis_1.AnalizarJava(codigo);
    //console.log(respuesta);
    //console.log("params: ",req.params)
    var a = [{ 'analisis': respuesta }, { 'grafo': 'reporteAST' }, { 'errores': 'reporteErrores' }];
    res.send(a);
};
/*
{
    codigo: "class id { ... }"
}
*/
exports.miAuxiliar = function (req, res) {
    console.log("params: ", req.params);
    res.send("no me motiva a echarle ganas al curso :'v");
};
