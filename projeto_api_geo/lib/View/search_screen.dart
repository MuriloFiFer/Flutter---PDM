import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Controller/weather_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cidadeController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisa Por Cidade")
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child:Form(
            key:_formKey,
            child: Column(
              children:[
                TextFormField(
                  decoration: const InputDecoration(labelText: "Insira a Cidade"),
                  controller: _cidadeController,
                  validator: (value) {
                  if(value!.trim().isEmpty){ 
                    return  "Insira a Cidade";
                  }
                  return null;
                  },
                )
              ]
            ))
        ),),
    );
  }
}