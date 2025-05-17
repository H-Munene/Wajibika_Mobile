import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static Route homePage() =>
      MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(CupertinoIcons.photo_camera),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
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
      body: Center(
        child: Text(
          'Quis veniam nisi sit eu et ullamco voluptate incididunt nostrud eu minim aute. Aute in in sit do pariatur excepteur. Adipisicing consequat adipisicing duis adipisicing incididunt Lorem. Ullamco laboris Lorem anim ea dolor cillum ut deserunt mollit commodo non cillum minim sit. Sint veniam amet do aute sunt ullamco deserunt. Aute non commodo voluptate anim ex cupidatat eiusmod sunt cillum id pariatur dolore elit enim.: $_currentIndex',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
