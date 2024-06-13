import 'package:exemplo_firebase/screens/todolist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Layout da tela de login com formulário para inserir e-mail e senha
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value) {},
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Senha'),
                  validator: (value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _acessarTodoList();
                  },
                  child: const Text("Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<User?> _loginUser() async {
    // Validação dos campos de e-mail e senha
    if (_formKey.currentState!.validate()) {
      return await _auth.loginUsuario(
          _emailController.text, _passwordController.text);
    } else {
      return null;
    }
  }

  Future<void> _acessarTodoList() async {
    User? user = await _loginUser();
    if (user != null) {
      print("ok");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TodolistScreen(user: user)));
    } else {
      // Mensagem de erro para credenciais inválidas
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuário ou senha inválidos"),
        ),
      );
      _emailController.clear();
      _passwordController.clear();
    }
  }
}
