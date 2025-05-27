import 'dart:io';

import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class CustomUserAvatar extends StatelessWidget {
  final void Function() onCameraIconTapped;
  final String? userProfilePicture;

  const CustomUserAvatar({
    super.key,
    required this.onCameraIconTapped,
    this.userProfilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 105,
          width: 105,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    userProfilePicture != null
                        ? Image.file(File(userProfilePicture!)).image
                        : Image.asset(AppImages.blankProfilePicture).image,
                backgroundColor: AppColors.noProfilePictureBackgroundColor,
              ),
              Positioned(
                bottom: 4,
                right: 5,
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
          ),
        ),
      ],
    );
  }
}
