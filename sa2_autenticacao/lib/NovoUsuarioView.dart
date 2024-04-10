import 'package:flutter/material.dart';
import 'package:sa2_autenticacao/Controller.dart';

class NovoUsuarioView extends StatefulWidget {
  @override
  _NovoUsuarioViewState createState() => _NovoUsuarioViewState();
}

class _NovoUsuarioViewState extends State<NovoUsuarioView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final BancoDadosCrud _dbHelper = BancoDadosCrud();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nome de Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _criarNovoUsuario(context),
              child: Text('Criar novo usuário'),
            ),
          ],
        ),
      ),
    );
  }

  void _criarNovoUsuario(BuildContext context) async {
  String username = _usernameController.text.trim();
  String password = _passwordController.text.trim();

  if (username.isEmpty || password.isEmpty) {
    _mostrarAlerta(context, 'Erro', 'Por favor, preencha todos os campos.');
    return;
  }

  bool? usuarioExistente = await _dbHelper.verificarUsuario(username, password);
  if (usuarioExistente == null) {
    _mostrarAlerta(context, 'Erro', 'Ocorreu um erro ao verificar o usuário.');
  } else if (usuarioExistente) {
    _mostrarAlerta(context, 'Erro', 'O nome de usuário já está em uso.');
  } else {
    await _dbHelper.inserirUsuario(username, password);
    _mostrarAlerta(context, 'Sucesso', 'Novo usuário criado com sucesso!');
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }
}


  void _mostrarAlerta(BuildContext context, String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: [
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
}

