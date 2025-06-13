import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(MediaNoReportPicturesSelectedState()) {
    on<MediaSelectImageFromGalleryEvent>(_onMediaObtainedFromGallery);
    on<MediaTakePictureWithCameraEvent>(_onMediaObtainedFromCamera);
    on<MediaRemoveCurrentReportPictureEvent>(_onRemoveReportPicture);
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

  Future<void> _onRemoveReportPicture(
    MediaRemoveCurrentReportPictureEvent event,
    Emitter<MediaState> emit,
  ) async {
    emit(MediaNoReportPicturesSelectedState());
  }

  // Primarily checks if there is already a selected image in the current state
  // If no image is selected by the user when there is an already selected image
  // the already present image is retained
  Future<void> _processImageSelection(
    Emitter<MediaState> emit,
    ImageSource source,
  ) async {
    final isThereReportedMedia = state is MediaReportPictureSelected;
    try {
      final pictureTaken = await ImagePicker().pickImage(source: source);

      if (isThereReportedMedia) {
        final currentState = state as MediaReportPictureSelected;

        if (pictureTaken == null) {
          emit(MediaReportPictureSelected(image: currentState.image));
        } else {
          emit(MediaReportPictureSelected(image: pictureTaken));
        }
      } else {
        if (pictureTaken == null) {
          emit(MediaNoReportPicturesSelectedState());
        } else {
          emit(MediaReportPictureSelected(image: pictureTaken));
        }
      }
    } catch (e) {
      if (isThereReportedMedia) {
        final currentState = state as MediaReportPictureSelected;
        emit(MediaReportPictureSelected(image: currentState.image));
      } else {
        emit(MediaNoReportPicturesSelectedState());
      }
    }
  }
}
