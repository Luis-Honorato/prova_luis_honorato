import 'package:dartz/dartz.dart';
import 'package:prova_luis_honorato/features/coins/domain/entities/coin.dart';
import 'package:prova_luis_honorato/features/utils/failures.dart';

abstract class ICoinsRepository {
  Future<Either<Failure, List<Coin>>> getCoinsValue({
    required String basedCoin,
    required List<String> coinsToCompare,
  });
}
