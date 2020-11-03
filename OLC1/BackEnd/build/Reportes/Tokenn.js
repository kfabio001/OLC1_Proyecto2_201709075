"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Tokenn = void 0;
var Tokenn = /** @class */ (function () {
    function Tokenn(tipo, descripcion, linea, columna) {
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.linea = (linea + 1);
        this.columna = (columna + 1);
    }
    Tokenn.prototype.gettipo = function () {
        return this.tipo;
    };
    Tokenn.prototype.getdescripcion = function () {
        return this.descripcion;
    };
    Tokenn.prototype.getlinea = function () {
        return this.linea;
    };
    Tokenn.prototype.getcolumna = function () {
        return this.columna;
    };
    return Tokenn;
}());
exports.Tokenn = Tokenn;
//export{Tokenn};
