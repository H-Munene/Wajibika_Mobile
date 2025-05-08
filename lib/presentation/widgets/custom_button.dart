import 'package:flutter/material.dart';

import '../../core/core.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.textfieldVerticalSpacing,
      child: MaterialButton(
        elevation: 0,
        onPressed: onPressed,
        color: AppColors.buttonBackgroundColor,
        child: Text(text),
      ),
    );
  }
}
