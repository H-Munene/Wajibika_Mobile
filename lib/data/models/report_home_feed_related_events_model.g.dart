// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_home_feed_related_events_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportHomefeedRelatedEventsModel _$ReportHomefeedRelatedEventsModelFromJson(
  Map<String, dynamic> json,
) => ReportHomefeedRelatedEventsModel(
  event_id: (json['event_id'] as num).toInt(),
  event_name: json['event_name'] as String,
  scheduled_volunteer_date: json['scheduled_volunteer_date'] as String,
  event_status: json['event_status'] as String,
  participants_count: (json['participants_count'] as num).toInt(),
);

Map<String, dynamic> _$ReportHomefeedRelatedEventsModelToJson(
  ReportHomefeedRelatedEventsModel instance,
) => <String, dynamic>{
  'event_id': instance.event_id,
  'event_name': instance.event_name,
  'scheduled_volunteer_date': instance.scheduled_volunteer_date,
  'event_status': instance.event_status,
  'participants_count': instance.participants_count,
};
