import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_media_event.dart';
part 'profile_media_state.dart';

/// This bloc defines the operations to add a new or remove the user profile
/// picture.
class ProfileMediaBloc
    extends HydratedBloc<ProfileMediaEvent, ProfileMediaState> {
  ProfileMediaBloc() : super(ProfileMediaState()) {
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
    emit(
      state.copyWith(
        newProfilePicture: '',
        newProfileMediaStatus: ProfileMediaStatus.noProfilePicture,
      ),
    );
  }

  // base method to streamline image selection process
  Future<void> _processImageSelection(
    Emitter<ProfileMediaState> emit,
    ImageSource source,
  ) async {
    // check if current state has a profile picture
    final isThereAProfileIMageSelected =
        state.profileMediaStatus == ProfileMediaStatus.profilePicturePresent;

    try {
      final xfileProfilePictureSelected = await ImagePicker().pickImage(
        source: source,
      );

      // no profile picture in current state
      if (!isThereAProfileIMageSelected) {
        if (xfileProfilePictureSelected == null) {
          //retain current state
          emit(state);
        } else {
          final profilePictureSelected = xfileProfilePictureSelected.path;

          // update profile media state media status to profilePicturePresent,
          //since the previous state is noProfilePicture, and the profile
          //picture
          emit(
            state.copyWith(
              newProfileMediaStatus: ProfileMediaStatus.profilePicturePresent,
              newProfilePicture: profilePictureSelected,
            ),
          );
        }
        return;
      }

      // there is a profile picture in current state

      // failed to pick a profile picture
      if (xfileProfilePictureSelected == null) {
        // retain current state
        emit(state);
      } else {
        // since profile picture was previously set, profile media state is
        // profilePicturePresent thus this is not updated, just the profile
        // picture
        final profilePictureSelected = xfileProfilePictureSelected.path;
        emit(state.copyWith(newProfilePicture: profilePictureSelected));
      }
    } catch (_) {
      // on error retain the current state
      emit(state);
    }
  }

  @override
  ProfileMediaState? fromJson(Map<String, dynamic> json) =>
      ProfileMediaState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ProfileMediaState state) =>
      _$ProfileMediaStateToJson(state);
}
