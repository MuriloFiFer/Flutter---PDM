

import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super key});
  
  @overwidget
  State<HomeScreen> createState() => _HomeScreenState();  
}

class _HomeScreenState extends State<WeatherScreen> {
  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Previsão do tempo'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon: Icon.search),
            onPressed: ({}),
        ]
        ),
        body: Padding(
          padding: EdgeInset.all(12),
          child:Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: (){}),
                    child: Text("Presquisar")),
                  ElevatedButton(
                    onPressed: (){}),
                    child: Text("Favoritos"))
                ] 
            ],
        
        ),
      );
    }
  }
}