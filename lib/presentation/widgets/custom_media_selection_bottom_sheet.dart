import 'dart:async';

import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomAppSheet {
  static FutureOr<void> mediaSelectionBottomSheet({
    required BuildContext context,
    required VoidCallback onCameraSelected,
    required VoidCallback onGallerySelected,
    void Function()? onRemoveMediaSelected,
    bool showRemoveMediaActionbutton = false,
  }) async {
    await showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: AppDimensions.bottomSheetPadding,
          height: showRemoveMediaActionbutton ? 200 : 150,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: AppDimensions.bottomSheetCircleBorderRadius,
                  color: AppColors.primaryColor,
                ),
                height: 7,
                width: 50,
              ),
              const SizedBox(height: 25),
              InkWell(
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                onTap: onCameraSelected,
                child: const SizedBox(
                  height: 35,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.photo_camera),
                      SizedBox(width: 10),
                      Text('Camera'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: onGallerySelected,
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                child: const SizedBox(
                  height: 35,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.photo),
                      SizedBox(width: 10),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: !showRemoveMediaActionbutton,
                child: InkWell(
                  onTap: onRemoveMediaSelected,
                  overlayColor: const WidgetStatePropertyAll(
                    Colors.transparent,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 35,
                      child: Row(
                        children: [
                          Icon(Icons.close),
                          SizedBox(width: 10),
                          Text('Remove Photo'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
