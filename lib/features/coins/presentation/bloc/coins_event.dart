part of 'coins_bloc.dart';

sealed class CoinsEvent extends Equatable {
  const CoinsEvent();

  @override
  List<Object> get props => [];
}

class SetBasedCoinEvent extends CoinsEvent {
  final CoinsEnum coin;

  const SetBasedCoinEvent(this.coin);
}

class FetchCoinsValue extends CoinsEvent {
  final List<String> coinsToCompare;

  const FetchCoinsValue({
    required this.coinsToCompare,
  });
}
