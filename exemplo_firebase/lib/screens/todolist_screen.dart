import 'package:flutter/material.dart';
import '../controller/todolist_controller.dart';
import '../models/todolist.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final AuthService _service = AuthService();
  final TodolistController _controller = TodolistController();
  final _tituloController = TextEditingController();
  bool _isList = false;

  Future<void> _getList() async {
    try {
      await _controller.fetchList(widget.user.uid);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar da tela de lista de tarefas
        title: const Text('Todo List Firebase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Logout do usuário
              await _service.logoutUsuario();
              Navigator.pushReplacementNamed(context, '/home');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: _getList(),
                  builder: (context, snapshot) {
                    if (_controller.list.isNotEmpty) {
                      // Exibição da lista de tarefas
                      return ListView.builder(
                        itemCount: _controller.list.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_controller.list[index].titulo),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                // Excluir tarefa ao pressionar o ícone de exclusão
                                await _controller
                                    .delete(_controller.list[index].id);
                                _getList();
                                setState(() {});
                              },
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      // Tratamento de erro caso ocorra algum problema
                      return Text(snapshot.error.toString());
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Botão flutuante para adicionar nova tarefa
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Nova Tarefa"),
                content: TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(hintText: "Digite a tarefa"),
                ),
                actions: [
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Todolist add = Todolist(
                          id: (_controller.list.length + 1).toString(),
                          titulo: _tituloController.text,
                          userId: widget.user.uid,
                          timestamp: DateTime.now());
                      _controller.add(add);
                      _getList();
                      setState(() {});
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
