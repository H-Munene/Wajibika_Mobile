part of 'media_bloc.dart';

@immutable
sealed class MediaState {}

final class MediaNoPicturesSelectedState extends MediaState {}

final class MediaPictureSelectionFailedState extends MediaState {}

final class MediaPictureSelectedFromGalleryState extends MediaState {
  MediaPictureSelectedFromGalleryState({required this.image});

  final XFile image;
}
