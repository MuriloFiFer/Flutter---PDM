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
    // Obtém os valores inseridos nos campos
    String name = _nomeController.text; // Obtém o nome inserido
    String email = _emailController.text; // Obtém o e-mail inserido
    String password = _senhaController.text; // Obtém a senha inserida

    // Cria um novo usuário com os valores inseridos
    User user = User(nome: name, email: email, senha: password);

    // Instância do controlador do banco de dados
    BancoDadosCrud bancoDados = BancoDadosCrud();
    try {
      // Insere o usuário no banco de dados
      bancoDados.create(user);
      // Exibe um aviso de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
      // Fecha a tela de cadastro e retorna para a tela anterior (provavelmente a de login)
      Navigator.pop(context);
    } catch (e) {
      // Em caso de erro, exibe um aviso de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
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
              // Título do formulário
              Text(
                'Cadastro',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Campo de nome
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
              // Campo de e-mail
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
              // Campo de senha
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
              // Botão de cadastro
              ElevatedButton(
                onPressed: () {
                  // Se o formulário for válido, cadastra o usuário
                  if (_formKey.currentState!.validate()) {
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
