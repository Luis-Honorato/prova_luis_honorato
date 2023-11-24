import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:prova_luis_honorato/features/utils/generic_error_page.dart';
import 'package:prova_luis_honorato/features/utils/request_status.dart';
import 'package:prova_luis_honorato/features/weather/data/datasource/weather_data_source.dart';
import 'package:prova_luis_honorato/features/weather/data/repositoryes/weather_repository.dart';
import 'package:prova_luis_honorato/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:prova_luis_honorato/features/weather/presentation/widgets/city_weather_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(
      weatherRepository: WeatherRepository(
        WeatherDataSource(Client()),
      ),
    )..add(FetchCityWeather());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _weatherBloc,
      child: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: _weatherBloc,
        buildWhen: (previous, current) =>
            previous.cityWeatherStatus != current.cityWeatherStatus,
        builder: (context, state) {
          if (state.cityWeatherStatus == RequestStatus.failure) {
            return GenericErrorPage(
              onTap: () => _weatherBloc.add(FetchCityWeather()),
            );
          }

          if (state.cityWeatherStatus == RequestStatus.success) {
            return const CityWeatherWidget();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
