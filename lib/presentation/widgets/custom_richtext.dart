import 'package:flutter/material.dart';
import '../../core/core.dart';

class CustomRichText extends StatelessWidget {
  /// Contains different default formatting
  final String regularText;

  /// Contains different formatting compared to the `regularText`
  final String highlightedText;

  final Color? highlightColor;
  final VoidCallback? redirect;

  const CustomRichText({
    super.key,
    required this.regularText,
    required this.highlightedText,
    this.highlightColor = AppColors.richTextHighlight,
    this.redirect,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold);

    final otherStyle = Theme.of(context).textTheme.bodyMedium;

    final baseRichText = RichText(
      text: TextSpan(
        text: regularText,
        style: highlightColor == null ? baseStyle : otherStyle,
        children: [
          TextSpan(
            text: highlightedText,
            style: TextStyle(
              color: highlightColor,
              fontWeight: highlightColor != null ? FontWeight.bold : null,
            ),
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
