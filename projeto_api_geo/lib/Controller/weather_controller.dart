import 'package:projeto_api_geo/Model/weather_model.dart';
import 'package:projeto_api_geo/Service/weather_service_api.dart';

class WeatherController {
//atributos
  final WeatherService _service = WeatherService();
  final List<Weather> _weatherList = [];
//get
  List<Weather> get weatherList => _weatherList;

//métodos  -- através da cidade
  Future<void> getWeather(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      weatherList.add(weather);
    } catch (e) {
      print(e);
    }
  }

  //lon/lat
  Future<void> getWeatherByLonLat(double lat, double lon) async {
    try {
      Weather weather =
          Weather.fromJson(await _service.getWeatherByLocation(lat, lon));
      weatherList.add(weather);
    } catch (e) {
      print(e);
    }
  }

  void getWeatherbyLocation(double latitude, double longitude) {}
}
