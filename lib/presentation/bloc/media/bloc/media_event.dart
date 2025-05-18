part of 'media_bloc.dart';

@immutable
sealed class MediaEvent {}

final class MediaSelectImageFromGallery extends MediaEvent {}

final class MediaTakePictureWithCamera extends MediaEvent {}
