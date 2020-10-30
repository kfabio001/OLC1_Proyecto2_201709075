export class Nodo{
    //public id:number;
    public descripcion:string;
    public tipo:string;
    public hijos:Array<Nodo>
    tipodato:string="";

    constructor(tipoC:string,des:string){//,idC:number
        this.hijos = [];
        this.tipo = tipoC;
        this.descripcion=des;
        //this.id = idC;
    }

    encontrarNode(listaNodo:Array<Nodo>){
        for(let i=0;i<listaNodo.length;i++){
            this.hijos.push(listaNodo[i]);
        }
    }
}