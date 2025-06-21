import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'home_feed_event.dart';
part 'home_feed_state.dart';

class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  final GetHomeFeedUseCase _getHomeFeedUseCase;

  HomeFeedBloc({required GetHomeFeedUseCase getHomeFeedUseCase})
    : _getHomeFeedUseCase = getHomeFeedUseCase,
      super(
        HomeFeedState(
          isLoading: false,
          homeFeedModel: HomeFeedModel(
            clogged_drain: [],
            negligent_dumping: [],
          ),
        ),
      ) {
    on<HomeFeedGetFeed>(_onGetHomeFeed);
  }

  Future<void> _onGetHomeFeed(
    HomeFeedGetFeed event,
    Emitter<HomeFeedState> emit,
  ) async {
    emit(state.copyWith(updatedIsLoading: true));

    // final response = await _getHomeFeedUseCase.call(NoParams());

    await Future.delayed(const Duration(seconds: 1), () async {
      final response = await _getHomeFeedUseCase.call(NoParams());

      response.fold(
        (error) {
          emit(state.copyWith(updatedIsLoading: false));
        },
        (homeFeed) {
          emit(HomeFeedState(homeFeedModel: homeFeed, isLoading: false));
        },
      );
    });
  }
}
