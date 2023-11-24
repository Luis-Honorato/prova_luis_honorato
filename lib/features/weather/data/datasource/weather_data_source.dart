import 'package:http/http.dart';
import 'package:prova_luis_honorato/api/weather_apy_key.dart';

class WeatherDataSource {
  final Client client;

  WeatherDataSource(this.client);

  Future<Response> getCityWeather({
    required double latitude,
    required double longitude,
  }) async {
    final response = await client.get(
      Uri.parse(
          '$weatherApiKey/weather?lat=$latitude&lon=$longitude&appid=$weatherAuthToken'),
    );

    return response;
  }
}
