import 'package:flutter/material.dart';
import 'core.dart';

class GuardianAppTheme {
  //light theme
  static ThemeData lightTheme() => ThemeData(
    // splashFactory: NoSplash.splashFactory,
    // splashColor: GuardianAppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: _bottomNavigationBarTheme(),
    // badgeTheme: BadgeThemeData(
    //   textStyle: lightTextTheme.bodySmall?.copyWith(
    //     fontWeight: FontWeight.bold,
    //   ),
    //   backgroundColor: Colors.red,
    // ),
    fontFamily: 'Lexend',
    textTheme: GuardianAppTheme.lightTextTheme,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: _floatingActionButtonThemeData(),
    tabBarTheme: _tabBarThemeData(),
  );

  //TODO: needs to be properly configured
  // dark theme
  // static ThemeData darkTheme() => ThemeData(
  //   splashFactory: NoSplash.splashFactory,
  //   splashColor: Colors.transparent,
  //   bottomNavigationBarTheme: _bottomNavigationBarTheme(),
  //   fontFamily: 'Lexend',
  //   badgeTheme: BadgeThemeData(
  //     textStyle: darkTextTheme.bodySmall,
  //     backgroundColor: Colors.red,
  //   ),
  //   brightness: Brightness.dark,
  //   textTheme: GuardianAppTheme.lightTextTheme,
  //   primaryColor: GuardianAppColors.primaryColor,
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: GuardianAppColors.primaryColor,
  //     foregroundColor: Colors.white,
  //   ),
  //   floatingActionButtonTheme: _floatingActionButtonThemeData(),
  //   tabBarTheme: _tabBarThemeData(),
  // );

  static TabBarThemeData _tabBarThemeData() {
    return TabBarThemeData(
      dividerHeight: 0,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.selectedItemColor,
      indicatorColor: AppColors.primaryColor,
    );
  }

  // bottomNavigation bar theme
  static BottomNavigationBarThemeData _bottomNavigationBarTheme() =>
      BottomNavigationBarThemeData(
        elevation: 0,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.selectedItemColor,
        unselectedItemColor: AppColors.unselectedItemColor,
        showUnselectedLabels: true,
      );

  //floatingActionButton theme data
  static FloatingActionButtonThemeData _floatingActionButtonThemeData() =>
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.circleBorderRadius,
        ),
        foregroundColor: Colors.white,
      );

  // light theme textTheme
  static TextTheme lightTextTheme = const TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w200,
      color: Colors.black,
    ),
  );

  // dark theme textTheme
  // static TextTheme darkTextTheme = const TextTheme(
  //   titleLarge: TextStyle(
  //     fontSize: 24.0,
  //     fontWeight: FontWeight.bold,
  //     color: Colors.white,
  //   ),
  //   titleMedium: TextStyle(
  //     fontSize: 22.0,
  //     fontWeight: FontWeight.bold,
  //     color: Colors.white,
  //   ),
  //   bodyLarge: TextStyle(
  //     fontSize: 17.0,
  //     fontWeight: FontWeight.w400,
  //     color: Colors.white,
  //   ),
  //   bodyMedium: TextStyle(
  //     fontSize: 14.0,
  //     fontWeight: FontWeight.w400,
  //     color: Colors.white,
  //   ),
  //   bodySmall: TextStyle(
  //     fontSize: 13.0,
  //     fontWeight: FontWeight.w200,
  //     color: Colors.white,
  //   ),
  // );
}
