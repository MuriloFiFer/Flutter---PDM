import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todolist.dart';

class TodolistController {
  // Lista de tarefas
  List<Todolist> _list = [];
  List<Todolist> get list => _list;

  // Conexão com o Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Métodos

  // Adicionar uma nova tarefa
  Future<void> add(Todolist todolist) async {
    await _firestore.collection('todolist').add(todolist.toMap());
  }

  // Deletar uma tarefa
  Future<void> delete(String id) async {
    await _firestore.collection('todolist').doc(id).delete();
  }

  // Buscar a lista de tarefas com base no userId
  Future<List<Todolist>> fetchList(String userId) async {
    final QuerySnapshot result = await _firestore.collection('todolist')
        .where('userid', isEqualTo: userId)
        .get();

    // Converter o resultado em uma lista de objetos Todolist
    List<dynamic> convert = result.docs as List;
    _list = convert.map((doc) => Todolist.fromMap(doc.data(), doc.id)).toList();

    return _list;
  }
}
