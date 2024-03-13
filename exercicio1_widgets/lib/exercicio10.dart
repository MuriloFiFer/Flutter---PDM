import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 10',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool _isMoved = false; // Variável para controlar o estado da animação

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interface com Animação'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isMoved = !_isMoved; // Alternar o estado da variável quando o widget é tocado
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000), // Duração da animação em milissegundos
            curve: Curves.easeInOut, // Curva de animação para suavizar o movimento
            width: _isMoved ? 300 : 200, // Largura do widget dependendo do estado da variável
            height: _isMoved ? 200 : 100, // Altura do widget dependendo do estado da variável
            color: _isMoved ? Colors.red : Colors.blue, // Cor do widget dependendo do estado da variável
            child: Center(
              child: Text(
                'Clique aqui!', // Texto do widget
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
