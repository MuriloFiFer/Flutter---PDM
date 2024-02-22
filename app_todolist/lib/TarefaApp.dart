//Responsavel por transformar todos os outros modulos em uma aplicação
//Perite fazer a navegação entre as paginas
import 'package:app_lista1/TarefaController.dart';
import 'package:app_lista1/TarefaView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Definindo a tela inicial como a ListaTarefasS
      home: ChangeNotifierProvider(
        create: (context) => ListaTarefaControler(),
        child: ListaTarefasScreen(),
      ),
    );
  }
}
