import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(MediaNoPicturesSelected()) {
    on<MediaSelectImagesFromGallery>(_onImagesSelectedFromGallery);
  }

  Future<void> _onImagesSelectedFromGallery(
    MediaSelectImagesFromGallery event,
    Emitter<MediaState> emit,
  ) async {
    try {
      final selectedImages = await ImagePicker().pickMultiImage(limit: 2);

      if (selectedImages.isEmpty) {
        emit(MediaNoPicturesSelected());
      } else {
        emit(MediaPicturesSelectedFromGallery(images: selectedImages));
      }
    } catch (e) {
      emit(MediaPictureSelectionFailed());
      emit(MediaNoPicturesSelected());
    }
  }
}
