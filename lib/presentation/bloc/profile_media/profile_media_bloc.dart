import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_media_event.dart';
part 'profile_media_state.dart';

/// This bloc defines the operations to add a new or remove the user profile
/// picture.
class ProfileMediaBloc extends Bloc<ProfileMediaEvent, ProfileMediaState> {
  ProfileMediaBloc() : super(ProfileMediaNoProfileImageSelectedState()) {
    on<ProfileMediaChangeProfilePictureFromCameraEvent>(
      _onProfilePictureChangeFromCamera,
    );
    on<ProfileMediaChangeProfilePictureFromGalleryEvent>(
      _onProfilePictureChangeFromGallery,
    );
    on<ProfileMediaRemoveCurrentProfilePictureEvent>(_onRemoveProfilePicture);
  }

  /// Get profile picture from camera
  Future<void> _onProfilePictureChangeFromCamera(
    ProfileMediaChangeProfilePictureFromCameraEvent event,
    Emitter<ProfileMediaState> emit,
  ) async {
    await _processImageSelection(emit, ImageSource.camera);
  }

  /// Get profile picture from gallery
  Future<void> _onProfilePictureChangeFromGallery(
    ProfileMediaChangeProfilePictureFromGalleryEvent event,
    Emitter<ProfileMediaState> emit,
  ) async {
    await _processImageSelection(emit, ImageSource.gallery);
  }

  /// Remove the current profile picture
  Future<void> _onRemoveProfilePicture(
    ProfileMediaRemoveCurrentProfilePictureEvent event,
    Emitter<ProfileMediaState> emit,
  ) async {
    emit(ProfileMediaNoProfileImageSelectedState());
  }

  // base method to streamline image selection process
  Future<void> _processImageSelection(
    Emitter<ProfileMediaState> emit,
    ImageSource source,
  ) async {
    final bool isThereAProfileIMageSelected =
        state is ProfileMediaProfileImageSelectedState;

    try {
      final profilePictureSelected = await ImagePicker().pickImage(
        source: source,
      );

      if (isThereAProfileIMageSelected) {
        final currentState = state as ProfileMediaProfileImageSelectedState;

        if (profilePictureSelected == null) {
          emit(
            ProfileMediaProfileImageSelectedState(
              profilePicture: currentState.profilePicture,
            ),
          );
        } else {
          emit(
            ProfileMediaProfileImageSelectedState(
              profilePicture: profilePictureSelected,
            ),
          );
        }
      } else {
        if (profilePictureSelected == null) {
          emit(ProfileMediaNoProfileImageSelectedState());
        } else {
          emit(
            ProfileMediaProfileImageSelectedState(
              profilePicture: profilePictureSelected,
            ),
          );
        }
      }
    } catch (_) {
      emit(ProfileMediaFailedProfileImageSelectionState());
      if (isThereAProfileIMageSelected) {
        final currentState = state as ProfileMediaProfileImageSelectedState;

        emit(
          ProfileMediaProfileImageSelectedState(
            profilePicture: currentState.profilePicture,
          ),
        );
      } else {
        emit(ProfileMediaNoProfileImageSelectedState());
      }
    }
  }
}
