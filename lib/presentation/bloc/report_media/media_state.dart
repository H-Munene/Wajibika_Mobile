part of 'media_bloc.dart';

@immutable
sealed class MediaState {}

final class MediaNoReportPicturesSelectedState extends MediaState {}

final class MediaReportPictureSelectionFailedState extends MediaState {}

final class MediaReportPictureSelected extends MediaState {
  MediaReportPictureSelected({required this.image});

  final XFile image;
}
