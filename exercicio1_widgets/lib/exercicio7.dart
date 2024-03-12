import 'package:flutter/material.dart';

void main() {
  runApp(ContactForm());
}

class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio7',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactFormPage(),
    );
  }
}

class ContactFormPage extends StatefulWidget {
  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mensagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double spacing = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Contato com menu lateral Drawler'),
        // Botão para abrir o Drawer
        actions: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      // Configuração do Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Cabeçalho do Drawer
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 110, 177, 231),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Opções do Drawer
            ListTile(
              title: Text('Opção 1'),
              onTap: () {
                // Implementação da ação da opção 1
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Implementação da ação da opção 2
              },
            ),
             ListTile(
              title: Text('Opção 3'),
              onTap: () {
                // Implementação da ação da opção 2
              },
            ),
             ListTile(
              title: Text('Opção 4'),
              onTap: () {
                // Implementação da ação da opção 2
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildTextField(
              labelText: 'Nome',
              controller: _nomeController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            SizedBox(height: spacing),
            buildTextField(
              labelText: 'E-mail',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
            ),
            SizedBox(height: spacing),
            buildTextField(
              labelText: 'Mensagem',
              controller: _mensagemController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: spacing),
            ElevatedButton(
              onPressed: () {
                _submitForm(
                  _nomeController.text,
                  _emailController.text,
                  _mensagemController.text,
                );
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm(String nome, String email, String mensagem) {
    print('Nome: $nome');
    print('E-mail: $email');
    print('Mensagem: $mensagem');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

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
