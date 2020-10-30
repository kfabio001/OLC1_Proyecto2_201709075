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
exports.Identificador = void 0;
var Instruccion_1 = require("../Instruccion");
var Identificador = /** @class */ (function (_super) {
    __extends(Identificador, _super);
    /**
     * @class La Identificador, almacena el id de la variable a la que se esta accesando
     * @param line linea del primitivo
     * @param column columna del primitivo
     * @param id identificador de la variable a la que se accesa
     */
    function Identificador(id, line, column) {
        var _this = _super.call(this, line, column) || this;
        _this.id = id;
        return _this;
    }
    Identificador.prototype.translate = function () {
        return this.id;
    };
    Identificador.prototype.generarGrafo = function (g, padre) {
        var nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\"" + this.id + "\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        return null;
    };
    Identificador.prototype.getNombreHijo = function () {
        return "IDENTIFICADOR";
    };
    return Identificador;
}(Instruccion_1.Instruccion));
exports.Identificador = Identificador;
