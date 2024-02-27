import 'package:flutter/material.dart';

// Classe que gerencia os itens da lista
class ItemController extends ChangeNotifier {
  List<Item> _itens = [];

  // Getter para acessar a lista de itens
  List<Item> get itens => _itens;

  // Função para adicionar um novo item à lista
  void adicionarItem(String descricao) {
    _itens.add(Item(descricao, false)); // Adiciona um novo item à lista
    notifyListeners(); // Notifica os ouvintes (widgets) sobre a mudança na lista
  }

  // Função para verificar se um item já foi adicionado à lista
  bool itemJaAdicionado(String descricao) {
    return _itens.any((item) => item.descricao == descricao); // Verifica se a descrição já existe na lista
  }

  // Função para excluir um item da lista
  void excluirItem(int indice) {
    if (indice >= 0 && indice < _itens.length) {
      _itens.removeAt(indice); // Remove o item da lista
      notifyListeners(); // Notifica os ouvintes sobre a mudança na lista
    }
  }

  // Função para marcar um item como concluído ou não concluído
  void marcarItemComoConcluido(int indice) {
    if (indice >= 0 && indice < _itens.length) {
      _itens[indice].concluido = !_itens[indice].concluido; // Alterna o estado de conclusão do item
      notifyListeners(); // Notifica os ouvintes sobre a mudança na lista
    }
  }

  // Função para editar a descrição de um item existente
  void editarItem(int indice, String novaDescricao) {
    if (indice >= 0 && indice < _itens.length) {
      _itens[indice].descricao = novaDescricao; // Atualiza a descrição do item
      notifyListeners(); // Notifica os ouvintes sobre a mudança na lista
    }
  }
}

// Classe que representa um item na lista
class Item {
  String descricao; // Descrição do item
  bool concluido; // Estado de conclusão do item

  // Construtor da classe Item
  Item(this.descricao, this.concluido);
}
