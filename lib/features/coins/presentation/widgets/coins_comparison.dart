import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prova_luis_honorato/features/coins/domain/entities/coin.dart';
import 'package:prova_luis_honorato/features/coins/presentation/bloc/coins_bloc.dart';
import 'package:prova_luis_honorato/features/coins/presentation/widgets/coin_card.dart';
import 'package:prova_luis_honorato/features/theme/theme_dimensions.dart';

class CoinsComparison extends StatefulWidget {
  const CoinsComparison({super.key});

  @override
  State<CoinsComparison> createState() => _CoinsComparisonState();
}

class _CoinsComparisonState extends State<CoinsComparison> {
  late final CoinsBloc _coinsBloc;
  @override
  void initState() {
    super.initState();
    _coinsBloc = context.read<CoinsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<CoinsBloc, CoinsState>(
        bloc: _coinsBloc,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: ThemeDimensions.spacingVeryHuge),
              const Text(
                'Lucas, só tem essas 4 moedas porque a API que eu peguei é UMA MERDA, pfv lê o comentário aqui',
                textAlign: TextAlign.center,
              ),

              /// A API só oferece comparação boa pra real, dolar e euro, sério fiquei um tempão pra descobrir isso.
              /// o link da API tá aqui: https://docs.awesomeapi.com.br/api-de-moedas
              /// o link das moeadas que estão disponíveis pra conversão tão aq: https://economia.awesomeapi.com.br/xml/available
              /// pfv n me desconta ponto por causa disso
              const SizedBox(height: ThemeDimensions.spacingHuge),

              DropdownMenu<CoinsEnum>(
                initialSelection: state.basedCoin,
                requestFocusOnTap: false,
                enableSearch: false,
                label: const Text('Moeda'),
                onSelected: (coin) {
                  _coinsBloc.add(SetBasedCoinEvent(coin!));
                  _coinsBloc.add(
                    FetchCoinsValue(

                        /// I had the decision to keep the coins sended dynamic for a
                        /// possible new feature added that makes possible choose
                        /// the compared coins

                        coinsToCompare: CoinsEnum.values
                            .map((coin) => coin.acronym)
                            .toList()),
                  );
                },
                dropdownMenuEntries: [
                  for (CoinsEnum coin in CoinsEnum.values)
                    DropdownMenuEntry<CoinsEnum>(
                      value: coin,
                      label: coin.name,
                      trailingIcon: Text(coin.acronym),
                    )
                ],
              ),
              const SizedBox(height: ThemeDimensions.spacingLarge),
              Expanded(
                child: ListView.builder(
                  itemCount: state.comparedCoins.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CoinCard(
                      coin: state.comparedCoins[index],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
