import 'package:path/path.dart'; // Importa a biblioteca path
import 'package:sa3_persistencia/UserModel.dart'; // Importa o modelo de usuário
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
      version: 2, // Versão do banco de dados
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
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NOME,
          where: 'email = ? AND senha = ?',
          whereArgs: [email, senha]); // Consulta o usuário na tabela pelo email e senha

      if (maps.isNotEmpty) {
        return User.fromMap(maps.first); // Retorna o usuário encontrado
      } else {
        return null; // Retorna nulo se o usuário não for encontrado
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Método para verificar se um usuário com o mesmo email já existe no banco de dados
Future<bool> existsUser(String email) async {
  try {
    final Database db = await _chamarBanco();
    final List<Map<String, dynamic>> maps = await db.query(
      TABLE_NOME,
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.isNotEmpty; // Retorna true se o usuário já existe, senão retorna false
  } catch (ex) {
    print(ex);
    return false; // Em caso de erro, retorna false
  }
}


  // Método para verificar se um usuário com o nome especificado já está registrado no banco de dados
  Future<bool> existsUserByName(String name) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NOME,
        where: 'nome = ?',
        whereArgs: [name],
      ); // Consulta o usuário na tabela pelo nome

      return maps.isNotEmpty; // Retorna true se o usuário for encontrado, false caso contrário
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}
