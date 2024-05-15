import 'package:flutter/material.dart';
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

  // void dispose() {
  //   super.dispose();
  // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exemplo Weather-API")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: "Digite a Cidade"),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Insira a Cidade";
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _fetchWeatherData(_cityController.text);
                    }
                  },
                  child: const Text("Buscar"),
                ),
                SizedBox(height: 20),
                _weatherData.isEmpty
                    ? const Text('')
                    : Column(
                        children: [
                          Text(
                            'Cidade: ${_weatherData['name']}',
                          ),
                          Text(
                            'Temperatura: ${(_weatherData['main']['temp'] - 273.15).toStringAsFixed(2)} °C',
                          ),
                          Text(
                            'Descriçâo: ${_weatherData['weather'][0]['description']}',
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}