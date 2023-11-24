import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:prova_luis_honorato/features/coins/data/adapters/coins_adapter.dart';
import 'package:prova_luis_honorato/features/coins/data/datasource/coins_data_source.dart';
import 'package:prova_luis_honorato/features/coins/domain/entities/coin.dart';
import 'package:prova_luis_honorato/features/coins/domain/repository/coins_repository.dart';
import 'package:prova_luis_honorato/features/utils/failures.dart';

class CoinsRepository implements ICoinsRepository {
  final CoinsDataSource dataSource;

  const CoinsRepository(this.dataSource);

  @override
  Future<Either<Failure, List<Coin>>> getCoinsValue({
    required String basedCoin,
    required List<String> coinsToCompare,
  }) async {
    try {
      String coinsQuery = '';

      for (String coinName in coinsToCompare) {
        if (coinName != basedCoin) coinsQuery += '$coinName-$basedCoin,';
      }
      coinsQuery = coinsQuery.substring(0, coinsQuery.length - 1);

      final response = await dataSource.getCoinsValue(coinsQuery: coinsQuery);

      final body = jsonDecode(response.body);

      final coinsList = CoinsAdapter.fromJson(body);

      return Right(coinsList);
    } catch (e) {
      return const Left(ServerFailure(''));
    }
  }
}
