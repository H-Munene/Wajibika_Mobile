part of 'profile_media_bloc.dart';

@immutable
sealed class ProfileMediaEvent {}

final class ProfileMediaChangeProfilePictureFromCameraEvent
    extends ProfileMediaEvent {}

final class ProfileMediaRemoveCurrentProfilePictureEvent
    extends ProfileMediaEvent {}

final class ProfileMediaChangeProfilePictureFromGalleryEvent
    extends ProfileMediaEvent {}
