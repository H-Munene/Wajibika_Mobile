import 'dart:math';

import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/presentation/date_formatter.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/screens/home/before_after_report_resolution.dart';
import 'package:bloc_clean_arch/presentation/presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeekHighlights extends StatelessWidget {
  final List<ReportHomeFeedModel> resolvedCloggedDrains;
  final List<ReportHomeFeedModel> resolvedNegligentDumping;

  const WeekHighlights({
    super.key,
    required this.resolvedCloggedDrains,
    required this.resolvedNegligentDumping,
  });

  @override
  Widget build(BuildContext context) {
    final List<ReportHomeFeedModel> resolvedReports =
        [...resolvedCloggedDrains, ...resolvedNegligentDumping]
            .where(
              (report) =>
                  report.resolved_date != null &&
                  report.resolved_image_url != null,
            )
            .toList();

    List<String> highlightTitle = [
      'Fresh Start Friday',
      'Eco Action Alliance',
      'Neighborhood Nurturers',
      'Restore & Reclaim Squad',
      'Clean Dream Team',
      'Groundswell Guardians',
      'Urban Shine Syndicate',
      'Bright Block Builders',
      'Trash Talk Takedown',
      'Green Pulse Pioneers',
      'Kindness Kleanup Crew',
      'Clear Streets Collective',
      'Mission: Renew',
      'Better Together Brigade',
      'Tidy Town Trailblazers',
      'Zero Waste Warriors',
      'Planet Protectors Hub',
      'Harmony Helpers',
      'Grime Fighters Guild',
      'Sweep Squad Central',
    ];

    // final titlesToTake = resolvedReports.length;
    // final highlightTitlesToTake = highlightTitle.take(titlesToTake).toList();

    return SizedBox(
      height: 227,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder:
            (context, index) => GestureDetector(
              onTap:
                  () => Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder:
                          (context) => BeforeAfterReportResolution(
                            beforeImage:
                                resolvedReports[index].report_image_url,
                            afterImage:
                                resolvedReports[index].resolved_image_url!,
                            reported_by:
                                resolvedReports[index].reporter_username,
                            report_date: resolvedReports[index].report_date,
                            resolve_date: resolvedReports[index].resolved_date!,
                            is_resolved_by_volunteers:
                                resolvedReports[index].is_resolved_by_volunteer,
                          ),
                    ),
                  ),
              child: WeeklyHighlightCard(
                image: resolvedReports[index].resolved_image_url!,
                date: weekdayMonthDayFomat(
                  date: resolvedReports[index].resolved_date!,
                ),
                highlightDescription: highlightTitle[index],
              ),
            ),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: resolvedReports.length,
      ),
    );
  }
}
