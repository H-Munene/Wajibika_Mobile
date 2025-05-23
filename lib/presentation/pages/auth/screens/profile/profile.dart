import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/bloc/auth/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/profile/report_history_calender.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_button.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 55,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'johndoe@gmail.com',
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
                  onPressed: () => context.read<AuthBloc>().add(AuthSignOut()),
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
