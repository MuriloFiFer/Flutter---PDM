import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'DataBaseController.dart'; // Importa o controlador do banco de dados
import 'UserModel.dart'; // Importa o modelo de usuário
import 'ViewCadastro.dart'; // Importa a tela de cadastro
import 'ViewConfiguracoes.dart'; // Importa a tela de configurações

// Tela de login
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'), // Título da tela
      ),
      body: Center(
        child: LoginForm(), // Formulário de login
      ),
    );
  }
}

// Formulário de login
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); // Chave global do formulário
  TextEditingController _emailController = TextEditingController(); // Controlador do campo de e-mail
  TextEditingController _senhaController = TextEditingController(); // Controlador do campo de senha
  bool _loading = false; // Variável para indicar se o login está em andamento

  // Função para realizar o login
  void _login() async {
    if (_formKey.currentState!.validate()) { // Valida o formulário
      String email = _emailController.text; // Obtém o e-mail inserido
      String senha = _senhaController.text; // Obtém a senha inserida

      setState(() {
        _loading = true; // Define que o login está em andamento
      });

      BancoDadosCrud bancoDados = BancoDadosCrud(); // Instância do controlador do banco de dados
      try {
        User? user = await bancoDados.getUser(email, senha); // Obtém o usuário do banco de dados
        if (user != null) { // Se o usuário existir
          Navigator.push( // Navega para a tela de configurações
            context,
            MaterialPageRoute(
              builder: (context) => ConfiguracoesPage(email: user.email),
            ),
          );
        } else { // Se o usuário não existir
          ScaffoldMessenger.of(context).showSnackBar(SnackBar( // Exibe um aviso ao usuário
            content: Text('Email ou senha incorretos'),
          ));
        }
      } catch (e) {
        print('Erro durante o login: $e'); // Exibe o erro ocorrido durante o login
        ScaffoldMessenger.of(context).showSnackBar(SnackBar( // Exibe um aviso ao usuário
          content: Text('Erro durante o login. Tente novamente mais tarde.'),
        ));
      } finally {
        setState(() {
          _loading = false; // Define que o login terminou
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login', // Título do formulário
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'), // Rótulo do campo de e-mail
                validator: (value) { // Validação do campo de e-mail
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  } else if (!isValidEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')), // Impede a inserção de números
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'), // Rótulo do campo de senha
                obscureText: true, // Esconde o texto digitado no campo de senha
                validator: (value) { // Validação do campo de senha
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _loading // Se o login estiver em andamento, exibe um indicador de progresso
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login, // Executa a função de login ao pressionar o botão
                      child: Text('Acessar'), // Texto do botão de login
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()), // Navega para a tela de cadastro
                  );
                },
                child: Text('Não tem uma conta? Cadastre-se'), // Texto para navegar para a tela de cadastro
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para validar o formato do e-mail
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
