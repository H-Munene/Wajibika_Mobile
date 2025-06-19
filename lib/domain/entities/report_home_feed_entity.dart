import 'package:bloc_clean_arch/domain/entities/report_homefeed_related_events_entity.dart';

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
  final List<ReportHomefeedRelatedEventsEntity> related_events;
}

// {
//                 "report_id": 1,
//                 "reporter_username": "munene",
//                 "description": "Clogged Drain close to the back entrance of Siwaka plaza",
//                 "report_date": "2025-06-18T02:33:37.000Z",
//                 "report_image_url": "https://anslrtwflyiretsciqln.supabase.co/storage/v1/object/public/wajibika-images/report_images/87640ec8-28b0-44df-bb61-387ce331a037.jpeg",
//                 "is_resolved_by_volunteer": true,
//                 "is_resolved_by_council": true,
//                 "resolved_image_url": null,
//                 "resolved_date": "2025-06-18T04:20:31.000Z",
//                 "related_events": [
//                     {
//                         "event_id": 2,
//                         "event_name": "Cleanup for Report 1",
//                         "scheduled_volunteer_date": "2025-06-20T12:00:00.000Z",
//                         "event_status": "Completed",
//                         "participants_count": 1
//                     }
//                 ]
// }
