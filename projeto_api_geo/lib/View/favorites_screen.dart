import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/city_db_controller.dart';
import 'package:projeto_api_geo/Model/city_model.dart';
import 'details_weather_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late CityDbController _dbController;

  @override
  void initState() {
    super.initState();
    _dbController = CityDbController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),
      body: FutureBuilder<List<City>>(
        future: _dbController.listCities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final cities = snapshot.data as List<City>;
            if (cities.isEmpty) {
              return Center(child: Text("Sem Cidades Favoritas"));
            } else {
              return ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return ListTile(
                    title: Text(city.cityName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsWeatherScreen(city: city.cityName),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.favorite_border), // Ícone do coração vazio
                      onPressed: () {
                        _deleteCity(city.cityName);
                      },
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  Future<void> _deleteCity(String city) async {
    try {
      await _dbController.deleteCity(city);
      _refreshCityList();
    } catch (e) {
      print("Erro ao excluir cidade: $e");
    }
  }

  Future<void> _refreshCityList() async {
    setState(() {});
  }
}
