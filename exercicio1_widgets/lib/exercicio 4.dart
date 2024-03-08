import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController; // Controlador de abas

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Inicialização do controlador de abas
  }

  @override
  void dispose() {
    _tabController.dispose(); // Liberação de recursos quando o widget é descartado
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barra de Navegação Personalizada'), // Título da barra de navegação
        bottom: TabBar( // Abas na parte inferior da barra de navegação
          controller: _tabController, // Controlador de abas
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'), // Aba Home com ícone e texto
            Tab(icon: Icon(Icons.search), text: 'Search'), // Aba Search com ícone e texto
            Tab(icon: Icon(Icons.person), text: 'Profile'), // Aba Profile com ícone e texto
          ],
        ),
      ),
      body: TabBarView( // Exibição do conteúdo de cada aba
        controller: _tabController, // Controlador de abas
        children: [
          // Página 1
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0), // Adiciona um espaço no topo do Column
              child: Column( // Layout de coluna centralizado
                mainAxisAlignment: MainAxisAlignment.center, // Alinhamento vertical central
                children: [
                  Text(
                    'Esta é a página HOME, selecione outra aba para navegar entre outras páginas.',
                    textAlign: TextAlign.center, // Alinha o texto ao centro
                  ), // Texto para a Página 1
                  Image.network(
                    'https://blog.geekhunter.com.br/wp-content/uploads/2020/11/flutter.png',
                    width: 300,
                    height: 300,
                  ), //Largura e Altura da imagem), // 
                ],
              ),
            ),
          ),
          // Página 2
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0), // Adiciona um espaço no topo do Column
              child: Column( // Layout de coluna centralizado
                mainAxisAlignment: MainAxisAlignment.center, // Alinhamento vertical central
                children: [
                  Text(
                    'Esta é a página BUSCA, selecione outra aba para navegar entre outras páginas.',
                    textAlign: TextAlign.center, // Alinha o texto ao centro
                  ), // Texto para a Página 2
                  Image.network(
                    'data:image/png;base64,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',
                    width: 300,
                    height: 300,
                  ), // Imagem para a Página 2 (imagem de exemplo)
                ],
              ),
            ),
          ),
          // Página 3
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 02.0), // Adiciona um espaço no topo do Column
              child: Column( // Layout de coluna centralizado
                mainAxisAlignment: MainAxisAlignment.center, // Alinhamento vertical central
                children: [
                  Text(
                    'Esta é de PERFIL, selecione outra aba para navegar entre outras páginas.',
                    textAlign: TextAlign.center, // Alinha o texto ao centro
                  ), // Texto para a Página 3
                  Image.network(
                    'data:image/png;base64,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',
                    width: 200,
                    height: 200,
                  ), // Imagem para a Página 3 (imagem de exemplo)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
