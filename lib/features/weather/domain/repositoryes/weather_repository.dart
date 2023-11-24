import 'package:dartz/dartz.dart';
import 'package:prova_luis_honorato/features/utils/failures.dart';
import 'package:prova_luis_honorato/features/weather/domain/entities/city_wather.dart';

abstract class IWeatherRepository {
  Future<Either<Failure, CityWeather>> getCityWeather({
    required double latitude,
    required double longitude,
  });
}
