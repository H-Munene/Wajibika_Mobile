import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showReportHistory = true;

  Future<void> _selectProfilePicture(bool showRemoveMediaActionbutton) async {
    CustomDialogBottomAppSheet.mediaSelectionBottomSheet(
      context: context,
      onCameraSelected: () {
        Navigator.of(context).pop();
        context.read<ProfileMediaBloc>().add(
          ProfileMediaChangeProfilePictureFromCameraEvent(),
        );
      },
      onGallerySelected: () {
        Navigator.of(context).pop();
        context.read<ProfileMediaBloc>().add(
          ProfileMediaChangeProfilePictureFromGalleryEvent(),
        );
      },
      showRemoveMediaActionbutton: showRemoveMediaActionbutton,
      onRemoveMediaSelected: () {
        Navigator.of(context).pop();
        context.read<ProfileMediaBloc>().add(
          ProfileMediaRemoveCurrentProfilePictureEvent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final username = context.read<UserRepository>().getUserName().fold(
      (_) => 'user',
      (username) => username,
    );

    final email = context.read<UserRepository>().getUserEmail().fold(
      (_) => 'email unavailable',
      (email) => email,
    );

    return Center(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            SnackbarDefinition.errorSnackBar(
              context: context,
              message: 'Failed to logout. Please try again!!',
            );
          }
          if (state is AuthLoggedOut) {
            SnackbarDefinition.successSnackBar(
              context: context,
              message: 'Successfully Logged out',
            );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: _CurvedBottomContainer(),
                child: Container(
                  color: AppColors.primaryColor,
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Row(
                      children: [
                        BlocBuilder<ProfileMediaBloc, ProfileMediaState>(
                          builder: (context, state) {
                            // if the user has set a profile picture
                            final isThereimageSelected =
                                state.profileMediaStatus ==
                                ProfileMediaStatus.profilePicturePresent;
                            return Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: CustomUserAvatar(
                                //display the user image when tapped
                                onCameraIconTapped:
                                    () => _selectProfilePicture(
                                      isThereimageSelected,
                                    ),
                                userProfilePicture:
                                    isThereimageSelected
                                        ? state.profilePicture
                                        : '',
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              email,
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            CustomButtonWidget(
                              color: AppColors.otherButtonBackgroundColor,
                              child: Text(
                                'Edit Profile',
                                style: textTheme.bodyMedium,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: AppDimensions.profilePageWidgetsPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      showReportHistory
                          ? Globals.reportsHistorySectionTitle
                          : Globals.volunteerHistorySectionTitle,
                      style: textTheme.bodyLarge,
                    ),

                    CupertinoSwitch(
                      value: showReportHistory,
                      activeTrackColor: AppColors.primaryColor,
                      inactiveTrackColor: AppColors.secondaryColor,
                      onChanged: (value) {
                        setState(() {
                          showReportHistory = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              ReportHistoryCalender(toggleCalendar: showReportHistory),

              const Divider(),

              Padding(
                padding: AppDimensions.profilePageWidgetsPadding,

                child: Text(
                  Globals.profileSummarySectionTitle,
                  style: textTheme.bodyLarge,
                ),
              ),

              Padding(
                padding: AppDimensions.profilePageWidgetsPadding,

                child: const Row(
                  children: [
                    ProfileSummary(
                      summaryCount: 162,
                      profileSummaryCategory:
                          ProfileSummaryCategory.wajibikaPoints,
                    ),
                    ProfileSummary(
                      summaryCount: 3,
                      profileSummaryCategory: ProfileSummaryCategory.volunteer,
                    ),
                    ProfileSummary(
                      summaryCount: 13,
                      profileSummaryCategory: ProfileSummaryCategory.report,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CurvedBottomContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final containerHeight = size.height;
    final containerWidth = size.width;

    final path =
        Path()
          ..lineTo(0, containerHeight) //bottom left
          ..quadraticBezierTo(
            0,
            containerHeight - 20,

            30,
            containerHeight - 20,
          ) // curve at bottom left
          ..lineTo(
            containerWidth - 30,
            containerHeight - 20,
          ) // straight line connecting the two curves
          ..quadraticBezierTo(
            containerWidth,
            containerHeight - 20,

            containerWidth,
            containerHeight,
          ) // curve at bottom right
          ..lineTo(containerWidth, 0) //
          ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
