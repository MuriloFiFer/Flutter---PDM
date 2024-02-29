import 'package:app_carros/CarrosModel.dart';

class ControllerCarros {
  List<Carro> _carros = [
    Carro("Sedan", 2022, "https://example.com/sedan.jpg"),
    Carro("Hatchback", 2021, "https://example.com/hatchback.jpg"),
  ];

  List<Carro> get listarCarros => _carros;

  void adicionarCarro(String modelo, int ano, String imagemUrl) {
    Carro novoCarro = Carro(modelo, ano, imagemUrl);
    _carros.add(novoCarro);
  }
}