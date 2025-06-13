part of 'media_bloc.dart';

@immutable
sealed class MediaEvent {}

final class MediaSelectImageFromGalleryEvent extends MediaEvent {}

final class MediaTakePictureWithCameraEvent extends MediaEvent {}

final class MediaRemoveCurrentReportPictureEvent extends MediaEvent {}
