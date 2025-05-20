import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(MediaNoPicturesSelectedState()) {
    on<MediaSelectImageFromGalleryEvent>(_onMediaObtainedFromGallery);
    on<MediaTakePictureWithCameraEvent>(_onMediaObtainedFromCamera);
  }

  Future<void> _onMediaObtainedFromGallery(
    MediaSelectImageFromGalleryEvent event,
    Emitter<MediaState> emit,
  ) async {
    await _processImageSelection(emit, ImageSource.gallery);
  }

  Future<void> _onMediaObtainedFromCamera(
    MediaTakePictureWithCameraEvent event,
    Emitter<MediaState> emit,
  ) async {
    await _processImageSelection(emit, ImageSource.camera);
  }

  /// Primarily checks if there is already a selected image in the current state
  ///
  ///If no image is selected by the user when there is an already selected image
  ///the already present image is retained
  //couldn't think of a better name😭😭
  Future<void> _processImageSelection(
    Emitter<MediaState> emit,
    ImageSource source,
  ) async {
    try {
      final pictureTaken = await ImagePicker().pickImage(source: source);

      if (state is MediaPictureSelectedFromGalleryState) {
        final currentState = state as MediaPictureSelectedFromGalleryState;

        if (pictureTaken == null) {
          emit(MediaPictureSelectedFromGalleryState(image: currentState.image));
        } else {
          emit(MediaPictureSelectedFromGalleryState(image: pictureTaken));
        }
      } else {
        if (pictureTaken == null) {
          emit(MediaNoPicturesSelectedState());
        } else {
          emit(MediaPictureSelectedFromGalleryState(image: pictureTaken));
        }
      }
    } catch (e) {
      emit(MediaPictureSelectionFailedState());
      emit(MediaNoPicturesSelectedState());
    }
  }
}
