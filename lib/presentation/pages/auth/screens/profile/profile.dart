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

  Future<void> onRefresh() async {
    setState(() {});
    context.read<ReportVolunteerHistoryBloc>().add(
      ReportVolunteerHistoryEventRequest(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final wajibikaPoints =
        context
            .read<HomeFeedBloc>()
            .state
            .homeFeedModel
            .current_user_wajibika_points;
    final reportHistoryCount =
        context.read<ReportVolunteerHistoryBloc>().state.reportHistoryCount;

    final volunteerHistoryCount =
        context.read<ReportVolunteerHistoryBloc>().state.volunteerHistoryCount;

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
          final username = context.read<UserRepository>().getUserName().fold(
            (_) => 'user',
            (username) => username,
          );

          final email = context.read<UserRepository>().getUserEmail().fold(
            (_) => 'email unavailable',
            (email) => email,
          );
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: _CurvedBottomContainer(),
                  child: Container(
                    color: AppColors.primaryColor,
                    height: 140,
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
                                onPressed:
                                    () => Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder:
                                            (context) => const EditProfile(),
                                      ),
                                    ),
                              ),
                            ],
                          ),

                          // logout button
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 18,
                              left: 20,
                            ),
                            child: IconButton(
                              onPressed:
                                  () => CustomDialogBottomAppSheet.cupertinoLogoutBottomSheet(
                                    onLogoutPressed: () async {
                                      context.read<AuthBloc>().add(
                                        AuthSignOut(),
                                      );

                                      // clear volunteer events, bookmarks and the profile picture if set:
                                      // ideally supposed to have db save them so that they are
                                      // restored.We clear it for now just so that if another
                                      // user logs in they dont find saved volunteer events
                                      // they didnt register to
                                      context.read<VolunteerBloc>().add(
                                        VolunteerEventClear(),
                                      );
                                      context.read<BookmarkBloc>().add(
                                        BookmarkEventClear(),
                                      );
                                      context.read<ProfileMediaBloc>().add(
                                        ProfileMediaRemoveCurrentProfilePictureEvent(),
                                      );
                                    },
                                    context: context,
                                  ),
                              icon: const Icon(
                                CupertinoIcons.square_arrow_right,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
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

                BlocBuilder<
                  ReportVolunteerHistoryBloc,
                  ReportVolunteerHistoryState
                >(
                  builder: (context, reportVolunteerState) {
                    final reportHistoryDataset =
                        reportVolunteerState.reportHistoryDataset;

                    final volunteerHistoryDataset =
                        reportVolunteerState.volunteerHistoryDataset;

                    return ReportHistoryCalender(
                      toggleCalendar: showReportHistory,
                      reportdatasets: reportHistoryDataset,
                      volunteerdatasets: volunteerHistoryDataset,
                      onActiveReportDateClicked: (date) {
                        final formattedDate = date.toString().substring(0, 10);

                        // clear state
                        context
                            .read<ReportVolunteerHistoryOnSpecificDateBloc>()
                            .add(ReportVolunteerHistoryClearState());

                        // make request
                        context
                            .read<ReportVolunteerHistoryOnSpecificDateBloc>()
                            .add(
                              ReportHistoryOnSpecificDateRequest(
                                date: formattedDate,
                              ),
                            );

                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder:
                                (context) => const ReportVolunteerHistoryPage(
                                  type: 'report',
                                ),
                          ),
                        );
                      },
                      onActiveVolunteerDateClicked: (date) {
                        final formattedDate = date.toString().substring(0, 10);

                        // clear state
                        context
                            .read<ReportVolunteerHistoryOnSpecificDateBloc>()
                            .add(ReportVolunteerHistoryClearState());

                        // make request
                        context
                            .read<ReportVolunteerHistoryOnSpecificDateBloc>()
                            .add(
                              VolunteerHistoryOnSpecificDateRequest(
                                date: formattedDate,
                              ),
                            );

                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder:
                                (context) => const ReportVolunteerHistoryPage(
                                  type: 'volunteer',
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),

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

                  child: Row(
                    children: [
                      ProfileSummary(
                        summaryCount: wajibikaPoints ?? 0,
                        profileSummaryCategory:
                            ProfileSummaryCategory.wajibikaPoints,
                      ),
                      ProfileSummary(
                        summaryCount: volunteerHistoryCount,
                        profileSummaryCategory:
                            ProfileSummaryCategory.volunteer,
                      ),
                      ProfileSummary(
                        summaryCount: reportHistoryCount,
                        profileSummaryCategory: ProfileSummaryCategory.report,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
