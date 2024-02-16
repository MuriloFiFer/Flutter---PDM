import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(AdivinhacaoApp());
}

class AdivinhacaoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Adivinhacao(),
    );
  }
}

class Adivinhacao extends StatefulWidget {
  @override
  _AdivinhacaoState createState() => _AdivinhacaoState();
}

class _AdivinhacaoState extends State<Adivinhacao> {
  final TextEditingController _controllerNumero =
      TextEditingController(); // Controlador para o campo de entrada de texto
  String _resultado = ''; // Variável para armazenar o resultado da adivinhação
  late int
      _numeroAdivinhar; // Variável para armazenar o número a ser adivinhado
  bool _adivinhou =
      false; // Variável para controlar se o usuário já acertou o número ou não
  int _tentativas = 0; // Variável para contar o número de tentativas

  @override
  void initState() {
    super.initState();
    _iniciarJogo(); // Inicia o jogo quando o widget é inicializado
  }

  // Função para iniciar um novo jogo
  void _iniciarJogo() {
    final random = Random();
    _numeroAdivinhar =
        random.nextInt(100) + 1; // Gera um número aleatório entre 1 e 100

    _adivinhou = false; // Reseta o estado de adivinhação
    _tentativas = 0; // Reseta o número de tentativas
    setState(() {
      _resultado = ''; // Reseta o resultado
    });
  }

  // Função para verificar se o número inserido pelo usuário é correto
  void _verificarAdivinhacao() {
    final int? numero = int.tryParse(_controllerNumero.text);
    //verificação de "numero" digitado pelo usuario para ser inteiro ou nulo
    //se int o codigo incrementa a tentativa e segue com a logica se não pede para digitar novamente;
    if (numero != null) {
      _tentativas++; // Incrementa o número de tentativas
      //logica para verificar o numero digitado pelo usuario
      //se "numero" = "_numeroAdivinhar"  logo  "_adivinhou" = "true" , assim encerra a logica;
      if (numero == _numeroAdivinhar) {
        setState(() {
          _adivinhou = true;
          _resultado =
              'Parabéns! Você adivinhou o número $_numeroAdivinhar em $_tentativas tentativas!'; // Mostra a mensagem de acerto
        });
      } else if (numero < _numeroAdivinhar) {
        setState(() {
          _resultado =
              'Tente um número maior'; // Mostra a mensagem para tentar um número maior
        });
      } else {
        setState(() {
          _resultado =
              'Tente um número menor'; // Mostra a mensagem para tentar um número menor
        });
      }
    } else {
      setState(() {
        _resultado =
            'Por favor, insira um número válido'; // Mensagem de erro para entrada inválida
      });
    }

    //logica para limpar o o campo de entrada do usuario (labelText)
    if (!_adivinhou) {
      _controllerNumero
          .clear(); // Limpa o campo de entrada se o usuário não tiver adivinhado corretamente
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo de Adivinhação'), //campo do titulo
      ),
      backgroundColor:
          const Color.fromARGB(255, 154, 201, 224), // Definindo a cor de fundo
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerNumero,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Insira um número entre 1 e 100'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _adivinhou ? _iniciarJogo : _verificarAdivinhacao,
              child: Text(_adivinhou ? 'Iniciar Novamente' : 'Verificar'),
            ),
            SizedBox(height: 16.0),
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            if (_tentativas > 0)
              Text(
                'Tentativas: $_tentativas',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }
}
