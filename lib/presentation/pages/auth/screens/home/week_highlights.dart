import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/material.dart';

class WeekHighlights extends StatelessWidget {
  const WeekHighlights({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> hightlightTitle = [
      'Clean Slate Saturday',
      'Green Machine Cleanup Crew',
      'Community Care Collective',
    ];

    List<String> images = [
      AppImages.cleanup,
      AppImages.cleanup2,
      AppImages.team,
    ];

    return SizedBox(
      height: 227,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder:
            (context, index) => WeeklyHighlightCard(
              image: images[index],
              date: '12/10/2025',
              highlightDescription: hightlightTitle[index],
            ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: images.length,
      ),
    );
  }
}
