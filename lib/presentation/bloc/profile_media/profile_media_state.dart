part of 'profile_media_bloc.dart';

enum ProfileMediaStatus { noProfilePicture, profilePicturePresent }

@JsonSerializable(explicitToJson: true)
final class ProfileMediaState {
  ProfileMediaState({
    this.profileMediaStatus = ProfileMediaStatus.noProfilePicture,
    this.profilePicture = '',
  });

  final ProfileMediaStatus profileMediaStatus;
  final String profilePicture;

  ProfileMediaState copyWith({
    ProfileMediaStatus? newProfileMediaStatus,
    String? newProfilePicture,
  }) {
    return ProfileMediaState(
      profileMediaStatus: newProfileMediaStatus ?? profileMediaStatus,
      profilePicture: newProfilePicture ?? profilePicture,
    );
  }

  factory ProfileMediaState.fromJson(Map<String, dynamic> json) =>
      _$ProfileMediaStateFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileMediaStateToJson(this);
}

// used to retain state
ProfileMediaState _$ProfileMediaStateFromJson(Map<String, dynamic> json) =>
    ProfileMediaState(
      profileMediaStatus:
          $enumDecodeNullable(
            _$ProfileMediaStatusEnumMap,
            json['profileMediaStatus'],
          ) ??
          ProfileMediaStatus.noProfilePicture,
      profilePicture: json['profilePicture'] as String? ?? '',
    );

Map<String, dynamic> _$ProfileMediaStateToJson(ProfileMediaState instance) =>
    <String, dynamic>{
      'profileMediaStatus':
          _$ProfileMediaStatusEnumMap[instance.profileMediaStatus],
      'profilePicture': instance.profilePicture,
    };

const _$ProfileMediaStatusEnumMap = {
  ProfileMediaStatus.noProfilePicture: 'noProfilePicture',
  ProfileMediaStatus.profilePicturePresent: 'profilePicturePresent',
};
