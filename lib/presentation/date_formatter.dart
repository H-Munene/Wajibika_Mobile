import 'package:intl/intl.dart';

String weekdayMonthDayFomat({required String date}) {
  final dateTime = DateTime.parse(date);

  final dateFormat = DateFormat('E, MMM d');

  final result = dateFormat.format(dateTime);

  return result;
}
