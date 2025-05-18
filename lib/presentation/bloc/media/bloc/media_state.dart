part of 'media_bloc.dart';

@immutable
sealed class MediaState {}

final class MediaNoPicturesSelected extends MediaState {}

final class MediaPictureSelectionFailed extends MediaState {}

final class MediaPicturesSelectedFromGallery extends MediaState {
  MediaPicturesSelectedFromGallery({required this.images});

  final List<XFile> images;
}
