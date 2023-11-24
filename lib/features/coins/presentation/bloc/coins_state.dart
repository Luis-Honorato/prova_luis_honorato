part of 'coins_bloc.dart';

class CoinsState extends Equatable {
  final RequestStatus getCoinsValueStatus;
  final CoinsEnum basedCoin;
  final List<Coin> comparedCoins;
  const CoinsState({
    this.getCoinsValueStatus = RequestStatus.initial,
    required this.basedCoin,
    this.comparedCoins = const [],
  });

  CoinsState copyWith({
    RequestStatus? getCoinsValueStatus,
    CoinsEnum? basedCoin,
    List<Coin>? comparedCoins,
  }) {
    return CoinsState(
      getCoinsValueStatus: getCoinsValueStatus ?? this.getCoinsValueStatus,
      basedCoin: basedCoin ?? this.basedCoin,
      comparedCoins: comparedCoins ?? this.comparedCoins,
    );
  }

  @override
  List<Object?> get props => [
        getCoinsValueStatus,
        basedCoin,
        comparedCoins,
      ];
}
