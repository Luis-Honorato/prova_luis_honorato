import 'package:equatable/equatable.dart';

enum CoinsEnum {
  real('BRL'),
  dolar('USD'),
  euro('EUR'),
  libra('GBP');

  final String acronym;

  const CoinsEnum(this.acronym);
}

class Coin extends Equatable {
  final String name;
  final String code;
  final double value;

  const Coin({
    required this.name,
    required this.code,
    required this.value,
  });

  @override
  List<Object?> get props => [
        name,
        code,
        value,
      ];
}
