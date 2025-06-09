import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/material.dart';

class WajibikaPointsProgress extends StatefulWidget {
  final int wajibikaPoints;

  const WajibikaPointsProgress({super.key, required this.wajibikaPoints});

  @override
  State<WajibikaPointsProgress> createState() => _WajibikaPointsProgressState();
}

class _WajibikaPointsProgressState extends State<WajibikaPointsProgress>
    with TickerProviderStateMixin {
  late AnimationController
  _wajibikaPointsLinearProgressIndicatorAnimationController;
  late Animation<double> _wajibikaPointsLinearProgressIndicatorAnimation;
  late Animation<Color?> _wajibikaPointsLinearProgressIndicatorColorAnimation;

  @override
  void initState() {
    super.initState();
    _wajibikaPointsLinearProgressIndicatorAnimationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1500),
        )..forward();

    _wajibikaPointsLinearProgressIndicatorAnimation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(_wajibikaPointsLinearProgressIndicatorAnimationController)
      ..addListener(() => setState(() {}));

    _wajibikaPointsLinearProgressIndicatorColorAnimation = ColorTween(
      begin: AppColors.initialLinearProgressIndicatorColor,
      end:
          widget.wajibikaPoints < 40
              ? AppColors.middleLinearProgressIndicatorColor
              : AppColors.primaryColor,
    ).animate(_wajibikaPointsLinearProgressIndicatorAnimationController);
  }

  @override
  void dispose() {
    _wajibikaPointsLinearProgressIndicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Wajibika Points'),
            const Spacer(),
            Text(
              '${(_wajibikaPointsLinearProgressIndicatorAnimation.value * widget.wajibikaPoints).floor()} wp',
            ),
          ],
        ),
        LinearProgressIndicator(
          valueColor: _wajibikaPointsLinearProgressIndicatorColorAnimation,
          borderRadius: AppDimensions.circleBorderRadius,
          value:
              _wajibikaPointsLinearProgressIndicatorAnimation.value *
              widget.wajibikaPoints /
              100,
          minHeight: 10,
          color: AppColors.primaryColor,
          trackGap: 2,
        ),
      ],
    );
  }
}
