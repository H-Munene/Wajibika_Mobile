import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';

class ReportHomeFeedEntity extends Equatable {
  const ReportHomeFeedEntity(
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
  final String? resolved_date;
  final List<ReportHomefeedRelatedEventsModel> related_events;
  final bool is_volunteer;

  @override
  List<Object?> get props => [
    resolved_image_url,
    report_id,
    reporter_username,
    description,
    report_date,
    report_image_url,
    is_resolved_by_volunteer,
    is_resolved_by_council,
    resolved_date,
    related_events,
    is_volunteer,
  ];
}
