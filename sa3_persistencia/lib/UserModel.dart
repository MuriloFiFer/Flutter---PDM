// Classe de modelo de usuário
class User {
  // Atributos
  String nome; // Nome do usuário
  String email; // Email do usuário
  String senha; // Senha do usuário

  // Construtor
  User({
    required this.nome,
    required this.email,
    required this.senha,
  });

  // Método para criar um usuário a partir de um mapa
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nome: map['nome'], // Obtém o nome do mapa
      email: map['email'], // Obtém o email do mapa
      senha: map['senha'], // Obtém a senha do mapa
    );
  }

  // Método para converter o usuário em um mapa
  Map<String, dynamic> toMap() {
    return {
      'nome': nome, // Adiciona o nome ao mapa
      'email': email, // Adiciona o email ao mapa
      'senha': senha, // Adiciona a senha ao mapa
    };
  }
}
