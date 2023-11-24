import 'package:prova_luis_honorato/features/weather/domain/entities/city_wather.dart';

class CityWeatherAdapter {
  const CityWeatherAdapter._();

  static CityWeather fromJson(Map<dynamic, dynamic> json) {
    return CityWeather(
      id: json['id'],
      name: json['name'],
      climate: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temperature: _convertKelvinToCelcius(json['main']['temp']),
    );
  }

  static double _convertKelvinToCelcius(double kelvin) {
    return double.parse((kelvin - 273.15).toStringAsFixed(2));
  }
}
