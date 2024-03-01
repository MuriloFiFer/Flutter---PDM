import 'package:app_carros/CarrosModel.dart';

class ControllerCarros {
  List<Carro> _carros = [
    Carro("Fiat Uno", 1992, "img/uno.jpg"),
    Carro("WV Gol", 1996, "img/gol.jpg"),
  ];

  List<Carro> get listarCarros => _carros;

  void adicionarCarro(String modelo, int ano, String imagemUrl) {
    Carro novoCarro = Carro(modelo, ano, imagemUrl);
    _carros.add(novoCarro);
  }
}