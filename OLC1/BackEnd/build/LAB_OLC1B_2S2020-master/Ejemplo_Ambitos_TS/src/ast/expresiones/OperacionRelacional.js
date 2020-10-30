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
exports.OperacionRelacional = void 0;
var Instruccion_1 = require("../Instruccion");
var Tipo_1 = require("../Tipo");
var OperacionRelacional = /** @class */ (function (_super) {
    __extends(OperacionRelacional, _super);
    /**
     * @class La expresion OperacionRelacional, realiza la operacion Relacional dependiendo del tipo que le sea asigando
     * @param line linea de la expresion
     * @param column columna de la expresion
     * @param operador1 operador izquierdo
     * @param operador2 operador derecho
     * @param tipoOperacion tipo de operacion de la expresion Relacional
     */
    function OperacionRelacional(tipoOperacion, operador1, operador2, line, column) {
        var _this = _super.call(this, line, column) || this;
        _this.operador1 = operador1;
        _this.operador2 = operador2;
        _this.tipoOperacion = tipoOperacion;
        return _this;
    }
    OperacionRelacional.prototype.translate = function () {
        switch (this.tipoOperacion) {
            case Tipo_1.TypeOperation.MAYOR:
                return this.operador1.translate() + " > " + this.operador2.translate();
            case Tipo_1.TypeOperation.MENOR:
                return this.operador1.translate() + " < " + this.operador2.translate();
        }
        return "";
    };
    OperacionRelacional.prototype.generarGrafo = function (g, padre) {
        //Operador1
        var nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\"" + this.operador1.getNombreHijo() + "\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        this.operador1.generarGrafo(g, nombreHijo);
        //Operador2
        nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\"" + this.operador2.getNombreHijo() + "\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        this.operador2.generarGrafo(g, nombreHijo);
        return null;
    };
    OperacionRelacional.prototype.getNombreHijo = function () {
        switch (this.tipoOperacion) {
            case Tipo_1.TypeOperation.MAYOR: {
                return "MAYOR";
            }
            case Tipo_1.TypeOperation.MENOR: {
                return "MENOR_QUE";
            }
            default: {
                return "";
            }
        }
    };
    return OperacionRelacional;
}(Instruccion_1.Instruccion));
exports.OperacionRelacional = OperacionRelacional;
