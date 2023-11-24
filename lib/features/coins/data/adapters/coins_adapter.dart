import 'package:prova_luis_honorato/features/coins/domain/entities/coin.dart';

class CoinsAdapter {
  const CoinsAdapter._();

  static List<Coin> fromJson(Map<String, dynamic> json) {
    final coinsList = <Coin>[];
    for (Map<String, dynamic> coin in json.values) {
      final Coin addedCoind = Coin(
        name: coin['name'],
        code: coin['code'],
        value: double.parse(coin['high']),
      );

      coinsList.add(addedCoind);
    }
    return coinsList;
  }
}
