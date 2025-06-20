part of 'home_feed_bloc.dart';

class HomeFeedState extends Equatable {
  const HomeFeedState({required this.isLoading, required this.homeFeedModel});

  final HomeFeedModel homeFeedModel;
  final bool isLoading;

  HomeFeedState copyWith({
    HomeFeedModel? updatedHomeFeedModel,
    bool? updatedIsLoading,
  }) {
    return HomeFeedState(
      homeFeedModel: updatedHomeFeedModel ?? homeFeedModel,
      isLoading: updatedIsLoading ?? isLoading,
    );
  }

  @override
  List<Object?> get props => [homeFeedModel, isLoading];
}
