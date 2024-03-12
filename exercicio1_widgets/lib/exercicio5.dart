import 'package:flutter/material.dart';

void main() {
  runApp(ContactForm());
}

class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio5', // Título da aplicação
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactFormPage(), // Define a página inicial como ContactFormPage
    );
  }
}

class ContactFormPage extends StatefulWidget {
  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mensagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Contato'), // Título da barra superior
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nomeController, // Controlador para o campo "Nome"
              decoration: InputDecoration(
                labelText: 'Nome', // Rótulo do campo
              ),
            ),
            SizedBox(height: 16.0), // Espaçamento entre os campos
            TextField(
              controller: _emailController, // Controlador para o campo "E-mail"
              keyboardType: TextInputType.emailAddress, // Tipo de teclado para e-mail
              decoration: InputDecoration(
                labelText: 'E-mail', // Rótulo do campo
              ),
            ),
            SizedBox(height: 16.0), // Espaçamento entre os campos
            TextField(
              controller: _mensagemController, // Controlador para o campo "Mensagem"
              maxLines: 5, // Número máximo de linhas
              decoration: InputDecoration(
                labelText: 'Mensagem', // Rótulo do campo
              ),
            ),
            SizedBox(height: 16.0), // Espaçamento entre os campos
            ElevatedButton(
              onPressed: () {
                _submitForm(
                  _nomeController.text, // Obtém o texto do campo "Nome"
                  _emailController.text, // Obtém o texto do campo "E-mail"
                  _mensagemController.text, // Obtém o texto do campo "Mensagem"
                );
              },
              child: Text('Enviar'), // Texto do botão
            ),
          ],
        ),
      ),
    );
  }

  // Função para lidar com o envio do formulário
  void _submitForm(String nome, String email, String mensagem) {
    // Imprime os valores dos campos no console
    print('Nome: $nome');
    print('E-mail: $email');
    print('Mensagem: $mensagem');
  }

  @override
  void dispose() {
    // Descarta os controladores quando a página é descartada
    _nomeController.dispose();
    _emailController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }
}
