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
exports.OperacionLogica = void 0;
var Instruccion_1 = require("../Instruccion");
var Tipo_1 = require("../Tipo");
var OperacionLogica = /** @class */ (function (_super) {
    __extends(OperacionLogica, _super);
    /**
     * @class La expresion OperacionLogica, realiza la operacion Logica dependiendo del tipo que le sea asigando
     * @param line linea de la expresion
     * @param column columna de la expresion
     * @param operador1 operador izquierdo
     * @param operador2 operador derecho
     * @param tipoOperacion tipo de operacion de la expresion Logica
     */
    function OperacionLogica(tipoOperacion, operador1, operador2, line, column) {
        var _this = _super.call(this, line, column) || this;
        _this.operador1 = operador1;
        _this.operador2 = operador2;
        _this.tipoOperacion = tipoOperacion;
        return _this;
    }
    OperacionLogica.prototype.translate = function () {
        switch (this.tipoOperacion) {
            case Tipo_1.TypeOperation.AND:
                return this.operador1.translate() + " and " + this.operador2.translate();
            case Tipo_1.TypeOperation.OR:
                return this.operador1.translate() + " or " + this.operador2.translate();
            case Tipo_1.TypeOperation.NOT:
                return " not " + this.operador1.translate();
        }
        return "";
    };
    OperacionLogica.prototype.generarGrafo = function (g, padre) {
        //Operador1
        var nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\"" + this.operador1.getNombreHijo() + "\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        this.operador1.generarGrafo(g, nombreHijo);
        if (this.operador2 != null) {
            //Operador2
            nombreHijo = "nodo" + g.contador;
            g.grafo += "  " + nombreHijo + "[label=\"" + this.operador2.getNombreHijo() + "\"];\n";
            g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
            g.contador++;
            this.operador2.generarGrafo(g, nombreHijo);
        }
        return null;
    };
    OperacionLogica.prototype.getNombreHijo = function () {
        switch (this.tipoOperacion) {
            case Tipo_1.TypeOperation.AND: {
                return "AND";
            }
            case Tipo_1.TypeOperation.OR: {
                return "OR";
            }
            default: {
                return "NOT";
            }
        }
    };
    return OperacionLogica;
}(Instruccion_1.Instruccion));
exports.OperacionLogica = OperacionLogica;
