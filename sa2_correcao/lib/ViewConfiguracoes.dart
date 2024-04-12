import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  //atributo
  final String email;

  ConfiguracoesPage({required this.email});

  @override
  _ConfiguracoesPageState createState() =>
      _ConfiguracoesPageState(email: email);
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  //Atributos
  late SharedPreferences _prefs;
  bool _darkMode = false;
  final String email;

  _ConfiguracoesPageState({required this.email})

  //Métodos
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = _prefs.getBool('${email}darkMode') ?? false;
    });
  }

  Future<void> _mudarDarkMode() async {
    setState(() {
      _darkMode = !_darkMode;
    });
    await _prefs.setBool('${email}darkMode', _darkMode);
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
          title: Text('Teste de Armazenamento Interno'),
        ),
        body: Center(
          child: Column(
            children: [
              Switch(
                value: _darkMode,
                onChanged: (value) {
                  _mudarDarkMode();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
