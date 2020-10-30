"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.Asignacion = void 0;
var Instruccion_1 = require("../Instruccion");
var Asignacion = /** @class */ (function (_super) {
    __extends(Asignacion, _super);
    /**
     *  a = 5;
     * @class La instruccion asignacion, modifica el valor de una variable en la tabla de simbolos
     * @param id identificador de la variable que se va a modificar
     * @param line linea donde se esata asignando el nuevo valor a la variable
     * @param column columna donde se esata asignando el nuevo valor a la variable
     * @param valor nuevo valor que se le asignara a la variable
     */
    function Asignacion(id, valor, line, column) {
        var _this = _super.call(this, line, column) || this;
        _this.id = id;
        _this.valor = valor;
        return _this;
    }
    Asignacion.prototype.translate = function () {
        return this.id + " = " + this.valor.translate() + ";\n";
    };
    Asignacion.prototype.generarGrafo = function (g, padre) {
        //Identificador
        var nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\" Id: " + this.id + "\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\"" + this.valor.getNombreHijo() + "\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        this.valor.generarGrafo(g, nombreHijo);
        return null;
    };
    Asignacion.prototype.getNombreHijo = function () {
        return "ASIGNACION";
    };
    return Asignacion;
}(Instruccion_1.Instruccion));
exports.Asignacion = Asignacion;
