class ReportEntity {
  ReportEntity({
    required this.volunteerCount,
    required this.username,
    required this.time,
    required this.description,
    required this.scheduleDate,
  });

  final int volunteerCount;
  final String username;
  final String time;
  final String description;
  final String scheduleDate;
}
