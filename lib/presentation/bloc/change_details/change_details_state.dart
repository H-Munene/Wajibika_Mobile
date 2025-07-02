part of 'change_details_bloc.dart';

class ChangeDetailsState extends Equatable {
  const ChangeDetailsState({required this.isLoading, this.isSuccessful});

  final bool? isSuccessful;
  final bool isLoading;

  ChangeDetailsState copyWith({
    bool? updatedIsLoading,
    bool? updatedIsSuccessful,
  }) {
    return ChangeDetailsState(
      isLoading: updatedIsLoading ?? isLoading,
      isSuccessful: updatedIsSuccessful ?? isSuccessful,
    );
  }

  @override
  List<Object?> get props => [isSuccessful, isLoading];
}
