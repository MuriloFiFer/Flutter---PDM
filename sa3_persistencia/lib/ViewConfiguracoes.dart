import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Tela de configurações
class ConfiguracoesPage extends StatefulWidget {
  final String email; // Email do usuário

  ConfiguracoesPage({required this.email}); // Construtor

  @override
  _ConfiguracoesPageState createState() =>
      _ConfiguracoesPageState(email: email); // Estado da tela de configurações
}

// Estado da tela de configurações
class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences
      _prefs; // Instância de SharedPreferences para armazenar preferências
  final String email; // Email do usuário
  List<String> _tarefas = []; // Lista de tarefas

  _ConfiguracoesPageState({required this.email}); // Construtor

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carrega as preferências do usuário ao inicializar a tela
  }

  // Carrega as preferências do usuário
  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _tarefas = _prefs.getStringList('${email}Tarefas') ??
          []; // Obtém a lista de tarefas
    });
  }

  // Adiciona uma nova tarefa à lista e salva a preferência
  Future<void> _adicionarTarefa(String novaTarefa) async {
    setState(() {
      _tarefas.add(novaTarefa);
    });
    await _prefs.setStringList('${email}Tarefas', _tarefas);
  }

  // Remove uma tarefa da lista e atualiza a preferência
  Future<void> _removerTarefa(int index) async {
    setState(() {
      _tarefas.removeAt(index);
    });
    await _prefs.setStringList('${email}Tarefas', _tarefas);
  }

  // Atualiza uma tarefa da lista e atualiza a preferência
  Future<void> _atualizarTarefa(int index, String novaTarefa) async {
    setState(() {
      _tarefas[index] = novaTarefa;
    });
    await _prefs.setStringList('${email}Tarefas', _tarefas);
  }

  //Marca tarefa como concluída
  Future<void> _marcarComoConcluida(int index, bool concluida) async {
    setState(() {
      _tarefas[index] = _tarefas[index] + (concluida ? ' (Concluída)' : '');
    });
    await _prefs.setStringList('${email}Tarefas', _tarefas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'), // Título da tela
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tarefas[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              TextEditingController controller =
                                  TextEditingController(text: _tarefas[index]);
                              return AlertDialog(
                                title: Text('Editar Tarefa'),
                                content: TextField(
                                  controller: controller,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    labelText: 'Editar Tarefa',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _atualizarTarefa(index, controller.text);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Salvar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removerTarefa(
                              index); // Remove a tarefa ao ser pressionado o botão de exclusão
                        },
                      ),
                      Checkbox(
                        value: _tarefas[index].contains('(Concluída)'),
                        onChanged: (value) {
                          _marcarComoConcluida(index, value ?? false);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Nova Tarefa'),
                    onSubmitted: (novaTarefa) {
                      _adicionarTarefa(
                          novaTarefa); // Adiciona a nova tarefa à lista
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Adiciona a nova tarefa à lista
                    if (_tarefas.isNotEmpty) {
                      _adicionarTarefa(_tarefas.last);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
