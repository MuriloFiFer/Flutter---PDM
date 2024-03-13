import 'package:flutter/material.dart';

void main() {
  runApp(TabBarApp());
}

// Classe principal da aplicação
class TabBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 9', // Título da aplicação
      theme: ThemeData(
        primarySwatch: Colors.blue, // Cor principal da aplicação
      ),
      home: TabBarPage(), // Define a página inicial como a página com a TabBar
    );
  }
}

// Página com a TabBar e as abas
class TabBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Define o número de abas
      child: Scaffold(
        appBar: AppBar(
          title: Text('Layout com Abas (TabBar)'), // Título da barra superior
          bottom: TabBar( // TabBar na parte inferior da barra superior
            tabs: [
              Tab(text: 'Home'), // Aba "Home"
              Tab(text: 'Negócios'), // Aba "Negócios"
              Tab(text: 'Educação'), // Aba "Educação"
            ],
          ),
        ),
        body: TabBarView( // Conteúdo associado a cada aba
          children: [
            TabContent(text: 'Bem-vindo à página inicial, onde você pode encontrar informações sobre os recursos mais recentes e atualizações do nosso aplicativo.'), // Conteúdo da aba "Home"
            TabContent(text: 'Explore as oportunidades de negócios disponíveis em nossa plataforma. Descubra como você pode se tornar um parceiro ou anunciante e alcance um público mais amplo.'), // Conteúdo da aba "Negócios"
            TabContent(text: 'Descubra recursos educacionais e ferramentas úteis para ajudá-lo a aprender e crescer. Desde tutoriais passo a passo até dicas de estudo, você encontrará tudo aqui para aprimorar seus conhecimentos.'), // Conteúdo da aba "Educação"
          ],
        ),
      ),
    );
  }
}

// Widget para o conteúdo de cada aba
class TabContent extends StatelessWidget {
  final String text; // Texto da aba

  const TabContent({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0), // Preenchimento interno
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue), // Borda azul
          borderRadius: BorderRadius.circular(100.0), // Borda circular
        ),
        child: Text(
          text, // Texto da aba
          textAlign: TextAlign.center, // Alinhamento centralizado
        ),
      ),
    );
  }
}
