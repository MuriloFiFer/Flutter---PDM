import 'package:flutter/material.dart';

void main() {
  runApp(ContactForm());
}

// Classe principal que define o aplicativo Flutter
class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio6', // Título do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema principal do aplicativo
      ),
      home: ContactFormPage(), // Define a página inicial do aplicativo
    );
  }
}

// Página do formulário de contato
class ContactFormPage extends StatefulWidget {
  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

// Estado da página do formulário de contato
class _ContactFormPageState extends State<ContactFormPage> {
  // Controladores para os campos do formulário
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mensagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtém o tamanho da tela
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define uma variável de tamanho para o espaçamento entre os widgets
    final double spacing = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Contato com uso de Media Query'), // Título da barra de aplicativos
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // Preenchimento ao redor do conteúdo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Constrói o campo de entrada de texto para o nome
            buildTextField(
              labelText: 'Nome',
              controller: _nomeController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            SizedBox(height: spacing), // Espaçamento entre os widgets
            // Constrói o campo de entrada de texto para o e-mail
            buildTextField(
              labelText: 'E-mail',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
            ),
            SizedBox(height: spacing), // Espaçamento entre os widgets
            // Constrói o campo de entrada de texto para a mensagem
            buildTextField(
              labelText: 'Mensagem',
              controller: _mensagemController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: spacing), // Espaçamento entre os widgets
            // Botão de envio do formulário
            ElevatedButton(
              onPressed: () {
                _submitForm(
                  _nomeController.text,
                  _emailController.text,
                  _mensagemController.text,
                );
              },
              child: Text('Enviar'), // Texto do botão de envio
            ),
          ],
        ),
      ),
    );
  }

  // Método para enviar o formulário
  void _submitForm(String nome, String email, String mensagem) {
    print('Nome: $nome');
    print('E-mail: $email');
    print('Mensagem: $mensagem');
  }

  // Método para liberar os controladores quando a página for descartada
  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

  // Método para construir o campo de entrada de texto
  Widget buildTextField({
    required String labelText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required int? maxLines,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
