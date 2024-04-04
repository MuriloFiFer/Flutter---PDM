class ContatoModel {

  //Atributos
  int id;
  String nome;
  String email;
  String telefone;
  String endereco;

  //Construtor
  ContatoModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.endereco,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,   //id=coluna do banco, id= atributo 
      'name': nome,
      'email': email,
      'telefore': telefone,
      'endereco': endereco,
    };
  }

    factory ContatoModel.fromMap(Map<String, dynamic> map) {
    return ContatoModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      endereco: map['endereco'],
    );
  }
}


