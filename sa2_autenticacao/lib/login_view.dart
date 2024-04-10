import 'package:flutter/material.dart';
import 'package:sa2_autenticacao/Controller.dart';
import 'package:sa2_autenticacao/NovoUsuarioView.dart';
import 'package:sa2_autenticacao/PaginaUsuario.dart'; // Importe a tela NovoUsuarioView

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final BancoDadosCrud _dbHelper = BancoDadosCrud();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _NovoUsuario, // Chamada da função para a tela NovoUsuarioView
              child: Text('Novo usuário'),
            ),
          ],
        ),
      ),
    );
  }
void _login() async {
  String username = _usernameController.text.trim();
  String password = _passwordController.text.trim();

  if (username.isEmpty || password.isEmpty) {
    _mostrarAlerta(context, 'Erro', 'Por favor, preencha todos os campos.');
    return;
  }

  // Verifica se o login é bem-sucedido
  bool? loginSucesso = await _dbHelper.verificarUsuario(username, password);
  
  // Verifica se o valor retornado não é nulo
  if (loginSucesso != null) {
    if (loginSucesso) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaUsuario()),
      );
    } else {
      _mostrarAlerta(context, 'Erro', 'Nome de usuário ou senha inválidos.');
    }
  } else {
    _mostrarAlerta(context, 'Erro', 'Ocorreu um erro ao verificar o usuário.');
  }
}



  void _NovoUsuario() {
    // Navega para a tela NovoUsuarioView
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NovoUsuarioView()),
    );
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




