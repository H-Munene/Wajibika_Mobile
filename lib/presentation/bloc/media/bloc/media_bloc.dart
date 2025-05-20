import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(MediaNoPicturesSelectedState()) {
    on<MediaSelectImageFromGalleryEvent>(_onImagesSelectedFromGallery);
  }

  Future<void> _onImagesSelectedFromGallery(
    MediaSelectImageFromGalleryEvent event,
    Emitter<MediaState> emit,
  ) async {
    try {
      final selectedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (state is MediaPictureSelectedFromGalleryState) {
        final currentState = state as MediaPictureSelectedFromGalleryState;

        if (selectedImage == null) {
          emit(MediaPictureSelectedFromGalleryState(image: currentState.image));
        } else {
          emit(MediaPictureSelectedFromGalleryState(image: selectedImage));
        }
      } else {
        if (selectedImage == null) {
          emit(MediaNoPicturesSelectedState());
        } else {
          emit(MediaPictureSelectedFromGalleryState(image: selectedImage));
        }
      }
    } catch (e) {
      emit(MediaPictureSelectionFailedState());
      emit(MediaNoPicturesSelectedState());
    }
  }
}
