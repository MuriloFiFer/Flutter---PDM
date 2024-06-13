import 'package:cloud_firestore/cloud_firestore.dart';

class Todolist {
  // Atributos da tarefa
  final String id;
  final String titulo;
  final String userId;
  final DateTime timestamp;

  // Construtor
  Todolist({required this.id, required this.titulo, required this.userId, required this.timestamp});

  // Método para converter em mapa
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'userid': userId,
      'timestamp': timestamp
    };
  }

  // Método para criar a partir de um mapa
  factory Todolist.fromMap(Map<String, dynamic> map, String doc) {
    return Todolist(
      id: doc,
      titulo: map['titulo'],
      userId: map['userid'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
