import 'package:app_carros/CarrosController.dart';
import 'package:app_carros/TelaDetalheCarros.dart';
import 'package:flutter/material.dart';

class TelaListaCarros extends StatelessWidget {
  final ControllerCarros controllerCarros;

  TelaListaCarros(this.controllerCarros);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Carros'),
      ),
      body: ListView.builder(
        itemCount: controllerCarros.listarCarros.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(controllerCarros.listarCarros[index].modelo),
            onTap: () { 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetalhesCarro(controllerCarros.listarCarros[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicionar novo carro
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Use a TextEditingController to get user input
              TextEditingController nomeController = TextEditingController();
              TextEditingController urlController = TextEditingController();

              return AlertDialog(
                title: Text('Adicionar Novo Carro'),
                content: Column(
                  children: [
                    TextField(
                      controller: nomeController,
                      decoration: InputDecoration(labelText: 'Nome do Carro'),
                    ),
                    TextField(
                      controller: urlController,
                      decoration: InputDecoration(labelText: 'URL da Imagem'),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      // Adicionar novo carro
                      controllerCarros.adicionarCarro(
                        nomeController.text,
                        2023, // You can adjust the year as needed
                        urlController.text,
                      );

                      // Atualizar a interface
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('Adicionar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Fechar o diálogo sem adicionar o carro
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
