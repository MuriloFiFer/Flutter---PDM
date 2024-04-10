import 'package:flutter/material.dart';
import 'package:sa2_autenticacao/login_view.dart'; // Importe a tela de login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA2",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      // Definindo a tela de login como a tela inicial
      home: LoginView(),
    );
  }
}
