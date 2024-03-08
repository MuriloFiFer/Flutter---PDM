import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 2',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Utilização de ROW e COLUM'),      
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(          
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Título explicativo
              Text(
                'Row em AZUL e Colum em VERDE ',                
                style: TextStyle(fontSize: 20.0, color: Colors.red), // deixando o texto com a cor vermelha
              ),
              SizedBox(height: 20.0), // Espaço entre o título e os widgets

              // Primeiro Row com dois Container horizontalmente
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.blue,
                    width: 100.0,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        'Widget 1', // Texto do primeiro Container
                        style: TextStyle(color: Colors.white), // Estilo do texto
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0), // Espaço entre os Container
                  Container(
                    color: Colors.blue,
                    width: 100.0,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        'Widget 2', // Texto do segundo Container
                        style: TextStyle(color: Colors.white), // Estilo do texto
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0), // Espaço entre os Row e Column

          

              // Column com dois Container verticalmente
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    width: 200.0,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        'Widget 3', // Texto do primeiro Container
                        style: TextStyle(color: Colors.white), // Estilo do texto
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0), // Espaço entre os Container
                  Container(
                    color: Colors.green,
                    width: 200.0,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        'Widget 4', // Texto do segundo Container
                        style: TextStyle(color: Colors.white), // Estilo do texto
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
