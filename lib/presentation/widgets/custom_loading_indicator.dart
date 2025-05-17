import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? size;

  const CustomLoadingIndicator({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.progressiveDots(
      color: color ?? Colors.white,
      size: size ?? AppDimensions.loadingIndicatorSize,
    );
  }
}
