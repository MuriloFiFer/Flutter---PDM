class City {
  //atributos
  final String cityName;
  late final int favoriteCities;
  //cosntrutor
  City({required this.cityName, required this.favoriteCities});
  //metodos


  //toMap  (do objeto para o banco)
  Map<String,dynamic> toMap() {
    return {
    'cityname': cityName,
    'favoritecities': favoriteCities};
  }

  //fromMap  (do banco para objeto)
  factory City.fromMap(Map<String,dynamic> map ) {
    return City(
      cityName: map['cityname'],
      favoriteCities:map['favoritecities'],
    );
  }
}