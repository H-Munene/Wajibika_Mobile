part of 'media_bloc.dart';

@immutable
sealed class MediaEvent {}

final class MediaSelectImagesFromGallery extends MediaEvent {}

final class MediaTakePictureWithCamera extends MediaEvent {}
