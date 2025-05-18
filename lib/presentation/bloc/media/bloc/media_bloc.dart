import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(MediaNoPicturesSelected()) {
    on<MediaSelectImageFromGallery>(_onImagesSelectedFromGallery);
  }

  Future<void> _onImagesSelectedFromGallery(
    MediaSelectImageFromGallery event,
    Emitter<MediaState> emit,
  ) async {
    try {
      final selectedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (state is MediaPictureSelectedFromGallery) {
        final currentState = state as MediaPictureSelectedFromGallery;

        if (selectedImage == null) {
          emit(MediaPictureSelectedFromGallery(image: currentState.image));
        } else {
          emit(MediaPictureSelectedFromGallery(image: selectedImage));
        }
      } else {
        if (selectedImage == null) {
          emit(MediaNoPicturesSelected());
        } else {
          emit(MediaPictureSelectedFromGallery(image: selectedImage));
        }
      }
    } catch (e) {
      emit(MediaPictureSelectionFailed());
      emit(MediaNoPicturesSelected());
    }
  }
}
