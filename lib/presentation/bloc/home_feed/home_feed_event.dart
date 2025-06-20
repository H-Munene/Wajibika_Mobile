part of 'home_feed_bloc.dart';

sealed class HomeFeedEvent extends Equatable {
  const HomeFeedEvent();

  @override
  List<Object> get props => [];
}

final class HomeFeedGetFeed extends HomeFeedEvent {}
