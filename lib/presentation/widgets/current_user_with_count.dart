import 'dart:io';

import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// conditionally diplays the user avatar and another user avatar with the count
// to signify number of volunteers in a report
class UserAvatarandOtherUserAvatWithCount extends StatelessWidget {
  final bool showMyAvatar; // current user avatar
  final int volunteerCount; // number of volunteers for this report

  const UserAvatarandOtherUserAvatWithCount({
    super.key,
    this.showMyAvatar = false,
    required this.volunteerCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // current user avatar
        if (showMyAvatar)
          BlocBuilder<ProfileMediaBloc, ProfileMediaState>(
            builder: (context, state) {
              return CircleAvatar(
                radius: 7,
                backgroundImage:
                    state.profileMediaStatus ==
                            ProfileMediaStatus.profilePicturePresent
                        ? Image.file(File(state.profilePicture)).image
                        : Image.asset(AppImages.blankProfilePicture).image,

                backgroundColor: AppColors.noImageBackgroundColor,
              );
            },
          ),
        // avatar to signify other volunteers
        if (volunteerCount >= 1)
          Row(
            spacing: 1,
            children: [
              CircleAvatar(
                radius: 7,
                backgroundImage:
                    Image.asset(AppImages.blankProfilePicture).image,

                backgroundColor: AppColors.noImageBackgroundColor,
              ),
              Text(
                volunteerCount <= 5 ? '$volunteerCount' : '5+',
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
      ],
    );
  }
}
