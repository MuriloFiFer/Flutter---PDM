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
  List<Tarefa> _tarefas = []; // Lista de tarefas
  TextEditingController _controller =
      TextEditingController(); // Controlador de texto para o campo de adição de tarefa

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
      _tarefas = _loadTarefasFromPrefs() ?? []; // Obtém a lista de tarefas
    });
  }

  // Carrega a lista de tarefas salva nas preferências
  List<Tarefa>? _loadTarefasFromPrefs() {
    List<String>? tarefasStrings = _prefs.getStringList('${email}Tarefas');
    if (tarefasStrings != null) {
      return tarefasStrings.map((e) => Tarefa.fromPrefString(e)).toList();
    }
    return null;
  }

  // Salva a lista de tarefas nas preferências
  Future<void> _saveTarefasToPrefs() async {
    List<String> tarefasStrings =
        _tarefas.map((e) => e.toPrefString()).toList();
    await _prefs.setStringList('${email}Tarefas', tarefasStrings);
  }

  // Adiciona uma nova tarefa à lista e salva a preferência
  Future<void> _adicionarTarefa(String novaTarefa) async {
    if (novaTarefa.isNotEmpty) {
      setState(() {
        _tarefas.add(Tarefa(descricao: novaTarefa, concluida: false));
      });
      await _saveTarefasToPrefs();
      _mostrarSnackBar('Tarefa adicionada: $novaTarefa');
      // Limpa o campo de texto
      _limparCampoTexto();
    } else {
      _mostrarSnackBar('A tarefa não pode ser vazia');
    }
  }

  // Remove uma tarefa da lista e atualiza a preferência
  Future<void> _removerTarefa(int index) async {
    setState(() {
      _tarefas.removeAt(index);
    });
    await _saveTarefasToPrefs();
    _mostrarSnackBar('Tarefa removida');
  }

  // Atualiza uma tarefa da lista e atualiza a preferência
  Future<void> _atualizarTarefa(int index, String novaTarefa) async {
    setState(() {
      _tarefas[index].descricao = novaTarefa;
    });
    await _saveTarefasToPrefs();
    _mostrarSnackBar('Tarefa atualizada');
  }

  // Marca tarefa como concluída ou não concluída
  void _marcarComoConcluida(int index, bool concluida) {
    setState(() {
      _tarefas[index].concluida = concluida;
    });
    _saveTarefasToPrefs();
  }

  // Método para limpar o campo de texto
  void _limparCampoTexto() {
    setState(() {
      _controller.clear();
    });
  }

  // Método para exibir um SnackBar com a mensagem fornecida
  void _mostrarSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
                  title: Text(_tarefas[index].descricao),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botão de edição da tarefa
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              TextEditingController controller =
                                  TextEditingController(
                                      text: _tarefas[index].descricao);
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
                                  // Botão de cancelar edição
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  // Botão de salvar edição
                                  TextButton(
                                    onPressed: () {
                                      _atualizarTarefa(
                                          index, controller.text);
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
                      // Botão de exclusão da tarefa
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmar Exclusão'),
                                content: Text(
                                    'Tem certeza que deseja excluir esta tarefa?'),
                                actions: <Widget>[
                                  // Botão de cancelar exclusão
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  // Botão de confirmar exclusão
                                  TextButton(
                                    onPressed: () {
                                      _removerTarefa(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Confirmar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      // Checkbox para marcar a tarefa como concluída
                      Checkbox(
                        value: _tarefas[index].concluida,
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
          // Campo para adicionar nova tarefa
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller, // Adiciona um controlador de texto
                    decoration: InputDecoration(labelText: 'Nova Tarefa'),
                    onSubmitted: (novaTarefa) {
                      _adicionarTarefa(novaTarefa);
                    },
                  ),
                ),
                // Botão para adicionar nova tarefa
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _adicionarTarefa(_controller.text); // Usa o texto do controlador
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

// Classe que define uma tarefa
class Tarefa {
  late String descricao; // Descrição da tarefa
  late bool concluida; // Indica se a tarefa está concluída

  // Construtor
  Tarefa({required this.descricao, required this.concluida});

  // Método para converter a tarefa em uma string para ser salva nas preferências
  String toPrefString() {
    return '$descricao|$concluida';
  }

  // Método para criar uma tarefa a partir de uma string salva nas preferências
  factory Tarefa.fromPrefString(String prefString) {
    List<String> parts = prefString.split('|');
    return Tarefa(
      descricao: parts[0],
      concluida: parts[1] == 'true',
    );
  }
}
