import 'package:flutter/material.dart'; // Importa o pacote Flutter para construção de UIs
import 'package:sa3_persistencia/ViewLogin.dart'; // Importa a tela de login do projeto

void main() {
  runApp(MyApp()); // Inicia a execução do aplicativo
}

class MyApp extends StatelessWidget { // Define a classe MyApp que estende StatelessWidget
  const MyApp({super.key}); // Construtor da classe

  @override
  Widget build(BuildContext context) { // Método para construir a UI do aplicativo
    return MaterialApp( // Retorna um MaterialApp, que configura o aplicativo seguindo o Material Design
      title: "SA3-Persistencia", // Define o título do aplicativo
      debugShowCheckedModeBanner: false, // Remove a faixa de depuração em modo de desenvolvimento
      home: LoginScreen() // Define a tela inicial como LoginScreen
    );
  }
}
