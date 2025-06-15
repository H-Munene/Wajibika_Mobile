import 'package:flutter/widgets.dart';

class AppDimensions {
  static BorderRadius circleBorderRadius = BorderRadius.circular(12);
  static BorderRadius unfocussedCircleBorderRadius = BorderRadius.circular(7);
  static BorderRadius focussedCircleBorderRadius = BorderRadius.circular(12);
  static BorderRadius bottomSheetCircleBorderRadius = BorderRadius.circular(15);

  static EdgeInsets pagePadding = const EdgeInsets.symmetric(horizontal: 8);

  static EdgeInsets profilePageWidgetsPadding = const EdgeInsets.only(
    top: 5,
    left: 20,
    right: 35,
  );

  static EdgeInsets bottomSheetPadding = const EdgeInsets.symmetric(
    vertical: 5,
    horizontal: 15,
  );

  static const EdgeInsets textfieldVerticalSpacing = EdgeInsets.symmetric(
    vertical: 5,
  );

  static const double iconSize = 22;
  static const double loadingIndicatorSize = 25;
}
