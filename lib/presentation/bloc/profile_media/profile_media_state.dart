part of 'profile_media_bloc.dart';

@immutable
sealed class ProfileMediaState {}

final class ProfileMediaNoProfileImageSelectedState extends ProfileMediaState {}

final class ProfileMediaProfileImageSelectedState extends ProfileMediaState {
  final XFile profilePicture;

  ProfileMediaProfileImageSelectedState({required this.profilePicture});
}

final class ProfileMediaFailedProfileImageSelectionState
    extends ProfileMediaState {}
