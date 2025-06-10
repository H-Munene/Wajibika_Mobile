import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/material.dart';

class WeeklyHighlightCard extends StatelessWidget {
  final String image;
  final String date;
  final String highlightDescription;

  const WeeklyHighlightCard({
    super.key,
    required this.image,
    required this.date,
    required this.highlightDescription,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: AppColors.noImageBackgroundColor,
        borderRadius: AppDimensions.circleBorderRadius,
        image: DecorationImage(
          image: Image.asset(image, fit: BoxFit.cover).image,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 25,
            left: 5,
            //to show overflow
            child: SizedBox(
              width: 330,
              child: Text(
                highlightDescription,
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            left: 5,
            child: Text(
              date,
              style: textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
