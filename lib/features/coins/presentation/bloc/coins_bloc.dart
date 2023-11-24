import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:prova_luis_honorato/features/coins/data/repositoryes/coins_repository.dart';
import 'package:prova_luis_honorato/features/coins/domain/entities/coin.dart';
import 'package:prova_luis_honorato/features/utils/request_status.dart';

part 'coins_event.dart';
part 'coins_state.dart';

class CoinsBloc extends Bloc<CoinsEvent, CoinsState> {
  final CoinsRepository _coinsRepository;
  CoinsBloc({
    required CoinsRepository coinsRepository,
  })  : _coinsRepository = coinsRepository,
        super(
          const CoinsState(
            basedCoin: CoinsEnum.real,
          ),
        ) {
    on<FetchCoinsValue>((event, emit) async {
      emit(state.copyWith(
        getCoinsValueStatus: RequestStatus.loading,
      ));

      final response = await _coinsRepository.getCoinsValue(
        basedCoin: state.basedCoin.acronym,
        coinsToCompare: event.coinsToCompare,
      );

      response.fold(
        (failure) {
          emit(state.copyWith(
            getCoinsValueStatus: RequestStatus.failure,
          ));
          debugPrint('Failure to loading Coins Value');
        },
        (coins) {
          emit(state.copyWith(
            comparedCoins: coins,
            getCoinsValueStatus: RequestStatus.success,
          ));
          debugPrint('Coins Value succesfully loaded');
        },
      );
    });

    on<SetBasedCoinEvent>((event, emit) {
      emit(
        state.copyWith(
          basedCoin: event.coin,
        ),
      );
      debugPrint('New coin: ${state.basedCoin.name}');
    });
  }
}
