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
exports.Primitivo = void 0;
var Instruccion_1 = require("../Instruccion");
var Primitivo = /** @class */ (function (_super) {
    __extends(Primitivo, _super);
    /**
     * @class La clase Primitivo almacena el valor real (numero|cadena|booleano)
     * @param line linea del primitivo
     * @param column columna del primitivo
     * @param valor valor real
     */
    function Primitivo(valor, line, column) {
        var _this = _super.call(this, line, column) || this;
        _this.valor = valor;
        return _this;
    }
    Primitivo.prototype.translate = function () {
        return this.valor;
    };
    Primitivo.prototype.generarGrafo = function (g, padre) {
        var nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\"" + this.valor.toString() + "\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        return null;
    };
    Primitivo.prototype.getNombreHijo = function () {
        return "PRIMITIVO";
    };
    return Primitivo;
}(Instruccion_1.Instruccion));
exports.Primitivo = Primitivo;
