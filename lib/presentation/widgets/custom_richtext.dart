import 'package:flutter/material.dart';
import '../../core/core.dart';

class CustomRichText extends StatelessWidget {
  /// Contains different default formatting
  final String regularText;

  /// Contains different formatting compared to the `regularText`
  final String highlightedText;

  final VoidCallback? redirect;

  const CustomRichText({
    super.key,
    required this.regularText,
    required this.highlightedText,
    this.redirect,
  });

  @override
  Widget build(BuildContext context) {
    final baseRichText = RichText(
      text: TextSpan(
        text: regularText,
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: highlightedText,
            style: TextStyle(color: AppColors.richTextHighlight),
          ),
        ],
      ),
    );

    return Padding(
      padding: AppDimensions.textfieldVerticalSpacing,
      child:
          redirect != null
              ? GestureDetector(onTap: redirect, child: baseRichText)
              : baseRichText,
    );
  }
}
