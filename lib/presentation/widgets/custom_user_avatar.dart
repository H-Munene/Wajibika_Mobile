import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class CustomUserAvatar extends StatelessWidget {
  final String username;

  const CustomUserAvatar({required this.username, super.key});

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
                    Image.asset(AppImages.blankProfilePicture).image,
                backgroundColor: AppColors.noProfilePictureBackgroundColor,
              ),
              const Positioned(
                bottom: 4,
                right: 5,
                child: CircleAvatar(
                  radius: 16,
                  // should change to black on dark mode
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.add, color: Colors.white),
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
