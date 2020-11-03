var contador=0;
function get_cont(){
    return contador++;
}

var vent_focus="pestana1";
function get_vent(){
    return vent_focus;
}

function set_vent(vent){
    vent_focus=vent;
}

var lista=new Array();
function linkedlist(pestana,nombre) {
    var obj=new Object();
    obj.pestana=pestana;
    obj.nombre=nombre;
    lista.push(obj);
}

function deletepes(pestana){
    for(var i=0;i<lista.length;i++){
        if(lista[i].pestana==pestana){
            delete lista[i];
        }
    }
}

/*--------------------------------------Funcion Al Cambiar Ventana---------------------------------------*/
function index(pestanias, pestania) {
    var id=pestania.replace('pestana','');
    set_vent('textarea'+id);

    var pestanna1 = document.getElementById(pestania);
    var listaPestannas = document.getElementById(pestanias);
    var cpestanna = document.getElementById('c'+pestania);
    var listacPestannas = document.getElementById('contenido'+pestanias);

    var i=0;
    while (typeof listacPestannas.getElementsByTagName('div')[i] != 'undefined'){
        $(document).ready(function(){
            $(listacPestannas.getElementsByTagName('div')[i]).css('display','none');
            $(listaPestannas.getElementsByTagName('li')[i]).css('background','');
            $(listaPestannas.getElementsByTagName('li')[i]).css('padding-bottom','');
        });
        i += 1;
    }

    $(document).ready(function(){
        $(cpestanna).css('display','');
        $(pestanna1).css('background','#70DB93');
        $(pestanna1).css('padding-bottom','2px');
    });

    try {
        var act=document.getElementById('cpestana'+id);
        var tact=document.getElementById('textarea'+id);/*esta forma jala el texto del area*/

        while (act.firstChild) {
            act.removeChild(act.firstChild);
        }

        act.appendChild(tact);
        var editor=CodeMirror(act, {
            lineNumbers: true,
            value: tact.value,
            matchBrackets: true,
            styleActiveLine: true,
            theme: "darcula",
            mode: "text/x-java"
        }).on('change', editor => {
            tact.value=editor.getValue();
        });
    }catch(error) {}
}

/*---------------------------------------Funcion Agregar Pestania----------------------------------------*/
function agregar() {
 
    var x=get_cont();
    var lu=document.getElementById("lista");
    var li=document.createElement("li");
    li.setAttribute('id','pestana'+x);
    var a=document.createElement("a");
    a.setAttribute('id','a'+x);
    a.setAttribute('href', 'javascript:index("pestanas","pestana'+x+'")');
    a.text='pestana'+x;
    li.appendChild(a);
    lu.appendChild(li);
    index("pestanas","pestana"+x);

    var contenido=document.getElementById("contenidopestanas");
    var divp=document.createElement("div");
    divp.setAttribute('id','cpestana'+x);
    var ta=document.createElement("textarea");
    ta.setAttribute('id','textarea'+x);
    ta.setAttribute('name','textarea'+x);
    ta.setAttribute('class','ta');
    ta.setAttribute('style','display:none');
    divp.appendChild(ta);
    contenido.appendChild(divp);

    var act=document.getElementById('cpestana'+x);
    var tact=document.getElementById('textarea'+x);
    var editor=CodeMirror(act, {
        lineNumbers: true,
        value: tact.value,
        matchBrackets: true,
        styleActiveLine: true,
        theme: "darcula",
        mode: "text/x-java"
    }).on('change', editor => {
        tact.value=editor.getValue();
    });
}
function consola(){
    var x = document.createElement("TEXTAREA");
    var t = document.createTextNode("Aklhvb");
    
    x.appendChild(t);
    document.body.appendChild(x);
    }


function quitar(){
    try{
        var lu=document.getElementById("lista");
        lu.removeChild(document.getElementById(get_vent().replace("textarea","pestana")));
        var contenido=document.getElementById("contenidopestanas");
        contenido.removeChild(document.getElementById(get_vent().replace("textarea","cpestana")));
        deletepes(get_vent());
    }catch(error){}
}


/*-----------------------------------------------File---------------------------------------------------*/
function AbrirArchivo(files){
    var file = files[0];
    var reader = new FileReader();
    reader.onload = function (e) {
        var act=document.getElementById(get_vent().replace("textarea","cpestana"));
        var tact=document.getElementById(get_vent());
        tact.value = e.target.result;

        while (act.firstChild) {
            act.removeChild(act.firstChild);
        }

        act.appendChild(tact);
        var editor=CodeMirror(act, {
            lineNumbers: true,
            value: tact.value,
            matchBrackets: true,
            styleActiveLine: true,
            theme: "darcula",
            mode: "text/x-java"
        }).on('change', editor => {
            tact.value=editor.getValue();
        });
    };
    reader.readAsText(file);
    file.clear;

    var a=document.getElementById(get_vent().replace("textarea","a"));
    a.text=file.name;
    linkedlist(get_vent(),file.name);

    var file_input=document.getElementById("fileInput");
    document.getElementById('fileInput').value="";
}

function DescargarArchivo(){
    //var ta=document.getElementById("cons");
    //var contenido=ta.value;//texto de vent actual
    var contenido=Reporte_Clases;
    //formato para guardar el archivo
    var hoy=new Date();
    var dd=hoy.getDate();
    var mm=hoy.getMonth()+1;
    var yyyy=hoy.getFullYear();
    var HH=hoy.getHours();
    var MM=hoy.getMinutes();
    var formato="doc"+dd+"_"+mm+"_"+yyyy+"_"+HH+"_"+MM;

    var nombre="Archivo"+formato+".jss";//nombre del archivo
    var file=new Blob([contenido], {type: 'text/plain'});

    if(window.navigator.msSaveOrOpenBlob){
        window.navigator.msSaveOrOpenBlob(file, nombre);
    }else{
        var a=document.createElement("a"),url=URL.createObjectURL(file);
        a.href=url;
        a.download=nombre;
        document.body.appendChild(a);
        a.click();
        setTimeout(function(){
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);  
        },0); 
    }
}

/*------------------------- Prueba de conexion -----------------------------------------------------*/
var Reporte_Error="";

var Reporte_ASTs="";

var Reporte_Clases="";

var Reporte_Metodos="";

var contador_manda="uno";

var javaConsola ="";

function Conn(){

    
    var ta = document.getElementById(get_vent());
    var contenido = ta.value;
    var url = "http://localhost:9000/Analizar/";
    var url2 = "http://localhost:9000/consol/";
    

    $.post(url,{text1:contenido, text2:contador_manda}, function(data,status){
        
        if (status.toString() == "success") {

            alert("El resultado es: "+ data.Rerror);
             // javaConsola= data.con;

                Reporte_ASTs = data.arbol;

                Reporte_Error = data.Rerror.toString();
            
                Reporte_Clases = data.Reporte_uno.toString();
                
                Reporte_Metodos = data.Reporte_dos.toString();

                Graphviz=data.ast.toString();

        }else{
            alert("Error estado de conexion: "+ status);
        }
    
    },"json");

    if(contador_manda.toString() == "dos"){
        
        //console.log(Reporte_Clases.toString());
        console.log("uno");     
        contador_manda="uno";

    }else{
        console.log("dos");
        contador_manda="dos";
    }
    
}

function Reporte_Errores(){

    var nueva_ventana = window.open('../Reporte_Errores','_blank');
    nueva_ventana.document.write(Reporte_Error);
    //alert(Reporte_Error)

}

function Pagina_Reporte_AST(){

    var nueva_ventana = window.open('../Reporte_AST','_blank');

    var textopagina="<!DOCTYPE html>";
    textopagina += "<html lang=\"en\">";
    textopagina += "<head>";
    textopagina += " <title>Reporte AST</title>";
    textopagina += "<meta charset=\"utf-8\">";
    textopagina += " <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">";
    textopagina += "<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\">";    
    textopagina += "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css\" />";
    textopagina += "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js\"></script>";
    textopagina += "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js\"></script>";
    textopagina += "<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js\"></script>";
    textopagina += "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js\"></script>";
    textopagina += "</head>";
    textopagina += "<body>";
    textopagina += "<div class=\"container\">";
    textopagina += "<h1>Display</h1>";
    textopagina += "<div id=\"jstree-tree\"></div>";
    textopagina += "<script src=\"//d3js.org/d3.v5.min.js\"></script>";
    textopagina += "<script src=\"https://unpkg.com/@hpcc-js/wasm@0.3.11/dist/index.min.js\"></script>";
    textopagina += "<script src=\"https://unpkg.com/d3-graphviz@3.0.5/build/d3-graphviz.js\"></script>";
    textopagina +=" <div id=\"graph\" style=\"text-align: center;\"></div>";
    textopagina +="<script> d3.select(\"#graph\").graphviz() .renderDot("+Graphviz+"); </script>";
    
    textopagina += "</div>";
    textopagina += "</body>";
    textopagina += "</html>";

    nueva_ventana.document.write(textopagina);
    //alert(textopagina);
    

}

function Reporte_unos(){
    console.log(Reporte_Clases.toString());
    var nueva_ventana = window.open('../Reporte_Clases','_blank');
    nueva_ventana.document.write(Reporte_Clases);
    //alert(Reporte_Error)

}


function Reporte_dos(){

    var nueva_ventana = window.open('../Reporte_Funciones','_blank');
    nueva_ventana.document.write(Reporte_Metodos);


}