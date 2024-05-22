import 'package:flutter/material.dart';
import 'package:projeto_api_geo/View/details_weather_screen.dart';
import 'package:projeto_api_geo/View/search_screen.dart';
import 'View/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Projeto API GEO",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
//route
      routes: {
        '/search': (context) => const SearchScreen(),
        '/details': (context) => const DetailsWeatherScreen()
      },
    );
  }
}
