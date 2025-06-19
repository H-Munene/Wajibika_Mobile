class ReportHomefeedRelatedEventsEntity {
  ReportHomefeedRelatedEventsEntity({
    required this.event_id,
    required this.event_name,
    required this.scheduled_volunteer_date,
    required this.event_status,
    required this.participants_count,
  });

  final int event_id;
  final String event_name;
  final String scheduled_volunteer_date;
  final String event_status;
  final int participants_count;
}
