// Responsável por transformar todos os outros módulos em uma aplicação
// Permite fazer a navegação entre as páginas
import 'package:sa1_lista_compra/ItemController.dart';
import 'package:sa1_lista_compra/ItemView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaItensApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definindo a tela inicial como a ListaItensScreen
      home: ChangeNotifierProvider(
        create: (context) => ItemController(),
        child: ListaItensScreen(),
      ),
    );
  }
}
