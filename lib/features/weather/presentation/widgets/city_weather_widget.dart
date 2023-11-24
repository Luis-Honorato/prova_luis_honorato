import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova_luis_honorato/features/theme/theme_colors.dart';
import 'package:prova_luis_honorato/features/theme/theme_dimensions.dart';
import 'package:prova_luis_honorato/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:prova_luis_honorato/features/weather/presentation/widgets/change_city_dialog.dart';

class CityWeatherWidget extends StatefulWidget {
  const CityWeatherWidget({super.key});

  @override
  State<CityWeatherWidget> createState() => _CityWeatherWidgetState();
}

class _CityWeatherWidgetState extends State<CityWeatherWidget> {
  late final WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    weatherBloc = context.read<WeatherBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima'),
        actions: [
          IconButton(
            onPressed: () => _showChangeCityDialog(context),
            icon: const Icon(Icons.cloudy_snowing),
            color: ThemeColors.primary,
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: weatherBloc,
        builder: (context, state) {
          final city = state.cityWeather;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ThemeColors.primary),
                  color: ThemeColors.grayBlue,
                ),
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      child: Text(
                        city!.name,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          city.climate,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(width: ThemeDimensions.spacingSmall),
                        Text(
                          city.description,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: ThemeDimensions.spacingSmall),
                    Text(
                      '${city.temperature.toString()} C°',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showChangeCityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ChangeCityDialog(
        weatherBloc: weatherBloc,
      ),
    );
  }
}
