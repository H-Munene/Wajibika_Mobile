import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core.dart';

class AppTheme {
  //light theme
  static ThemeData lightTheme() => ThemeData(
    iconTheme: const IconThemeData(size: AppDimensions.iconSize),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    // splashFactory: NoSplash.splashFactory,
    // splashColor: GuardianAppColors.primaryColor,
    // scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    scaffoldBackgroundColor: Colors.white,
    // bottomNavigationBarTheme: _bottomNavigationBarTheme(),
    textTheme: lightTextTheme(),
    badgeTheme: BadgeThemeData(
      textStyle: lightTextTheme().bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.red,
    ),
    bottomNavigationBarTheme: _bottomNavigationBarTheme(),
    navigationBarTheme: _navigationBarThemeData(),
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      shadowColor: Colors.black,
      elevation: 1,
      color: Colors.white,
      shape: CircularNotchedRectangle(),
    ),
    floatingActionButtonTheme: _floatingActionButtonThemeData(),
    tabBarTheme: _tabBarThemeData(),
  );

  // TODO(H-Munene): dark theme configuration, https://github.com/H-Munene/bloc_CleanArch/issues/2

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
  //   textTheme: AppTheme.lightTextTheme,
  //   primaryColor: GuardianAppColors.primaryColor,
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: GuardianAppColors.primaryColor,
  //     foregroundColor: Colors.white,
  //   ),
  //   floatingActionButtonTheme: _floatingActionButtonThemeData(),
  //   tabBarTheme: _tabBarThemeData(),
  // );
  static NavigationBarThemeData _navigationBarThemeData() {
    return const NavigationBarThemeData(
      elevation: 5,
      backgroundColor: Colors.white,
    );
  }

  static TabBarThemeData _tabBarThemeData() {
    return const TabBarThemeData(
      dividerHeight: 1,
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.selectedItemColor,
      indicatorColor: AppColors.primaryColor,
    );
  }

  // bottomNavigation bar theme
  static BottomNavigationBarThemeData _bottomNavigationBarTheme() =>
      const BottomNavigationBarThemeData(
        elevation: 5,
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
  static TextTheme lightTextTheme() => TextTheme(
    titleLarge: GoogleFonts.lexendExa(
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    titleMedium: GoogleFonts.lexendExa(
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    bodyLarge: GoogleFonts.lexendExa(
      textStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    bodyMedium: GoogleFonts.lexendExa(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    bodySmall: GoogleFonts.lexendExa(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w200,
        color: Colors.black,
      ),
    ),
    labelMedium: GoogleFonts.lexendExa(
      fontSize: 12,
      fontWeight: FontWeight.w400,
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
