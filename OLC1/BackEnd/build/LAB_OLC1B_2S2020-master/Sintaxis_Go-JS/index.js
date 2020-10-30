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
var id1 = ["hola", "adios"];
var id1;
/*
DEC_STATIC_ARRAY -> 'let' id ':' TIPO [ ] '=' EXP_ARRAY         // Static
            | 'let' id ':' TIPO [ EXP ] '=' EXP_ARRAY           // Static
            | 'let' id ':' TIPO [ EXP ] { $$ = new DecArray(....,[],...) }                       // Static
            | 'let' id ':' 'ArrayList' '<' TIPO '>'
            | 'let' id ':' 'ArrayList' '<' TIPO '>' = EXP_ARRAY
            | 'let' id ':' 'ArrayList' '<' TIPO '>' = 'new' 'ArrayList' '<' TIPO '>'  '(' ')'

EXP_ARRAY -> '[' LISTA_EXP ']'
            | '{' LISTA_EXP '}'

*/
var DecArrayStatic = /** @class */ (function (_super) {
    __extends(DecArrayStatic, _super);
    function DecArrayStatic(tipoVar, id, tipoDato, expDim, listExp) {
        var _this = this;
        return _this;
    }
    return DecArrayStatic;
}(Instruccion));
object;
ejecutar(ts, Tabla, arbol, AST);
{
    if (expDim != null) { // 'let' id ':' TIPO [ EXP ] '=' EXP_ARRAY     // Static
        var dimension = expDim.ejecutar();
        if (dimension.valor == listExp.length) {
            var valorArreglo_1 = new ArrayList; //valor
            Simbolo;
            newArreglo = new Simbolo();
            for (var _i = 0, listExp_1 = listExp; _i < listExp_1.length; _i++) { //Iterando lista expresiones
                var exp = listExp_1[_i];
                var e = exp.ejecutar(ts, arbol);
                if (e instanceof nodoError || typeof (e) != tipoDato) {
                    console.log("error de tipos o en la expreision en la dimension");
                    return null;
                }
                valorArreglo_1.push(e);
            }
            newArreglo.addSimboloArreglo(tipoEstructura.STATIC_ARRAY, tipoVar, dimension.valor, id, tipoDato, valorArreglo_1);
            ts.addSimbolo(newArreglo);
        }
        else {
            console.log("error el la dimension del arreglo estatico");
        }
    }
    else { // 'let' id ':' TIPO [ ] '=' EXP_ARRAY         // Static
        var valorArreglo_2 = new ArrayList; //valor
        Simbolo;
        newArreglo = new Simbolo();
        for (var _a = 0, listExp_2 = listExp; _a < listExp_2.length; _a++) { //Iterando lista expresiones
            var exp = listExp_2[_a];
            var e = exp.ejecutar(ts, arbol);
            if (e instanceof nodoError || typeof (e) != tipoDato) {
                console.log("error de tipos o en la expreision en la dimension");
                return null;
            }
            valorArreglo_2.push(e);
        }
        newArreglo.addSimboloArreglo(tipoEstructura.STATIC_ARRAY, tipoVar, listExp.length, id, tipoDato, valorArreglo_2);
        ts.addSimbolo(newArreglo);
    }
}
//------------------------TABLA SIMBOLOS
var valorArreglo = new ArrayList; //valor
var tipoEdd = false;
var dimensioArreglo = 0;
function addSimboloArreglo(tipoEdd, tipoVar, dimensionArreglo, id, tipoDato, listaDatos) {
    this.valorArreglo = listaDatos;
}
var tipoEstructura;
(function (tipoEstructura) {
    tipoEstructura[tipoEstructura["PRIMITIVO"] = 0] = "PRIMITIVO";
    tipoEstructura[tipoEstructura["OBJETO"] = 1] = "OBJETO";
    tipoEstructura[tipoEstructura["STATIC_ARRAY"] = 2] = "STATIC_ARRAY";
    tipoEstructura[tipoEstructura["ARRAYLIST"] = 3] = "ARRAYLIST";
})(tipoEstructura || (tipoEstructura = {}));
