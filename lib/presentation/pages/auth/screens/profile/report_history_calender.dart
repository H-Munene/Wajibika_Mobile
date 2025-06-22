import 'package:bloc_clean_arch/presentation/pages/auth/report_volunteer_history_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class ReportHistoryCalender extends StatefulWidget {
  final Map<DateTime, int>? reportdatasets;
  final Map<DateTime, int>? volunteerdatasets;

  final bool toggleCalendar;
  const ReportHistoryCalender({
    super.key,
    this.toggleCalendar = true,
    required this.reportdatasets,
    required this.volunteerdatasets,
  });

  @override
  State<ReportHistoryCalender> createState() => _ReportHistoryCalenderState();
}

class _ReportHistoryCalenderState extends State<ReportHistoryCalender> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child:
            widget.toggleCalendar
                ?
                // report calender
                HeatMapCalendar(
                  onClick:
                      (date) => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder:
                              (context) => const ReportVolunteerHistoryPage(
                                type: 'report',
                              ),
                        ),
                      ),
                  // onMonthChange: ,
                  datasets: widget.reportdatasets,
                  colorTipHelper: const [
                    Text('less reports'),
                    Text(' more reports'),
                  ],
                  showColorTip: false,
                  colorsets: {
                    1: AppColors.primaryColor.withAlpha(1),
                    2: AppColors.primaryColor.withAlpha(2),
                    3: AppColors.primaryColor.withAlpha(3),
                    4: AppColors.primaryColor.withAlpha(4),
                    5: AppColors.primaryColor.withAlpha(5),
                  },
                )
                :
                // volunteer calender
                HeatMapCalendar(
                  onClick:
                      (date) => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder:
                              (context) => const ReportVolunteerHistoryPage(
                                type: 'volunteer',
                              ),
                        ),
                      ),
                  // onMonthChange: ,
                  datasets: widget.volunteerdatasets,
                  colorTipHelper: const [
                    Text('less reports'),
                    Text(' more reports'),
                  ],
                  showColorTip: false,
                  colorsets: {
                    1: AppColors.secondaryColor.withAlpha(1),
                    2: AppColors.secondaryColor.withAlpha(2),
                    3: AppColors.secondaryColor.withAlpha(3),
                    4: AppColors.secondaryColor.withAlpha(4),
                    5: AppColors.secondaryColor.withAlpha(5),
                  },
                ),
      ),
    );
  }
}
