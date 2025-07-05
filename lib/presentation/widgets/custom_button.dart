import 'package:flutter/material.dart';

import '../../core/core.dart';

class CustomButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final Color color;
  final bool makeButtonRounded;
  final bool? enable;

  const CustomButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.color = AppColors.buttonBackgroundColor,
    this.makeButtonRounded = false,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.textfieldVerticalSpacing,
      child: MaterialButton(
        elevation: 0,
        onPressed: enable == true ? onPressed : null,
        color: color,
        shape:
            makeButtonRounded
                ? RoundedRectangleBorder(
                  side: const BorderSide(),
                  borderRadius: AppDimensions.circleBorderRadius,
                )
                : null,
        child: child,
      ),
    );
  }
}
