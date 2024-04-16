import 'package:flutter/material.dart';
import 'DataBaseController.dart'; // Importa o controlador do banco de dados
import 'UserModel.dart'; // Importa o modelo de usuário

// Tela de cadastro de usuário
class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'), // Título da tela
      ),
      body: Center(
        child: CadastroForm(), // Formulário de cadastro
      ),
    );
  }
}

// Formulário de cadastro de usuário
class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>(); // Chave global do formulário
  TextEditingController _nomeController = TextEditingController(); // Controlador do campo de nome
  TextEditingController _emailController = TextEditingController(); // Controlador do campo de e-mail
  TextEditingController _senhaController = TextEditingController(); // Controlador do campo de senha

  // Função para cadastrar um novo usuário
  void cadastrarUsuario(BuildContext context) async {
    String name = _nomeController.text; // Obtém o nome inserido
    String email = _emailController.text; // Obtém o e-mail inserido
    String password = _senhaController.text; // Obtém a senha inserida

    User user = User(nome: name, email: email, senha: password); // Cria um novo usuário

    BancoDadosCrud bancoDados = BancoDadosCrud(); // Instância do controlador do banco de dados
    try {
      bancoDados.create(user); // Insere o usuário no banco de dados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')), // Exibe um aviso de sucesso
      );
      Navigator.pop(context); // Fecha a tela de cadastro e retorna para a tela anterior (provavelmente a de login)
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')), // Exibe um aviso de erro
      );
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
                'Cadastro', // Título do formulário
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'), // Rótulo do campo de nome
                validator: (value) { // Validação do campo de nome
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira seu nome';
                  }
                  if (!RegExp(r'^[a-zA-ZÀ-ú-\s]+$').hasMatch(value!)) {
                    return 'Nome inválido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'), // Rótulo do campo de e-mail
                validator: (value) { // Validação do campo de e-mail
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira seu e-mail';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value!)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) { // Se o formulário for válido, cadastra o usuário
                    cadastrarUsuario(context);
                  }
                },
                child: Text('Cadastrar'), // Texto do botão de cadastro
              ),
            ],
          ),
        ),
      ),
    );
  }
}
