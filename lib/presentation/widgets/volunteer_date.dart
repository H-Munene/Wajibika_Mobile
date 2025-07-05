import 'package:flutter/cupertino.dart';

// displays the volunteer date
class ScheduleDate extends StatelessWidget {
  const ScheduleDate({super.key, required this.scheduleDate});

  final String scheduleDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Row(
        spacing: 2,
        children: [
          const Icon(CupertinoIcons.calendar_today),
          Text(scheduleDate, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
