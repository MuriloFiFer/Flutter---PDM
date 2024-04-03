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

  Map<String, Object?> toMap() {}

  static Future<List<ContatoModel>> fromMap(Map<String, dynamic> map) {}

  //Mapeamento
  

}