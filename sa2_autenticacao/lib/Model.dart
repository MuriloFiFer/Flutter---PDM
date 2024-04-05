class UsuarioModel {

  //Atributos
  int id;
  String nome;
  String email;
  String telefone;
  String endereco;
  String idade;

  //Construtor
  UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.endereco,
    required this.idade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,   //id=coluna do banco, id= atributo 
      'name': nome,
      'email': email,
      'telefore': telefone,
      'endereco': endereco,
      'indade': idade,
    };
  }

    factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      endereco: map['endereco'],
      idade: map['idade'],
    );
  }
}


