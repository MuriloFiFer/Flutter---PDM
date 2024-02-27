// Responsável por transformar todos os outros módulos em uma aplicação
// Permite fazer a navegação entre as páginas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa1_lista_compra/ItemController.dart'; // Importa o controlador de itens
import 'package:sa1_lista_compra/ItemView.dart'; // Importa a visualização de itens

class ListaItensApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define a tela inicial como ListaItensScreen
      home: ChangeNotifierProvider(
        create: (context) => ItemController(), // Cria uma instância do controlador de itens
        child: ListaItensScreen(), // Define a tela inicial como ListaItensScreen
      ),
    );
  }
}
