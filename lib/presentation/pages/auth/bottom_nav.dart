import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
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

        // redirect to report page
        Navigator.of(
          context,
        ).push(CupertinoPageRoute(builder: (context) => const ReportPage()));
      },
      onGallerySelected: () {
        Navigator.of(context).pop();
        context.read<MediaBloc>().add(MediaSelectImageFromGalleryEvent());

        // redirect to report page
        Navigator.of(
          context,
        ).push(CupertinoPageRoute(builder: (context) => const ReportPage()));
      },
    );
  }

  @override
  void initState() {
    // get initial home feed after login
    context.read<HomeFeedBloc>().add(HomeFeedGetFeed());
    context.read<ReportVolunteerHistoryBloc>().add(
      ReportVolunteerHistoryEventRequest(),
    );

    final homeFeedModel = context.read<HomeFeedBloc>().state.homeFeedModel;
    print('✅✅HOMEFEED MODEL: $homeFeedModel');
    context.read<VolunteerBloc>().add(
      VolunteerEventFetchInitialRegisteredVolunteerEvents(
        homeFeedModel: homeFeedModel,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wajibikaPoints =
        context
            .watch<HomeFeedBloc>()
            .state
            .homeFeedModel
            .current_user_wajibika_points;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(Globals.mainPageTitle),
        actions: [WajibikaPointsIcon(wajibikaPoints: wajibikaPoints ?? 0)],
        actionsPadding: const EdgeInsets.only(right: 10),
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
          destinations: [
            const NavigationDestination(
              icon: Icon(CupertinoIcons.house_alt),
              label: Globals.bottomNavHomeIconLabel,
              selectedIcon: Icon(CupertinoIcons.house_alt_fill),
            ),

            NavigationDestination(
              icon: BlocBuilder<VolunteerBloc, VolunteerState>(
                builder: (BuildContext context, state) {
                  final registeredAsVolunteerEventsCount =
                      context
                          .read<VolunteerBloc>()
                          .state
                          .registeredVolunteerEvents
                          .length;

                  return registeredAsVolunteerEventsCount != 0
                      ? Badge(
                        label: Text('$registeredAsVolunteerEventsCount'),
                        child: const Icon(CupertinoIcons.hand_raised),
                      )
                      : const Icon(CupertinoIcons.hand_raised);
                },
              ),
              label: Globals.bottomNavVolunteerIconLabel,
              selectedIcon: BlocBuilder<VolunteerBloc, VolunteerState>(
                builder: (BuildContext context, state) {
                  final registeredAsVolunteerEventsCount =
                      context
                          .read<VolunteerBloc>()
                          .state
                          .registeredVolunteerEvents
                          .length;

                  return registeredAsVolunteerEventsCount != 0
                      ? Badge(
                        label: Text('$registeredAsVolunteerEventsCount'),
                        child: const Icon(CupertinoIcons.hand_raised_fill),
                      )
                      : const Icon(CupertinoIcons.hand_raised_fill);
                },
              ),
            ),
            const NavigationDestination(
              icon: Icon(CupertinoIcons.bookmark),
              label: Globals.bottomNavBookmarksIconLabel,
              selectedIcon: Icon(CupertinoIcons.bookmark_fill),
            ),
            const NavigationDestination(
              icon: Icon(CupertinoIcons.person_circle),
              label: Globals.bottomNavProfileIconLabel,
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
              (route) => false,
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
