import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa1_lista_compra/ItemController.dart';

class ListaItensScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 190, 221),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 206, 200, 200),
        title: Text('Lista de compras (adicione itens para sua lista de compras e selecione-o para concluir o item.)'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Novo Item',
                suffixIcon: IconButton(
                  onPressed: () {
                    _adicionarNovoItem(context, _controller.text);
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ItemController>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.itens.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(model.itens[index].descricao),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        _excluirItemPorGesto(context, model, index);
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
                        return await _confirmarExclusaoPorBotao(context);
                      },
                      child: ListTile(
                        title: Text(model.itens[index].descricao),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _excluirItemPorBotao(context, model, index);
                              },
                            ),
                            Checkbox(
                              value: model.itens[index].concluido,
                              onChanged: (value) {
                                _marcarItemComoConcluido(context, model, index);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          _editarItem(context, model, index);
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

  void _adicionarNovoItem(BuildContext context, String descricao) {
    if (descricao.trim().isEmpty) {
      _mostrarAlerta(context, 'Campo vazio', 'Por favor, insira um nome para o item.');
    } else if (Provider.of<ItemController>(context, listen: false).itemJaAdicionado(descricao)) {
      _mostrarAlerta(context, 'Item já adicionado', 'Este item já foi adicionado à lista.');
    } else {
      Provider.of<ItemController>(context, listen: false).adicionarItem(descricao.trim());
      _controller.clear();
    }
  }

  void _mostrarAlerta(BuildContext context, String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _excluirItemPorGesto(BuildContext context, ItemController model, int index) {
    final deletedItem = model.itens[index];
    Provider.of<ItemController>(context, listen: false).excluirItem(index);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedItem.descricao} foi excluído.'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            Provider.of<ItemController>(context, listen: false).adicionarItem(deletedItem.descricao);
          },
        ),
      ),
    );
  }

  Future<bool?> _confirmarExclusaoPorBotao(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir item'),
          content: Text('Tem certeza que deseja excluir este item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  void _excluirItemPorBotao(BuildContext context, ItemController model, int index) async {
    final confirmarExclusao = await _confirmarExclusaoPorBotao(context);
    if (confirmarExclusao != null && confirmarExclusao) {
      _excluirItemPorGesto(context, model, index);
    }
  }

  void _marcarItemComoConcluido(BuildContext context, ItemController model, int index) {
    model.marcarItemComoConcluido(index);
  }

  void _editarItem(BuildContext context, ItemController model, int index) {
    final TextEditingController _editController = TextEditingController();
    _editController.text = model.itens[index].descricao;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar item'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              labelText: 'Nova descrição',
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
                if (_editController.text.trim().isEmpty) {
                  _mostrarAlerta(context, 'Campo vazio', 'Por favor, insira um nome para o item.');
                } else if (model.itemJaAdicionado(_editController.text)) {
                  _mostrarAlerta(context, 'Item já adicionado', 'Este item já foi adicionado à lista.');
                } else {
                  model.editarItem(index, _editController.text.trim());
                  Navigator.of(context).pop();
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
