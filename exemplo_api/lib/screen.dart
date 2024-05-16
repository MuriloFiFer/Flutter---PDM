
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService(
    apiKey:
        '681126f28e7d6fa3a7cfe0da0671e599', // Chave de API para acesso à API de previsão do tempo.
    baseUrl:
        'https://api.openweathermap.org/data/2.5', // URL base da API de previsão do tempo.
  );

  late Map<String, dynamic> _weatherData;
  TextEditingController _cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _weatherData = new Map<String, dynamic>();
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      final weatherData = await _weatherService.getWheather(city);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchWeatherLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final weatherData = await _weatherService.getWeatherByLocation(
          position.latitude, position.longitude);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exemplo Weather-API")),
      body: Padding(
          padding: EdgeInsets.all(12),
          child: FutureBuilder(
              future: _fetchWeatherLocation(),
              builder: (context, snapshot) {
                if (_weatherData.isEmpty) {
                  return Center(child:CircularProgressIndicator());
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cidade: ${_weatherData['name']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Temperatura: ${(_weatherData['main']['temp'] - 273.15).toStringAsFixed(2)} °C',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Descrição: ${_weatherData['weather'][0]['description']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }
              })),
    );
  }
}