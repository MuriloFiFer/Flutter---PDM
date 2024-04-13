import 'package:path/path.dart'; // Importa a biblioteca path
import 'package:sa2_correcao/UserModel.dart'; // Importa o modelo de usuário
import 'package:sqflite/sqflite.dart'; // Importa a biblioteca sqflite

// Classe responsável pela manipulação do banco de dados
class BancoDadosCrud {
  static const String DB_NOME = 'users.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'users'; // Nome da tabela
  static const String
      SCRIPT_CRIACAO_TABELA = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY," +
          "nome TEXT, " +
          "email TEXT, " +
          "senha TEXT)";

  // Método para obter uma instância do banco de dados
  Future<Database> _chamarBanco() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            SCRIPT_CRIACAO_TABELA); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1, // Versão do banco de dados
    );
  }

  // Método para criar um novo usuário no banco de dados
  Future<void> create(User user) async {
    try {
      final Database db = await _chamarBanco();
      await db.insert(
          TABLE_NOME, user.toMap()); // Insere o usuário no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // Método para buscar um usuário pelo email e senha no banco de dados
  Future<User?> getUser(String email, String senha) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME,
          where: 'email = ? AND senha = ?',
          whereArgs: [email,senha]
          ); // Consulta o usuário na tabela pelo email e senha

      if (maps.isNotEmpty){
        return User.fromMap(maps.first); // Retorna o usuário encontrado
      }else{
        return null; // Retorna nulo se o usuário não for encontrado
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Método para verificar se um usuário existe no banco de dados
  Future<bool> existsUser(String email, String senha) async {
    bool acessoPermitido = false; // Variável para indicar se o acesso é permitido ou não
    try{
    final Database db = await _chamarBanco();
    final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME,
          where: 'email = ? AND senha = ?',
          whereArgs: [email,senha]
          ); // Consulta o usuário na tabela pelo email e senha

      if (maps.isNotEmpty){
        acessoPermitido = true; // Define que o acesso é permitido se o usuário for encontrado
        return acessoPermitido;
      }else{
        return acessoPermitido; // Retorna falso se o usuário não for encontrado
      }
    } catch (ex) {
      print(ex);
      return acessoPermitido;
    }
  }
}
