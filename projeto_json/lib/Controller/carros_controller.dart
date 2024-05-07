import 'dart:convert';
import 'dart:io';

import '../Model/carros_model.dart';

class CarrosController {
  List<Carro> _carroList = [];
  
  List<Carro> get carroList {
    return _carroList;
  }
  
  void addCarro(Carro carro) {
    _carroList.add(carro);
  }

  //Salva para o Json
    Future<void> saveCarrosToFile() async {
    final file = File('carros.json');
    final jsonList = _carroList.map((carro) => carro.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }
  
    
  //Buscar do Json
  Future<void> loadCarrosFromFile() async {
    try {
      final file = File('carros.json');
      final jsonList = jsonDecode(await file.readAsString());
      _carroList = jsonList.map<Carro>((json) => Carro.fromJson(json)).toList();
    } catch (e) {
      _carroList = [];
    }
  }

 
  
  
}
