import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class CustomDialogBottomAppSheet {
  // material bottom sheet purposefully for selecting media selection type
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

  // cupertino action sheet purposefully for logout
  static FutureOr<void> cupertinoLogoutBottomSheet({
    required BuildContext context,
    required VoidCallback onLogoutPressed,
  }) async {
    final textTheme = Theme.of(context).textTheme.bodyMedium;

    await showCupertinoModalPopup<void>(
      context: context,
      builder:
          (context) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return CupertinoActionSheet(
                title: Text(
                  'Are you sure you want to log out?',
                  style: textTheme?.copyWith(color: AppColors.greyText),
                ),
                actions: [
                  CupertinoActionSheetAction(
                    isDefaultAction: true,
                    onPressed: onLogoutPressed,
                    child:
                        state is AuthLoading
                            ? const CustomLoadingIndicator(
                              color: AppColors.errorColor,
                            )
                            : Text(
                              'Log out',
                              style: textTheme?.copyWith(
                                color: AppColors.errorColor,
                              ),
                            ),
                  ),
                ],

                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(context),
                  child: Text(
                    'Cancel',
                    style: textTheme?.copyWith(color: AppColors.greyText),
                  ),
                ),
              );
            },
          ),
    );
  }

  static FutureOr<void> cupertinoAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required void Function() onDestructiveActionPressed,
  }) async {
    final textTheme = Theme.of(context).textTheme;

    await showCupertinoDialog<void>(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(
              title,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            content: Text(
              content,
              style: textTheme.bodySmall?.copyWith(color: AppColors.greyText),
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Cancel',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.greyText,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                onPressed: onDestructiveActionPressed,
                child: Text(
                  'OK',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
