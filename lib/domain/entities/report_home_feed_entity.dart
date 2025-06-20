import 'package:bloc_clean_arch/data/data.dart';

class ReportHomeFeedEntity {
  ReportHomeFeedEntity(
    this.resolved_image_url, {
    required this.report_id,
    required this.reporter_username,
    required this.description,
    required this.report_date,
    required this.report_image_url,
    required this.is_resolved_by_volunteer,
    required this.is_resolved_by_council,
    required this.resolved_date,
    required this.related_events,
    required this.is_volunteer,
  });

  final int report_id;
  final String reporter_username;
  final String description;
  final String report_date;
  final String report_image_url;
  final bool is_resolved_by_volunteer;
  final bool is_resolved_by_council;
  final String? resolved_image_url;
  final String resolved_date;
  final List<ReportHomefeedRelatedEventsModel> related_events;
  final bool is_volunteer;
}
