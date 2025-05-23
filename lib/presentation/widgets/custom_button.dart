import 'package:flutter/material.dart';

import '../../core/core.dart';

class CustomButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final Color color;

  const CustomButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.color = AppColors.buttonBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.textfieldVerticalSpacing,
      child: MaterialButton(
        elevation: 0,
        onPressed: onPressed,
        color: color,
        child: child,
      ),
    );
  }
}
