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
exports.Declaracion = void 0;
var Instruccion_1 = require("../Instruccion");
var Declaracion = /** @class */ (function (_super) {
    __extends(Declaracion, _super);
    /**
     * @class La instruccion declaracion, inserta una nueva variable en la tabla de simbolos
     * @param id identificador de la variable
     * @param type tipo de la variable
     * @param line linea donde se declaro la variable
     * @param column columna donde se declaro la variable
     * @param valor valor de la expresion asociada a la variable
     */
    function Declaracion(type, id, valor, line, column) {
        var _this = _super.call(this, line, column) || this;
        _this.id = id;
        _this.type = type;
        _this.valor = valor;
        return _this;
    }
    Declaracion.prototype.translate = function () {
        // int a = 0;
        return "var " + this.id + " = " + this.valor.translate() + ";\n";
    };
    Declaracion.prototype.generarGrafo = function (g, padre) {
        var padreAux = padre; //Auxiar con nombre del padre
        //Tipo
        var nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\" Tipo: " + this.type.toString() + "\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        // Id
        nombreHijo = "nodo" + g.contador;
        g.grafo += "  " + nombreHijo + "[label=\"ID\"];\n";
        g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
        g.contador++;
        var padreHijo = nombreHijo;
        //Identificador
        nombreHijo = "nodo" + g.contador;
        /*let losIds = ""
        for(let i = 0; i<listaIds.length; i++){
            losIds += listaIds[i]+",";
        }
        g.grafo += "  " + nombreHijo + "[label=\" Id: " + losIds + "\"];\n";
        */
        g.grafo += "  " + nombreHijo + "[label=\" Id: " + this.id + "\"];\n";
        g.grafo += "  " + padreHijo + " -> " + nombreHijo + ";\n";
        g.contador++;
        if (this.valor != null) {
            //Expresion
            nombreHijo = "nodo" + g.contador;
            g.grafo += "  " + nombreHijo + "[label=\"" + this.valor.getNombreHijo() + "\"];\n";
            g.grafo += "  " + padre + " -> " + nombreHijo + ";\n";
            g.contador++;
            this.valor.generarGrafo(g, nombreHijo);
        }
        return null;
    };
    Declaracion.prototype.getNombreHijo = function () {
        return "DECLARACION";
    };
    return Declaracion;
}(Instruccion_1.Instruccion));
exports.Declaracion = Declaracion;
