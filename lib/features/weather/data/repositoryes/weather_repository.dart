import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:prova_luis_honorato/features/utils/failures.dart';
import 'package:prova_luis_honorato/features/weather/data/adapters/city_weather_adapter.dart';
import 'package:prova_luis_honorato/features/weather/data/datasource/weather_data_source.dart';
import 'package:prova_luis_honorato/features/weather/domain/entities/city_wather.dart';
import 'package:prova_luis_honorato/features/weather/domain/repositoryes/weather_repository.dart';

class WeatherRepository implements IWeatherRepository {
  final WeatherDataSource dataSource;

  WeatherRepository(this.dataSource);
  @override
  Future<Either<Failure, CityWeather>> getCityWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dataSource.getCityWeather(
        latitude: latitude,
        longitude: longitude,
      );

      final body = jsonDecode(response.body);

      final cityWeather = CityWeatherAdapter.fromJson(body);

      return Right(cityWeather);
    } catch (e) {
      return const Left(ServerFailure(''));
    }
  }
}
