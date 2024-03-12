import 'package:flutter/material.dart';

void main() {
  runApp(ProductCatalog());
}

class ProductCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductCatalogPage(),
    );
  }
}

class ProductCatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nosso catálogo digital'),
      ),
      body: ListView(
        children: [
          ProductCard(
            imageUrl: 'https://madeinbrazil.fbitsstatic.net/img/p/violao-yamaha-eletroacustico-aco-transacoustic-fsc-ta-com-reverb-e-chorus-brown-sunburst-129103/318332-1.jpg?w=270&h=270&v=202402151243&qs=ignore',
            title: 'Violão Yamaha Eletroacústico',
            description: 'Violão Yamaha FSC-TA TransAcoustic: Reverb, Chorus, Acesso Fácil, Sem Amplificador.',
          ),
          ProductCard(
            imageUrl: 'https://madeinbrazil.fbitsstatic.net/img/p/guitarra-evh-wolfgang-standard-preto-brilhante-129962/343030-1.jpg?w=800&h=800&v=no-change&qs=ignore',
            title: 'Guitarra EVH Wolfgang Standard - Preto Brilhante',
            description: 'Guitarra Wolfgang WG Standard: Conforto, Velocidade, Sustentação, Precisão, Estabilidade.',
          ),
          ProductCard(
            imageUrl: 'https://madeinbrazil.fbitsstatic.net/img/p/banjo-country-fender-4-cordas-pb-180e-paramount-natural-129951/343019-1.jpg?w=270&h=270&v=no-change&qs=ignore',
            title: 'Banjo Country Fender 4 Cordas PB-180E Paramount - Natural',
            description: 'Banjo Fender Paramount PB-180E: Tradição, Modernidade, Versatilidade, Conforto.',
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adiciona sombra ao card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Borda arredondada
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Espaçamento entre os cards
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)), // Borda arredondada apenas na parte superior da imagem
            child: Image.network(
              imageUrl,
              height: 100, // Ajusta a altura da imagem
              width: 200,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16), // Espaçamento interno entre a imagem e o texto
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Tamanho de fonte aumentado
                    fontFamily: 'Roboto', // Utiliza uma fonte diferente
                  ),
                ),
                SizedBox(height: 8), // Espaçamento entre o título e a descrição
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14, // Tamanho de fonte aumentado
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
