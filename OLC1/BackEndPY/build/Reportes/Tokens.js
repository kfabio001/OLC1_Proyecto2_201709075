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
exports.Tokens = void 0;
var Tokens = /** @class */ (function (_super) {
    __extends(Tokens, _super);
    function Tokens() {
        return _super.call(this) || this;
    }
    Tokens.add = function (err) {
        this.prototype.push(err);
    };
    Tokens.mostrar = function () {
        for (var i = 0; i < this.prototype.length; i++) {
            console.log(this.prototype[i].getdescripcion() + " Tipo: " + this.prototype[i].gettipo() + " Linea: " + this.prototype[i].getlinea() + " Columna: " + this.prototype[i].getcolumna());
        }
    };
    Tokens.mostrar_Lista = function () {
        var texto = "";
        texto = "<!DOCTYPE html> ";
        texto += "<html lang=\"en\">";
        texto += "<head>";
        texto += "<meta charset=\"UTF-8\">";
        texto += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
        texto += "<title>Reporte Token</title>";
        texto += "<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\" integrity=\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\" crossorigin=\"anonymous\">";
        texto += "<script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js\" integrity=\"sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6\" crossorigin=\"anonymous\"></script>";
        texto += "</head>";
        texto += "<body>";
        texto += "<H1>Lista de Token</H1>";
        texto += "<table class=\"table\"><thead class=\"thead-dark\"> \n";
        texto += "<tr> \n";
        texto += "<th scope=\"col\">#</th> \n";
        texto += "<th scope=\"col\">Nombre</th> \n";
        texto += "<th scope=\"col\">Descripcion</th> \n";
        texto += "<th scope=\"col\">Fila</th> \n";
        texto += "<th scope=\"col\">Columna</th> \n";
        texto += "</tr> \n";
        texto += "</thead> \n";
        texto += "<tbody>";
        var No = 1;
        for (var i = 0; i < this.prototype.length; i++) {
            texto += "<tr> \n";
            texto += "<th scope=\"row\">" + No + "</th> \n";
            texto += "<td>" + this.prototype[i].gettipo() + "</td><td>" +
                this.prototype[i].getdescripcion() + "</td><td>" +
                this.prototype[i].getlinea() + "</td>\n";
            this.prototype[i].getcolumna() + "</td>\n";
            texto += "</tr>\n";
            No = No + 1;
        }
        texto += "</tbody> \n";
        texto += "</table> \n";
        texto += "</body>";
        texto += "</html>";
        return texto;
    };
    Tokens.Vacio = function () {
        var vacio = false;
        while (this.prototype.length > 0) {
            return true;
        }
        return vacio;
    };
    Tokens.clear = function () {
        while (this.prototype.length > 0) {
            this.prototype.pop();
        }
    };
    return Tokens;
}(Array));
exports.Tokens = Tokens;
