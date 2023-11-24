import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:prova_luis_honorato/features/utils/request_status.dart';
import 'package:prova_luis_honorato/features/weather/data/repositoryes/weather_repository.dart';
import 'package:prova_luis_honorato/features/weather/domain/entities/city_wather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({
    required this.weatherRepository,
  }) : super(const WeatherState()) {
    on<SetSelectedCity>((event, emit) {
      emit(state.copyWith(
        selectedCity: event.selectedCity,
      ));
    });

    on<FetchCityWeather>((event, emit) async {
      emit(state.copyWith(
        cityWeatherStatus: RequestStatus.loading,
      ));

      final result = await weatherRepository.getCityWeather(
        latitude: state.selectedCity.latitude,
        longitude: state.selectedCity.longitude,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            cityWeatherStatus: RequestStatus.failure,
          ));
          debugPrint('Failure to loading city weather');
        },
        (cityWeather) {
          emit(state.copyWith(
            cityWeatherStatus: RequestStatus.success,
            cityWeather: cityWeather,
          ));
          debugPrint('City Weather succesfully loaded');
        },
      );
    });
  }
}
