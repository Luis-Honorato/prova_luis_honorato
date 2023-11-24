import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova_luis_honorato/features/weather/domain/entities/city_wather.dart';
import 'package:prova_luis_honorato/features/weather/presentation/bloc/weather_bloc.dart';

class ChangeCityDialog extends StatefulWidget {
  final WeatherBloc weatherBloc;
  const ChangeCityDialog({
    super.key,
    required this.weatherBloc,
  });

  @override
  State<ChangeCityDialog> createState() => _ChangeCityDialogState();
}

class _ChangeCityDialogState extends State<ChangeCityDialog> {
  late final TextEditingController cityesController;

  @override
  void initState() {
    super.initState();
    cityesController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: widget.weatherBloc,
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Escolha a cidade desejada'),
          content: DropdownMenu<CityesEnum>(
            initialSelection: state.selectedCity,
            requestFocusOnTap: false,
            enableSearch: false,
            label: const Text('Cidade'),
            controller: cityesController,
            dropdownMenuEntries: [
              for (CityesEnum city in CityesEnum.values)
                DropdownMenuEntry<CityesEnum>(
                  value: city,
                  label: city.name,
                )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            OutlinedButton(
              onPressed: () {
                final selectedCity = CityesEnum.values.firstWhere(
                    (element) => element.name == cityesController.text);
                widget.weatherBloc.add(SetSelectedCity(selectedCity));
                widget.weatherBloc.add(FetchCityWeather());
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
