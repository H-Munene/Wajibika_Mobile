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
  final bool isApproved;

  const ReportVolunteerHistoryCard({
    super.key,
    required this.type,
    required this.description,
    required this.date,
    required this.isApproved,
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              type == 'volunteer'
                  ? CupertinoIcons.hand_raised_fill
                  : CupertinoIcons.photo_camera,

              size: 25,
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(description),
                    Text(date, style: TextStyle(color: AppColors.greyText)),
                  ],
                ),
              ),
            ),

            if (isApproved)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.add,
                    size: 15,
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
