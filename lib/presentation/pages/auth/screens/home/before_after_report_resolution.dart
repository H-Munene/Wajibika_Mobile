import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/presentation/date_formatter.dart';
import 'package:bloc_clean_arch/presentation/widgets/custom_richtext.dart';
import 'package:flutter/material.dart';

class BeforeAfterReportResolution extends StatefulWidget {
  final String beforeImage;
  final String afterImage;

  final String reported_by;
  final String report_date;
  final String resolve_date;
  final bool is_resolved_by_volunteers;

  const BeforeAfterReportResolution({
    super.key,
    required this.beforeImage,
    required this.afterImage,
    required this.reported_by,
    required this.report_date,
    required this.resolve_date,
    required this.is_resolved_by_volunteers,
  });

  @override
  State<BeforeAfterReportResolution> createState() =>
      _BeforeAfterReportResolutionState();
}

class _BeforeAfterReportResolutionState
    extends State<BeforeAfterReportResolution> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Highlight')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // toggle image show and floating action button text
          setState(() {
            isToggled = !isToggled;
          });
        },
        label: Text(isToggled ? 'After' : 'Before'),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                fit: BoxFit.cover,
                isToggled ? widget.afterImage : widget.beforeImage,
                height: AppDimensions.reportHomeFeedImageHeightWidth,
                cacheHeight:
                    AppDimensions.reportHomeFeedImageHeightWidth.toInt(),
                width: AppDimensions.reportHomeFeedImageHeightWidth,
                cacheWidth:
                    AppDimensions.reportHomeFeedImageHeightWidth.toInt(),
              ),
            ),
            const Divider(),

            CustomRichText(
              regularText: 'Reported By: ',
              highlightedText: widget.reported_by,
            ),
            CustomRichText(
              regularText: 'Report Date: ',
              highlightedText: weekdayMonthDayFomat(date: widget.report_date),
            ),

            CustomRichText(
              regularText: 'Resolve Date: ',
              highlightedText: weekdayMonthDayFomat(date: widget.resolve_date),
            ),

            CustomRichText(
              regularText: 'Resolved By: ',
              highlightedText:
                  widget.is_resolved_by_volunteers
                      ? 'Volunteers'
                      : 'The Nairobi Local Council',
            ),
          ],
        ),
      ),
    );
  }
}
