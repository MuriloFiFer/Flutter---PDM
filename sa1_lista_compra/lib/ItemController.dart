import 'package:flutter/material.dart';

class ItemController extends ChangeNotifier {
  List<Item> _itens = [];

  List<Item> get itens => _itens;

  // Função para adicionar um novo item
  void adicionarItem(String descricao) {
    _itens.add(Item(descricao, false));
    notifyListeners();
  }

  // Função para verificar se um item já foi adicionado
  bool itemJaAdicionado(String descricao) {
    return _itens.any((item) => item.descricao == descricao);
  }

  // Função para excluir um item
  void excluirItem(int indice) {
    if (indice >= 0 && indice < _itens.length) {
      _itens.removeAt(indice);
      notifyListeners();
    }
  }

  // Função para marcar um item como concluído
  void marcarItemComoConcluido(int indice) {
    if (indice >= 0 && indice < _itens.length) {
      _itens[indice].concluido = !_itens[indice].concluido;
      notifyListeners();
    }
  }

  // Função para editar um item existente
  void editarItem(int indice, String novaDescricao) {
    if (indice >= 0 && indice < _itens.length) {
      _itens[indice].descricao = novaDescricao;
      notifyListeners();
    }
  }
}

class Item {
  String descricao;
  bool concluido;

  Item(this.descricao, this.concluido);
}
