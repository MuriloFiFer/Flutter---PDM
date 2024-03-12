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
  // Controllers para os campos de texto
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
        title: Text('Formulário de Contato com uso de Media Query'),
        // Adiciona um ícone para abrir o Drawer
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Abre o Drawer ao pressionar o ícone do menu
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      // Adiciona um Drawer ao Scaffold
      drawer: Drawer(
        // Define o conteúdo do Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Cabeçalho do Drawer
            Container(
              color: const Color.fromARGB(255, 115, 173, 220),
              height: 100, // Altura do cabeçalho do Drawer
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            // Opções do Drawer
            ListTile(
              title: Text('Opção 1'),
              onTap: () {
                // Implemente a ação desejada ao selecionar a opção 1
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Implemente a ação desejada ao selecionar a opção 2
              },
            ),
            ListTile(
              title: Text('Opção 3'),
              onTap: () {
                // Implemente a ação desejada ao selecionar a opção 3
              },
            ),
            ListTile(
              title: Text('Opção 4'),
              onTap: () {
                // Implemente a ação desejada ao selecionar a opção 4
              },
            ),
            ListTile(
              title: Text('Opção 5'),
              onTap: () {
                // Implemente a ação desejada ao selecionar a opção 5
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
            // Campo de texto para o nome
            buildTextField(
              labelText: 'Nome',
              controller: _nomeController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            SizedBox(height: spacing),
            // Campo de texto para o e-mail
            buildTextField(
              labelText: 'E-mail',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
            ),
            SizedBox(height: spacing),
            // Campo de texto para a mensagem
            buildTextField(
              labelText: 'Mensagem',
              controller: _mensagemController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: spacing),
            // Botão de envio do formulário
            ElevatedButton(
              onPressed: () {
                // Ao pressionar o botão, envia o formulário
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

  // Função para envio do formulário
  void _submitForm(String nome, String email, String mensagem) {
    // Imprime os dados do formulário
    print('Nome: $nome');
    print('E-mail: $email');
    print('Mensagem: $mensagem');
  }

  @override
  void dispose() {
    // Limpa os controllers ao descartar a página
    _nomeController.dispose();
    _emailController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

  // Função para construir um campo de texto personalizado
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
