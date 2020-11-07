# Dillinger

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Ante el progreso en los lenguajes de programacion, cada vez es mas necesario contar con herramientas que faciliten la migracion de un lenguaje a otro ante este problema surge la salucion de crear un servicio de traduccion en los lenguajes

  - Java -> Python
  - Java -> JavaScript

# Al iniciar


  - Clikea el boton de "Agregar una pestaña", esta abrira la consola lista para empezar a escribir codigo
  - Si deseas quitar el codigo escrito puedes guardarlo en le boton "guardar" o eliminalo quitando la pestaña directamente en el boton "Quitar Pestaña"
  - Puedes agregar mas de una pestaña clikeando el boton "Agregar Pestaña" las veces que deses


# Traduce
  - Cuando termines tu codigo y desees ejecutarlo, clikea el boto "Analizar" la funsion de este es analizar la entrada escrita y generar las traducciones y tu puedes elegir cual guardar
  - Si seleccionas el boton "Descargar JavaScript" obtendras el codigo traducido a Javascirp
  - Si seleccionas el boton "Descargar Python" obtendras el codigo traducido a Python
  - Si por alguna razon se encontrara algun error este se mostrara en las consolas de salida pero no te preocupes este igual se traducira
  - Si deseas ver una manera mas grafica el resultado de tu analis puedes encontrar una seccion de reportes como el AST y el listado de tokens
  - Los errores tanto sintacticos como lexicos se muestran en los botones Errores JS y errores PY

El traductor reconoce la cadena de entrada la descompone en tokens y analisa sintacticamente su correcta forma por medio de la construccion del arbol de analisis sintactico


### Caracteristicas

El servidor corre en http://localhost:4000/ y todas sus funciones se muestran desde su pagina principal

-El servidor Frontend se desarrollo en golang
-El servidor Backend se desarrollo en nodejs
-El servidor Backend corre en el puerto 9000






