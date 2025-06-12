import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class ReportHistoryCalender extends StatelessWidget {
  //final Map<DateTime, int>? datasets
  const ReportHistoryCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: HeatMapCalendar(
          // onClick: should view posts made on that day if available,
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
          colorTipHelper: const [Text('less reports'), Text(' more reports')],
          showColorTip: false,
          colorsets: {
            1: AppColors.primaryColor.withAlpha(1),
            2: AppColors.primaryColor.withAlpha(2),
            3: AppColors.primaryColor.withAlpha(3),
            4: AppColors.primaryColor.withAlpha(4),
            5: AppColors.primaryColor.withAlpha(5),
          },
        ),
      ),
    );
  }
}
