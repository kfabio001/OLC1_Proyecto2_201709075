import { NodoError } from './Nodo_Error';

class Errores extends Array<NodoError>{

    constructor(){
        super();
    }

    public static add(err:NodoError){
        this.prototype.push(err);
    }

    public static mostrar(){
        for(var i=0; i<this.prototype.length;i++){
        
        console.log(this.prototype[i].getdescripcion()+" Tipo: "+this.prototype[i].gettipo()+" Linea: "+this.prototype[i].getlinea()+" Columna: "+this.prototype[i].getcolumna());
        
        }
    }

    public static mostrar_Lista():String{
        var texto:string="";
        texto = "<!DOCTYPE html> ";
        texto+="<html lang=\"en\">";
        texto+="<head>";
        texto+="<meta charset=\"UTF-8\">";
        texto+="<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
        texto+="<title>Reporte Errores</title>";
        texto+="<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css\" integrity=\"sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh\" crossorigin=\"anonymous\">";
        texto+="<script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js\" integrity=\"sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6\" crossorigin=\"anonymous\"></script>";
        texto+="</head>";
        texto+="<body>";
        texto+="<H1>Lista de Errores</H1>";
        texto+= "<table class=\"table\"><thead class=\"thead-dark\"> \n";
        texto+="<tr> \n";
        texto+= "<th scope=\"col\">#</th> \n";
        texto+= "<th scope=\"col\">Nombre</th> \n";
        texto+= "<th scope=\"col\">Descripcion</th> \n";
        texto+= "<th scope=\"col\">Fila</th> \n";
        texto+= "<th scope=\"col\">Columna</th> \n";
        texto+= "</tr> \n";
        texto+= "</thead> \n";
        texto+= "<tbody>";
        var No=1;
                        for(var i=0; i<this.prototype.length;i++){
                            texto+= "<tr> \n";
                            texto+= "<th scope=\"row\">"+No+"</th> \n";
                            texto+="<td>"+this.prototype[i].gettipo()+"</td><td>"+
                                this.prototype[i].getdescripcion()+"</td><td>"+
                                this.prototype[i].getlinea()+"</td>\n";
                                this.prototype[i].getcolumna()+"</td>\n";
                                texto+="</tr>\n";
                            No=No+1;
                        }
                        texto+= "</tbody> \n";
                        texto+= "</table> \n";
                    
                        texto+="</body>";
                        texto+="</html>";

        return texto;
    }
    
    public static Vacio():Boolean{

        var vacio:Boolean=false;

        while(this.prototype.length>0){
            return true;
        }

        return vacio;
    }

    public static clear(){
        while(this.prototype.length>0){
            this.prototype.pop();
        }
    }


}

export{Errores};