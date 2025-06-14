import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/cupertino.dart';

/*
  -----------------------------------------------------
  |                                                    |
  |             Clogged drain around Madaraka          |
  |   Icon      shopping centre                    +3  |                                |             12/03/2025                             |
  |                                                    | 
  ------------------------------------------------------


*/

class ReportVolunteerHistoryCard extends StatelessWidget {
  final String type; // 'report','volunteer',
  final String description;
  final String date;

  const ReportVolunteerHistoryCard({
    super.key,
    required this.type,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.circleBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              type == 'volunteer'
                  ? CupertinoIcons.hand_raised_fill
                  : CupertinoIcons.photo_camera,
            ),

            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Text(description),
                  Text(date, style: TextStyle(color: AppColors.greyText)),
                ],
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.add, color: AppColors.primaryColor),
                Text(
                  type == 'volunteer' ? '15' : '3',
                  style: const TextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
