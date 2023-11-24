import 'package:equatable/equatable.dart';

enum CityesEnum {
  sp('São Paulo', -23.5489, -46.6388),
  rj('Rio de Janeiro', -22.9035, -43.2096),
  bsb('Brasilia', -15.7801, -47.9292),
  am('Manaus', -3.10719, -60.0261),
  pvh('Porto Velho', -8.76183, -63.902),
  fortal('Fortaleza', -3.71839, -38.5434);

  final String name;
  final double latitude;
  final double longitude;

  const CityesEnum(
    this.name,
    this.latitude,
    this.longitude,
  );
}

class CityWeather extends Equatable {
  final int id;
  final String name;
  final String climate;
  final String description;
  final double temperature;

  const CityWeather({
    required this.id,
    required this.name,
    required this.climate,
    required this.description,
    required this.temperature,
  });

  @override
  List<Object?> get props => [
        id,
        climate,
        description,
        temperature,
      ];
}
