"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Instruccion = void 0;
var Instruccion = /** @class */ (function () {
    /**
     *
     * @param line      Linea de la instruccion
     * @param column    Columna de la instruccion
     */
    function Instruccion(line, column) {
        this.line = 0;
        this.column = 0;
        this.line = line;
        this.column = column;
    }
    return Instruccion;
}());
exports.Instruccion = Instruccion;
