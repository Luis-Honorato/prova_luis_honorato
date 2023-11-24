part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final RequestStatus cityWeatherStatus;
  final CityesEnum selectedCity;
  final CityWeather? cityWeather;

  const WeatherState({
    this.cityWeatherStatus = RequestStatus.initial,
    this.selectedCity = CityesEnum.pvh,
    this.cityWeather,
  });

  WeatherState copyWith({
    RequestStatus? cityWeatherStatus,
    CityesEnum? selectedCity,
    CityWeather? cityWeather,
  }) {
    return WeatherState(
      cityWeatherStatus: cityWeatherStatus ?? this.cityWeatherStatus,
      selectedCity: selectedCity ?? this.selectedCity,
      cityWeather: cityWeather ?? this.cityWeather,
    );
  }

  @override
  List<Object?> get props => [
        cityWeatherStatus,
        selectedCity,
        cityWeather,
      ];
}
