import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ProfileSummaryCategory { wajibikaPoints, report, volunteer }

class ProfileSummary extends StatelessWidget {
  final int summaryCount;
  final ProfileSummaryCategory profileSummaryCategory;

  const ProfileSummary({
    super.key,
    required this.summaryCount,
    required this.profileSummaryCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 3,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$summaryCount',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (profileSummaryCategory == ProfileSummaryCategory.wajibikaPoints)
              WajibikaPointsIcon(wajibikaPoints: summaryCount)
            else
              Icon(
                profileSummaryCategory == ProfileSummaryCategory.volunteer
                    ? CupertinoIcons.hand_raised
                    : CupertinoIcons.photo_camera,
              ),
          ],
        ),
        SizedBox(
          width: 100,
          child:
              profileSummaryCategory == ProfileSummaryCategory.wajibikaPoints
                  ? const Text('Wajibika Points', textAlign: TextAlign.center)
                  : Text(
                    profileSummaryCategory == ProfileSummaryCategory.volunteer
                        ? 'Volunteer Count'
                        : 'Report Count',
                    textAlign: TextAlign.center,
                  ),
        ),
      ],
    );
  }
}
