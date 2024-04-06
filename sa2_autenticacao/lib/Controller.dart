import 'package:path/path.dart';
import 'package:sa2_autenticacao/Model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sa2_autenticacao/Model.dart';

class BancoDadosCrud {
  static const String DB_NOME = 'sa2.db';
  static const String TABELA_NOME = 'usuarios';
  static const String CREATE_USERS_TABLE_SCRIPT =
      "CREATE TABLE IF NOT EXISTS usuarios(id INTEGER PRIMARY KEY," +
          "nome TEXT, email TEXT, telefone TEXT," +
          "endereco TEXT)";

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME),
      onCreate: (db, version) {
        return db.execute(CREATE_USERS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future<void> create(UsuarioModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(TABELA_NOME, model.toMap());
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<UsuarioModel>> getUsers() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(TABELA_NOME);

      return List.generate(
        maps.length,
        (i) {
          return UsuarioModel.fromMap(maps[i]);
        },
      );
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<void> update(UsuarioModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.update(
        TABELA_NOME,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<void> delete(int id) async {
    try {
      final Database db = await _getDatabase();
      await db.delete(
        TABELA_NOME,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }
}
