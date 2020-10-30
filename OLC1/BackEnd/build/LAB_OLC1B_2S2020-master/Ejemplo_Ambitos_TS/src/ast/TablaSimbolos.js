"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TablaSimbolo = void 0;
var TablaSimbolo = /** @class */ (function () {
    function TablaSimbolo(anterior) {
        this.anterior = anterior;
    }
    //Agregando simbolos a mi tabla
    TablaSimbolo.prototype.add = function (simbolo) {
        this.tabla.push(simbolo);
    };
    return TablaSimbolo;
}());
exports.TablaSimbolo = TablaSimbolo;
