part of 'media_bloc.dart';

@immutable
sealed class MediaState {}

final class MediaNoPicturesSelected extends MediaState {}

final class MediaPictureSelectionFailed extends MediaState {}

final class MediaPictureSelectedFromGallery extends MediaState {
  MediaPictureSelectedFromGallery({required this.image});

  final XFile image;
}
