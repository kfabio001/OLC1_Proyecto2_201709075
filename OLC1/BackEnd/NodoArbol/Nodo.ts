export class Nodo{
    //public id:number;
    public descripcion:string;
    public tipo:string;
    public hijos:Array<Nodo>
    tipodato:string="";
    public fila:number;
    public columna:number;

    constructor(tipoC:string,des:string,fil:number,colm:number){//,idC:number
        this.hijos = [];
        this.tipo = tipoC;
        this.descripcion=des;
        this.fila=fil;
        this.columna=colm;
        //this.id = idC;
    }

    encontrarNode(listaNodo:Array<Nodo>){
        for(let i=0;i<listaNodo.length;i++){
            this.hijos.push(listaNodo[i]);
        }
    }
}