import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/presentation/pages/auth/report_volunteer_history_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class ReportHistoryCalender extends StatefulWidget {
  //final Map<DateTime, int>? reportdatasets
  //final Map<DateTime, int>? volunteerdatasets
  final bool toggleCalendar;
  const ReportHistoryCalender({super.key, this.toggleCalendar = true});

  @override
  State<ReportHistoryCalender> createState() => _ReportHistoryCalenderState();
}

class _ReportHistoryCalenderState extends State<ReportHistoryCalender> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                  datasets: {
                    DateTime(DateTime.now().year, DateTime.now().month, 1): 1,
                    DateTime(DateTime.now().year, DateTime.now().month, 3): 2,
                    DateTime(DateTime.now().year, DateTime.now().month, 4): 3,
                    DateTime(DateTime.now().year, DateTime.now().month, 6): 4,
                    DateTime(DateTime.now().year, DateTime.now().month, 6): 5,
                    DateTime(DateTime.now().year, DateTime.now().month, 15): 5,
                    DateTime(DateTime.now().year, DateTime.now().month, 23): 5,
                    DateTime(DateTime.now().year, DateTime.now().month, 25): 1,
                    DateTime(DateTime.now().year, DateTime.now().month, 26): 2,
                    DateTime(DateTime.now().year, DateTime.now().month, 27): 3,
                    DateTime(DateTime.now().year, DateTime.now().month, 28): 4,
                    DateTime(DateTime.now().year, DateTime.now().month, 29): 5,
                    DateTime(DateTime.now().year, DateTime.now().month, 30): 5,
                  },
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
                  datasets: {
                    DateTime(DateTime.now().year, DateTime.now().month, 1): 1,
                    DateTime(DateTime.now().year, DateTime.now().month, 7): 2,
                    DateTime(DateTime.now().year, DateTime.now().month, 14): 3,
                    DateTime(DateTime.now().year, DateTime.now().month, 21): 4,
                    DateTime(DateTime.now().year, DateTime.now().month, 28): 5,
                  },
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
