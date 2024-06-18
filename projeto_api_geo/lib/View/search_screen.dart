import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/city_db_controller.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';
import 'package:projeto_api_geo/Model/city_model.dart';
import 'details_weather_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  late CityDbController _dbController;

  @override
  void initState() {
    super.initState();
    _dbController = CityDbController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesquisa Por Cidade")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Insira a Cidade"),
                      controller: _cityController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Insira a Cidade";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _findCity(_cityController.text);
                        }
                      },
                      child: const Text("Search"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<City>>(
                future: _dbController.listCities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final cities = snapshot.data!;
                    if (cities.isEmpty) {
                      return const Center(child: Text("Sem Histórico"));
                    } else {
                      return ListView.builder(
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          final city = cities[index];
                          return ListTile(
                            title: Text(city.cityName),
                            onTap: () {
                              _findCity(city.cityName);
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _findCity(String city) async {
    if (await _controller.findCity(city)) {
      City cidade = City(cityName: city, favoriteCities: 0);
      _dbController.addCities(cidade);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Found City!"),
          duration: Duration(seconds: 1),
        ),
      );
      _refreshCityList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DetailsWeatherScreen(city: city),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cidade não encontrada!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
