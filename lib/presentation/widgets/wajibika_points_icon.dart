import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/material.dart';

class WajibikaPointsIcon extends StatelessWidget {
  final String wajibikaPoints;

  const WajibikaPointsIcon({super.key, required this.wajibikaPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: wajibikaPoints.length <= 2 ? 52 : 67,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(),
        borderRadius: AppDimensions.circleBorderRadius,
      ),
      child: Row(
        children: [
          const _InnerWajibikaIcon(),
          Text(wajibikaPoints, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}

class _InnerWajibikaIcon extends StatelessWidget {
  const _InnerWajibikaIcon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
          color: AppColors.primaryColor,
        ),
        child: const Padding(
          padding: EdgeInsets.all(2),
          child: Text(
            'wp',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
