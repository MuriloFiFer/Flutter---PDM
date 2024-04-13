import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Tela de configurações
class ConfiguracoesPage extends StatefulWidget {
  final String email; // Email do usuário

  ConfiguracoesPage({required this.email}); // Construtor

  @override
  _ConfiguracoesPageState createState() =>
      _ConfiguracoesPageState(email: email); // Estado da tela de configurações
}

// Estado da tela de configurações
class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences _prefs; // Instância de SharedPreferences para armazenar preferências
  bool _darkMode = false; // Estado do modo escuro
  final String email; // Email do usuário
  String _idioma = 'pt-br'; // Idioma selecionado

  _ConfiguracoesPageState({required this.email}); // Construtor

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Carrega as preferências do usuário ao inicializar a tela
  }

  // Carrega as preferências do usuário
  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = _prefs.getBool('${email}darkMode') ?? false; // Obtém o estado do modo escuro
      _idioma = _prefs.getString('${email}SelIdioma') ?? 'pt-br'; // Obtém o idioma selecionado
    });
  }

  // Alterna o estado do modo escuro e salva a preferência
  Future<void> _mudarDarkMode() async {
    setState(() {
      _darkMode = !_darkMode;
    });
    await _prefs.setBool('${email}darkMode', _darkMode);
  }

  // Muda o idioma selecionado e salva a preferência
  Future<void> _mudarIdoma() async {
    setState(() {
      // API de mudança de idioma
    });
    await _prefs.setString('${email}SelIdioma', _idioma);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode
          ? ThemeData.dark()
          : ThemeData.light(), // Define o tema com base no modo escuro
      duration: Duration(milliseconds: 500), // Define a duração da transição
      child: Scaffold(
        appBar: AppBar(
          title: Text('Teste de Armazenamento Interno'), // Título da tela
        ),
        body: Center(
          child: Column(
            children: [
              Text("Selecione o Modo Escuro"), // Texto para selecionar o modo escuro
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  _mudarDarkMode(); // Alterna o modo escuro
                },
              ),
              Text("Selecione o Idioma"), // Texto para selecionar o idioma
              DropdownButton<String>(
                value: _idioma,
                onChanged: (value) {
                  _mudarIdoma(); // Muda o idioma selecionado
                },
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'pt-br',
                    child: Text('Português (Brasil)'), // Opção para o idioma Português (Brasil)
                  ),
                  DropdownMenuItem(
                    value: 'en-us',
                    child: Text('Inglês (EUA)'), // Opção para o idioma Inglês (EUA)
                  ),
                  DropdownMenuItem(
                    value: 'es-ar',
                    child: Text('Espanhol (Argentina)'), // Opção para o idioma Espanhol (Argentina)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
