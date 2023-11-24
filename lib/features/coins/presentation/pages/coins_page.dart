import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:prova_luis_honorato/features/coins/data/datasource/coins_data_source.dart';
import 'package:prova_luis_honorato/features/coins/data/repositoryes/coins_repository.dart';
import 'package:prova_luis_honorato/features/coins/domain/entities/coin.dart';
import 'package:prova_luis_honorato/features/coins/presentation/bloc/coins_bloc.dart';
import 'package:prova_luis_honorato/features/coins/presentation/widgets/coins_comparison.dart';
import 'package:prova_luis_honorato/features/utils/generic_error_page.dart';
import 'package:prova_luis_honorato/features/utils/request_status.dart';

class CoinsPage extends StatefulWidget {
  const CoinsPage({super.key});

  @override
  State<CoinsPage> createState() => _CoinsPageState();
}

class _CoinsPageState extends State<CoinsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final CoinsBloc coinsBloc;

  @override
  void initState() {
    super.initState();
    coinsBloc = CoinsBloc(
      coinsRepository: CoinsRepository(
        CoinsDataSource(
          client: Client(),
        ),
      ),
    )..add(FetchCoinsValue(
        coinsToCompare: CoinsEnum.values.map((coin) {
          return coin.acronym;
        }).toList(),
      ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<CoinsBloc>.value(
      value: coinsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Moedas'),
        ),
        body: BlocBuilder<CoinsBloc, CoinsState>(
          bloc: coinsBloc,
          buildWhen: (previous, current) =>
              previous.getCoinsValueStatus != current.getCoinsValueStatus,
          builder: (context, state) {
            if (state.getCoinsValueStatus == RequestStatus.failure) {
              return const GenericErrorPage();
            }

            if (state.getCoinsValueStatus == RequestStatus.success) {
              return const CoinsComparison();
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
