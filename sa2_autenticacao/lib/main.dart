import 'package:flutter/material.dart';
import 'package:sa2_autenticacao/view.dart'; // Importe a página inicial após o login
import 'package:sa2_autenticacao/Controller.dart';
import 'package:sa2_autenticacao/Model.dart';


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
              onPressed: _createNewUser,
              child: Text('Novo usuário'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    // Aqui você deve adicionar a lógica de autenticação
    // Verificar o nome de usuário e a senha
    // Por enquanto, apenas navega para a próxima tela
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _createNewUser() {
    // Aqui você pode adicionar a navegação para a tela de criação de novo usuário
    // Exemplo:
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NovoUsuarioView()), // Substitua NewUserView pela tela de criação de usuário
    );
  }
}

class NovoUsuarioView extends StatefulWidget {

    @override
  _NovoUsuarioView createState() => _NovoUsuarioView();
}
 
class _NovoUsuarioView extends State<NovoUsuarioView> {
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
              onPressed: _createNewUser,
              child: Text('Novo usuário'),
            ),
          ],
        ),
      ),
    );
  }