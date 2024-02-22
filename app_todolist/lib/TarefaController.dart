import 'package:app_lista1/TarefaModel.dart';
import 'package:flutter/material.dart';

class ListaTarefaControler extends ChangeNotifier {
  //Cria uma lista, baseada no model tarefas
  List<Tarefa> _tarefas = [];

//Getter para acessar alista de tarefas
  List<Tarefa> get tarefas => _tarefas;

//Metodos CRUD
//Metodo para adicionar uma nova tarefa à lista
  void adicionarTarefas(String descricao) {
    _tarefas.add(Tarefa(descricao, false));
    //Notifica os ouvidos (widgets) sobre a mudança do estado
    notifyListeners();
  }

//Meotodo para marcar como concluida
  void marcarComoConcluida(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas[indice].concluida = true;
      notifyListeners();
    }
  }

  void excluirTarefa(int indice) {
    if (indice >= 0 && indice < _tarefas.length) {
      _tarefas.removeAt(indice);
      notifyListeners();
    }
  }
}
