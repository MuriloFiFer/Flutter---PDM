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
      body: FutureBuilder(
        future: _dbController.listCities(),
        builder: (context, AsyncSnapshot<List<City>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final cities = snapshot.data!;
            if (cities.isEmpty) {
              return const Center(child: Text("Sem cidades favoritas"));
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
                      icon: Icon(Icons.delete),
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
    await _dbController.deleteCity(city);
    setState(() {});
  }
}
