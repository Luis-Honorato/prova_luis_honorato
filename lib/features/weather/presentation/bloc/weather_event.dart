part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class SetSelectedCity extends WeatherEvent {
  final CityesEnum selectedCity;

  const SetSelectedCity(this.selectedCity);
}

class FetchCityWeather extends WeatherEvent {}
