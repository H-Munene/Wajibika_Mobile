import 'dart:io';

import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class CustomUserAvatar extends StatelessWidget {
  final void Function()? onCameraIconTapped;
  final String userProfilePicture;
  final bool showAddIcon;

  const CustomUserAvatar({
    super.key,
    this.onCameraIconTapped,
    this.userProfilePicture = '',
    this.showAddIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final baseUserAvatar = CircleAvatar(
      radius: 50,
      backgroundImage:
          userProfilePicture == ''
              ? Image.asset(AppImages.blankProfilePicture).image
              : Image.file(File(userProfilePicture)).image,

      backgroundColor: AppColors.noImageBackgroundColor,
    );
    return Column(
      children: [
        SizedBox(
          height: showAddIcon ? 105 : 40,
          width: showAddIcon ? 105 : 40,
          child:
              showAddIcon
                  ? Stack(
                    children: [
                      baseUserAvatar,
                      Positioned(
                        bottom: showAddIcon ? 4 : -4,
                        right: showAddIcon ? 5 : -4,
                        child: GestureDetector(
                          onTap: onCameraIconTapped,
                          child: const CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.primaryColor,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.hightlightColor,
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : baseUserAvatar,
        ),
      ],
    );
  }
}
