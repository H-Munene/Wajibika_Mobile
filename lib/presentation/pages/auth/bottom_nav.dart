import 'package:bloc_clean_arch/presentation/bloc/auth/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/bloc/report_media/media_bloc.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/login.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/bookmarks.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/home/home_feed.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/profile/profile.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/volunteer/volunteer.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_bottom_sheet_dialogs.dart';
import 'package:bloc_clean_arch/presentation/widgets/wajibika_points_icon.dart';
import 'package:bloc_clean_arch/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNav extends StatefulWidget {
  static Route homePage() =>
      MaterialPageRoute(builder: (context) => const BottomNav());

  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  List<Widget> screens = [
    const HomeFeed(),
    const VolunteerPage(),
    const BookMarksPage(),
    const ProfilePage(),
  ];

  Future<void> _selectImage() async {
    CustomDialogBottomAppSheet.mediaSelectionBottomSheet(
      context: context,
      onCameraSelected: () {
        Navigator.of(context).pop();
        context.read<MediaBloc>().add(MediaTakePictureWithCameraEvent());
      },
      onGallerySelected: () {
        Navigator.of(context).pop();
        context.read<MediaBloc>().add(MediaSelectImageFromGalleryEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Wajibika'),
        actions: [
          // TODO: get from user model
          const WajibikaPointsIcon(wajibikaPoints: '47'),
          IconButton(
            onPressed:
                () => CustomDialogBottomAppSheet.cupertinoLogoutBottomSheet(
                  onLogoutPressed:
                      () => context.read<AuthBloc>().add(AuthSignOut()),
                  context: context,
                ),
            icon: const Icon(CupertinoIcons.power),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _selectImage,
        shape: const CircleBorder(),
        child: const Icon(CupertinoIcons.photo_camera),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(CupertinoIcons.house_alt),
              label: 'Home',
              selectedIcon: Icon(CupertinoIcons.house_alt_fill),
            ),

            NavigationDestination(
              icon: Icon(CupertinoIcons.hand_raised),
              label: 'Volunteer',
              selectedIcon: Icon(CupertinoIcons.hand_raised_fill),
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.bookmark),
              label: 'Bookmarks',
              selectedIcon: Icon(CupertinoIcons.bookmark_fill),
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.person_circle),
              label: 'Profile',
              selectedIcon: Icon(CupertinoIcons.person_circle_fill),
            ),
          ],
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false, // Remove all routes
            );
          }
        },
        builder: (context, state) {
          return SafeArea(child: screens[_currentIndex]);
        },
      ),
    );
  }
}
