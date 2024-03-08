import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 1',
      home: Scaffold(
        appBar: AppBar(
          title: Text('widget Container com Childrens'),
        ),
        body: Center(
          child: Container(
            width: 400, // largura do Container
            height: 400, // altura do Container
            color: Colors.blue, // cor de fundo do Container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // alinhamento vertical
              children: <Widget>[
                Text(
                  'Widget Filho1', // texto do primeiro widget
                  style: TextStyle(color: Colors.white, fontSize: 20), // estilo do texto
                ),
                SizedBox(height: 20), // espaço entre os widgets
                Container(
                  width: 150, // largura do segundo widget
                  height: 100, // altura do segundo widget
                  color: Colors.green, // cor de fundo do segundo widget
                  child: Center(
                    child: Text(
                      'Widget Filho2', // texto do segundo widget
                      style: TextStyle(color: Colors.white, fontSize: 16), // estilo do texto
                    ),
                  ),
                ),
                SizedBox(height: 20), // espaço entre os widgets
                Container(
                  width: 150, // largura do terceiro widget
                  height: 100, // altura do terceiro widget
                  decoration: BoxDecoration(
                    color: Colors.orange, // cor de fundo do terceiro widget
                    borderRadius: BorderRadius.circular(10), // bordas arredondadas
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação ao pressionar o botão
                      },
                      child: Text('Widget Filho3'), // Texto do botão
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
