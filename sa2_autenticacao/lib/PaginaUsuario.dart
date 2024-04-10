import 'package:flutter/material.dart';

class PaginaUsuario extends StatefulWidget {
  const PaginaUsuario({Key? key}) : super(key: key);

  @override
  State<PaginaUsuario> createState() => _PaginaUsuarioState();
}

class _PaginaUsuarioState extends State<PaginaUsuario> {
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Área do Usuário'),
        actions: [
          IconButton(
            icon: Icon(_darkModeEnabled ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _darkModeEnabled = !_darkModeEnabled;
                _toggleDarkMode(_darkModeEnabled);
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Bem-vindo à Área do Usuário!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _toggleDarkMode(bool darkModeEnabled) {
    if (darkModeEnabled) {
      // Habilitar Dark Mode
      // Definir esquema de cores para o tema escuro
      // Exemplo:
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      //   statusBarColor: Colors.black,
      //   statusBarIconBrightness: Brightness.light,
      //   systemNavigationBarColor: Colors.black,
      //   systemNavigationBarIconBrightness: Brightness.light,
      // ));
      // MaterialApp(
      //   theme: ThemeData.dark(),
      // );
    } else {
      // Desabilitar Dark Mode
      // Definir esquema de cores para o tema claro
      // Exemplo:
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      //   statusBarColor: Colors.white,
      //   statusBarIconBrightness: Brightness.dark,
      //   systemNavigationBarColor: Colors.white,
      //   systemNavigationBarIconBrightness: Brightness.dark,
      // ));
      // MaterialApp(
      //   theme: ThemeData.light(),
      // );
    }
  }
}
