"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
var express = require("express");
var cors = __importStar(require("cors"));
var controller = __importStar(require("./controller"));
//Creamos una nueva instancia para nuestra aplicacion
var app = express();
//configuraciones
app.set('port', 3000);
//middlewares
app.use(cors());
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
//rutas
app.get('/', function (req, res) {
    res.send("Compiladores 1 - Secci\u00F3n B, http://localhost:" + app.get('port'));
});
app.get('/analisis', controller.analizar);
app.post('/miAuxiliar', controller.miAuxiliar);
exports.default = app;
