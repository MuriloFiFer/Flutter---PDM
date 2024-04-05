//montar a estrutura para banco de dados (CRUD)
import 'package:sa2_autenticacao/Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class BancoDadosCrud {
  static const String DB_NOME = 'sa2.db'; // Nome do banco de dados
  static const String TABELA_NOME = 'usuarios'; // Nome da tabela
  static const String
      CREATE_USERS_TABLE_SCRIPT = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS USERS(id INTEGER PRIMARY KEY," +
          "nome TEXT, email TEXT, telefone TEXT," +
          "endereco TEXT)";


 
  Future<Database> _getDatabase() async {  //async (conexão com o banco assincrona, roda sem parar a aplicação)
    return openDatabase(
      join(
          await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            CREATE_USERS_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }
  // Método para criar um novo Usuario no banco de dados
  Future<void> create(UsuarioModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(
          TABELA_NOME, model.toMap()); // Insere o Usuario no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }


  // Método para obter todos os Usuarios do banco de dados
  Future<List<UsuarioModel>> getContacts() async {
    try {
      final Database db = await _getDatabase();  //aguarda para estapelecer a conexão. await e getdatabase
      final List<Map<String, dynamic>> maps =
          await db.query(TABELA_NOME); // Consulta todos os Usuarios na tabela


      return List.generate(
        maps.length,
        (i) {
        return UsuarioModel.fromMap(maps[

              i]); // Converte os resultados da consulta para objetos ContactModel
        },
      );
    } catch (ex) {
      print(ex);
      return [];
    }
  }


  // Método para atualizar um Usuario no banco de dados
  Future<void> update(UsuarioModel model) async {
    try {
      final Database db = await _getDatabase();
      await db.update(
        TABELA_NOME,
        model.toMap(),
        where: "id = ?", // Condição para atualizar o Usuario com base no ID
        whereArgs: [model.id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }


  // Método para excluir um Usuario do banco de dados
  Future<void> delete(int id) async {
    try {
      final Database db = await _getDatabase();
      await db.delete(
        TABELA_NOME,
        where: "id = ?", // Condição para excluir o Usuario com base no ID
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }
}

