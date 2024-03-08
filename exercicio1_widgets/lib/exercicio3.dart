import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Classe para representar um item na lista
class Item {
  final String title; // Título do item
  final String subtitle; // Subtítulo do item
  final IconData icon; // Ícone do item

  // Construtor da classe
  Item({required this.title, required this.subtitle, required this.icon});
}

class MyApp extends StatelessWidget {
  // Lista de itens
  final List<Item> items = [
    Item(
      title: 'Bola',
      subtitle: 'Bola de Futebol Americano',
      icon: Icons.sports_football,
    ),
    Item(
      title: 'Tênis de Corrida',
      subtitle: 'Tênis ultraleve com amortecimento avançado',
      icon: Icons.directions_run,
    ),
    Item(
      title: 'Bolsa de Couro',
      subtitle: 'Bolsa feminina em couro legítimo',
      icon: Icons.shopping_bag,
    ),
    Item(
      title: 'Smartphone Premium',
      subtitle: 'Smartphone de última geração com câmera de 108MP',
      icon: Icons.smartphone,
    ),
    Item(
      title: 'Relógio Esportivo',
      subtitle: 'Relógio resistente à água com GPS integrado',
      icon: Icons.watch,
    ),
    Item(
      title: 'Fone de Ouvido Bluetooth',
      subtitle: 'Fone de ouvido sem fio com cancelamento de ruído',
      icon: Icons.headset,
    ),
    Item(
      title: 'Livro de Romance',
      subtitle: 'Best-seller internacional com história envolvente',
      icon: Icons.book,
    ),
    Item(
      title: 'Câmera Fotográfica',
      subtitle: 'Câmera DSLR com lente intercambiável',
      icon: Icons.camera,
    ),
    Item(
      title: 'Mochila de Viagem',
      subtitle: 'Mochila ergonômica com capacidade de 30 litros',
      icon: Icons.backpack,
    ),
    Item(
      title: 'Kit de Maquiagem',
      subtitle: 'Kit profissional com variedade de cores',
      icon: Icons.face,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio 3',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Itens'),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500), // Definindo a largura máxima
            child: ListView.builder(
              itemCount: items.length, // Número total de itens na lista
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 113, 170, 216),
                      child: Icon(items[index].icon, color: Colors.white), // Ícone do item
                    ),
                    title: Text(items[index].title), // Título do item
                    subtitle: Text(items[index].subtitle), // Subtítulo do item
                    trailing: Icon(Icons.arrow_forward), // Ícone de seta à direita
                    onTap: () {
                      // Ação ao pressionar o item (opcional)
                      print('Item $index pressionado.');
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
