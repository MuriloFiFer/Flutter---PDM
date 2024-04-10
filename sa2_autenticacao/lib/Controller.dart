import 'package:path/path.dart';
import 'package:sa2_autenticacao/UsuarioModel.dart';
import 'package:sqflite/sqflite.dart';

class BancoDadosCrud {
  static const String DB_NOME = 'sa2.db';
  static const String TABELA_NOME = 'usuarios';
  static const String CREATE_USERS_TABLE_SCRIPT =
      "CREATE TABLE IF NOT EXISTS usuarios(id INTEGER PRIMARY KEY," +
      "nome TEXT, senha TEXT)";

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME),
      onCreate: (db, version) {
        return db.execute(CREATE_USERS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future<bool> verificarUsuario(String username, String password) async {
    try {
      final Database db = await _getDatabase();
      List<Map<String, dynamic>> result = await db.query(TABELA_NOME,
          where: 'nome = ? AND senha = ?', whereArgs: [username, password]);
      return result.isNotEmpty; // Se houver um usuário com o nome e senha fornecidos, retorna true
    } catch (ex) {
      print(ex);
      return false; // Em caso de erro, retorna false
    }
  }

  Future<void> inserirUsuario(String username, String password) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(
        TABELA_NOME,
        {'nome': username, 'senha': password},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Erro ao inserir usuário: $e");
    }
  }

  Future<List<UsuarioModel>> getUsers() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABELA_NOME);

      return List.generate(
        maps.length,
        (i) {
          return UsuarioModel(
            id: maps[i]['id'],
            nome: maps[i]['nome'],
            email: '', telefone: '', endereco: '', idade: '',
          );
        },
      );
    } catch (ex) {
      print(ex);
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  Future<void> create(UsuarioModel newUser) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(
        TABELA_NOME,
        newUser.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Erro ao criar usuário: $e");
    }
  }

  Future<bool> verificarLogin(String username, String password) async {
    try {
      final Database db = await _getDatabase();
      List<Map<String, dynamic>> result = await db.query(TABELA_NOME,
          where: 'nome = ? AND senha = ?', whereArgs: [username, password]);
      return result.isNotEmpty; // Se houver um usuário com o nome e senha fornecidos, retorna true
    } catch (ex) {
      print(ex);
      return false; // Em caso de erro, retorna false
    }
  }
  
}
