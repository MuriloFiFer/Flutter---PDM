import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa1_lista_compra/ItemController.dart';

class ListaItensScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController(); // Controlador para o campo de texto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 190, 221), // Cor de fundo da tela
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 206, 200, 200), // Cor de fundo da barra de título
        title: Text('Lista de compras'), // Título da barra de título
      ),
      body: Column(
        children: [
          // Campo de texto para adicionar novo item
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Novo Item', // Rótulo do campo de texto
                suffixIcon: IconButton(
                  onPressed: () {
                    _adicionarNovoItem(context, _controller.text); // Chama a função para adicionar novo item
                  },
                  icon: Icon(Icons.add), // Ícone de adicionar
                ),
              ),
            ),
          ),
          Expanded(
            // Lista de itens usando um Consumer do Provider para atualização automática
            child: Consumer<ItemController>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.itens.length, // Número de itens na lista
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(model.itens[index].descricao),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        _excluirItemPorGesto(context, model, index); // Exclui um item ao deslizar
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await _confirmarExclusaoPorBotao(context); // Confirmação de exclusão ao deslizar
                      },
                      child: ListTile(
                        title: Text(model.itens[index].descricao), // Texto do item
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _excluirItemPorBotao(context, model, index); // Exclui um item ao pressionar o botão
                              },
                            ),
                            Checkbox(
                              value: model.itens[index].concluido,
                              onChanged: (value) {
                                _marcarItemComoConcluido(context, model, index); // Marca um item como concluído
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          _editarItem(context, model, index); // Permite editar um item ao pressionar
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Função para adicionar um novo item à lista
  void _adicionarNovoItem(BuildContext context, String descricao) {
    if (descricao.trim().isEmpty) {
      _mostrarAlerta(context, 'Campo vazio', 'Por favor, insira um nome para o item.'); // Alerta se o campo estiver vazio
    } else if (Provider.of<ItemController>(context, listen: false).itemJaAdicionado(descricao)) {
      _mostrarAlerta(context, 'Item já adicionado', 'Este item já foi adicionado à lista.'); // Alerta se o item já estiver na lista
    } else {
      Provider.of<ItemController>(context, listen: false).adicionarItem(descricao.trim()); // Adiciona o item à lista
      _controller.clear(); // Limpa o campo de texto após adicionar o item
    }
  }

  // Função para exibir um alerta
  void _mostrarAlerta(BuildContext context, String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo), // Título do alerta
          content: Text(mensagem), // Conteúdo do alerta
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'), // Botão OK para fechar o alerta
            ),
          ],
        );
      },
    );
  }

  // Função para excluir um item ao deslizar
  void _excluirItemPorGesto(BuildContext context, ItemController model, int index) {
    final deletedItem = model.itens[index];
    Provider.of<ItemController>(context, listen: false).excluirItem(index); 
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedItem.descricao} foi excluído.'), // Mensagem de confirmação de exclusão
        action: SnackBarAction(
          label: 'Desfazer', //botão para desfazer a exclusão
          onPressed: () {
            Provider.of<ItemController>(context, listen: false).adicionarItem(deletedItem.descricao); // Desfaz a exclusão
          },
        ),
      ),
    );
  }

  // Função para confirmar a exclusão ao pressionar o botão
  Future<bool?> _confirmarExclusaoPorBotao(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir item'), // Título do alerta de confirmação
          content: Text('Tem certeza que deseja excluir este item?'), // Mensagem do alerta de confirmação
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancela a exclusão
              },
              child: Text('Cancelar'), // Botão para cancelar
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirma a exclusão
              },
              child: Text('Excluir'), // Botão para excluir
            ),
          ],
        );
      },
    );
  }

  // Função para excluir um item ao pressionar o botão
  void _excluirItemPorBotao(BuildContext context, ItemController model, int index) async {
    final confirmarExclusao = await _confirmarExclusaoPorBotao(context);
    if (confirmarExclusao != null && confirmarExclusao) {
      _excluirItemPorGesto(context, model, index); // Exclui o item
    }
  }

  // Função para marcar um item como concluído
  void _marcarItemComoConcluido(BuildContext context, ItemController model, int index) {
    model.marcarItemComoConcluido(index); // Marca o item como concluído
  }

  // Função para editar um item
  void _editarItem(BuildContext context, ItemController model, int index) {
    final TextEditingController _editController = TextEditingController();
    _editController.text = model.itens[index].descricao;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar item'), // Título do diálogo de edição
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              labelText: 'Nova descrição', // Rótulo do campo de texto para a nova descrição
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancela a edição
              },
              child: Text('Cancelar'), // Botão para cancelar
            ),
            TextButton(
              onPressed: () {
                if (_editController.text.trim().isEmpty) {
                  _mostrarAlerta(context, 'Campo vazio', 'Por favor, insira um nome para o item.'); // Alerta se o campo estiver vazio
                } else if (model.itemJaAdicionado(_editController.text)) {
                  _mostrarAlerta(context, 'Item já adicionado', 'Este item já foi adicionado à lista.'); // Alerta se o item já estiver na lista
                } else {
                  model.editarItem(index, _editController.text.trim()); // Salva a edição do item
                  Navigator.of(context).pop(); // Fecha o diálogo de edição
                }
              },
              child: Text('Salvar'), // Botão para salvar a edição
            ),
          ],
        );
      },
    );
  }
}
