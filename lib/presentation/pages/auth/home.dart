import 'package:bloc_clean_arch/presentation/bloc/auth/auth_bloc.dart';
import 'package:bloc_clean_arch/presentation/bloc/report_media/media_bloc.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/login.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/home_feed.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/profile/profile.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static Route homePage() =>
      MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> screens = [const HomeFeed(), const ProfilePage()];

  Future<void> _selectImage() async {
    CustomBottomAppSheet.mediaSelectionBottomSheet(
      context: context,
      onCameraSelected: () {
        Navigator.pop(context);
        context.read<MediaBloc>().add(MediaTakePictureWithCameraEvent());
      },
      onGallerySelected: () {
        Navigator.pop(context);
        context.read<MediaBloc>().add(MediaSelectImageFromGalleryEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wajibika'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Badge(
              label: Text('2'),
              child: Icon(CupertinoIcons.bell),
            ),
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
        notchMargin: 5,
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
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(builder: (context) => const LoginPage()),
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
