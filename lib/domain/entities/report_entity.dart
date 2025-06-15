class ReportEntity {
  ReportEntity({
    required this.reportCategory,
    required this.imageUrl,
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
  final String imageUrl;
  final String reportCategory; // 'Clogged Drain', 'Improper Garbage Disposal',
}
