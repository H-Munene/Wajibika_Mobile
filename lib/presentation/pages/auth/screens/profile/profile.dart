import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/domain/repositories/user_repository.dart';
import 'package:bloc_clean_arch/presentation/bloc/auth/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/bloc/profile_media/profile_media_bloc.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/profile/report_history_calender.dart';
import 'package:bloc_clean_arch/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text('Report history', style: textTheme.bodyLarge),
              ),

              const ReportHistoryCalender(),

              const Divider(),
              Center(
                child: CustomButtonWidget(
                  child:
                      state is AuthLoading
                          ? const CustomLoadingIndicator()
                          : Text(
                            'Logout',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthSignOut());

                    // remove the profile picture when user logs out since when
                    // a different user logs in the other user's profile
                    // picture is retained by hydrated bloc
                    // TODO: save the profile picture in db to restore it on login
                    context.read<ProfileMediaBloc>().add(
                      ProfileMediaRemoveCurrentProfilePictureEvent(),
                    );
                  },
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
