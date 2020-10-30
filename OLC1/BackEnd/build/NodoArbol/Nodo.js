"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Nodo = void 0;
var Nodo = /** @class */ (function () {
    function Nodo(tipoC, des) {
        this.tipodato = "";
        this.hijos = [];
        this.tipo = tipoC;
        this.descripcion = des;
        //this.id = idC;
    }
    Nodo.prototype.encontrarNode = function (listaNodo) {
        for (var i = 0; i < listaNodo.length; i++) {
            this.hijos.push(listaNodo[i]);
        }
    };
    return Nodo;
}());
exports.Nodo = Nodo;
