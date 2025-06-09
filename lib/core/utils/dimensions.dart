import 'package:flutter/widgets.dart';

class AppDimensions {
  static BorderRadius circleBorderRadius = BorderRadius.circular(12);
  static BorderRadius unfocussedCircleBorderRadius = BorderRadius.circular(7);
  static BorderRadius focussedCircleBorderRadius = BorderRadius.circular(12);
  static BorderRadius bottomSheetCircleBorderRadius = BorderRadius.circular(15);

static EdgeInsets pagePadding = const EdgeInsets.symmetric(
    vertical: 3,
    horizontal: 17,
  );

  static EdgeInsets bottomSheetPadding = const EdgeInsets.symmetric(
    vertical: 5,
    horizontal: 15,
  );

  static const EdgeInsets textfieldVerticalSpacing = EdgeInsets.symmetric(
    vertical: 10,
  );

  static const double iconSize = 22;
  static const double loadingIndicatorSize = 25;
}
