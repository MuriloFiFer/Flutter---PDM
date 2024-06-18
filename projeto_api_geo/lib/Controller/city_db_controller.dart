import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

class CityDbController {
  // Atributos
  List<City> _cities = [];
  CityDataBaseService _dbService = CityDataBaseService();

  // Métodos

  // Retorna a lista de cidades
  List<City> cities() => _cities;

  // Lista todas as cidades do banco de dados
  Future<List<City>> listCities() async {
    List<Map<String, dynamic>> maps = await _dbService.getAllCities();
    _cities = maps.map<City>((e) => City.fromMap(e)).toList();
    return _cities;
  }

  // Adiciona uma nova cidade ao banco de dados
  Future<void> addCities(City city) async {
    _dbService.insertCity(city);   
  }

  // Deleta uma cidade do banco de dados
  Future<void> deleteCity(String city) async {
    await _dbService.deleteCity(city);
  }
}
