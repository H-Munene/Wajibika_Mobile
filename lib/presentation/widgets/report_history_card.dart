import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter/cupertino.dart';

/*
  -----------------------------------------------------
  |                                                    |
  |             Clogged drain around Madaraka          |
  |   Icon      shopping centre                    +3  |                                             12/03/2025                             |
  |             Tue, 14 June 2025                      | 
  ------------------------------------------------------


*/

// create model to deserialize this
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
        side: const BorderSide(width: 0.1),
        borderRadius: AppDimensions.circleBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 10,
          children: [
            Icon(
              type == 'volunteer'
                  ? CupertinoIcons.hand_raised_fill
                  : CupertinoIcons.photo_camera,
            ),

            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(description),
                  Text(date, style: TextStyle(color: AppColors.greyText)),
                ],
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.add,
                  size: 10,
                  color: AppColors.primaryColor,
                ),
                Text(
                  type == 'volunteer' ? '15wp' : '3wp',
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
