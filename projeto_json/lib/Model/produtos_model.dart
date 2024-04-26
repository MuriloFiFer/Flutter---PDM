class Produto{
//atributos
int id;
String nome;
String descricao;
int quantidade;
String foto;
double preco;
List<String> categorias;

//Construtor
Produto({
  required this.id,
  required this.nome,
  required this.descricao,
  required this.categorias,  
  required this.foto,
  required this.quantidade,
  required this.preco,
});


//Métodos  (toJson / fromJson)
Map<String,dynamic> toJson() =>{
  'id':id,
  'nome':nome,
  'descricao':descricao,
  'categorias':categorias,
  'foto':foto,
  'quantidade':quantidade,
  'preco':preco,
};


}