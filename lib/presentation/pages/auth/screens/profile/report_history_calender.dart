import 'package:flutter/cupertino.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class ReportHistoryCalender extends StatefulWidget {
  final Map<DateTime, int>? reportdatasets;
  final Map<DateTime, int>? volunteerdatasets;
  final void Function(DateTime)? onActiveReportDateClicked;
  final void Function(DateTime)? onActiveVolunteerDateClicked;

  final bool toggleCalendar;
  const ReportHistoryCalender({
    super.key,
    this.toggleCalendar = true,
    required this.reportdatasets,
    required this.volunteerdatasets,
    required this.onActiveReportDateClicked,
    this.onActiveVolunteerDateClicked,
  });

  @override
  State<ReportHistoryCalender> createState() => _ReportHistoryCalenderState();
}

class _ReportHistoryCalenderState extends State<ReportHistoryCalender> {
  @override
  Widget build(BuildContext context) {
    // Debug: Print datasets to see if they have data

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child:
            widget.toggleCalendar
                ?
                // report calender
                HeatMapCalendar(
                  onClick: (date) {
                    // Check if the callback is null
                    if (widget.onActiveReportDateClicked != null) {
                      widget.onActiveReportDateClicked!(date);
                    } else {}
                  },
                  datasets: widget.reportdatasets ?? {},
                  colorTipHelper: const [
                    Text('less reports'),
                    Text(' more reports'),
                  ],
                  showColorTip: false,
                  colorsets: {
                    1: AppColors.primaryColor.withAlpha(20),
                    2: AppColors.primaryColor.withAlpha(40),
                    3: AppColors.primaryColor.withAlpha(60),
                    4: AppColors.primaryColor.withAlpha(80),
                    5: AppColors.primaryColor.withAlpha(100),
                  },
                )
                :
                // volunteer calender
                HeatMapCalendar(
                  onClick: (date) {
                    if (widget.onActiveVolunteerDateClicked != null) {
                      widget.onActiveVolunteerDateClicked!(date);
                    } else {}
                  },
                  datasets: widget.volunteerdatasets ?? {},
                  colorTipHelper: const [
                    Text('less volunteer events'),
                    Text(' more volunteer events'),
                  ],
                  showColorTip: false,
                  colorsets: {
                    1: AppColors.secondaryColor.withAlpha(20),
                    2: AppColors.secondaryColor.withAlpha(40),
                    3: AppColors.secondaryColor.withAlpha(60),
                    4: AppColors.secondaryColor.withAlpha(80),
                    5: AppColors.secondaryColor.withAlpha(100),
                  },
                ),
      ),
    );
  }
}
