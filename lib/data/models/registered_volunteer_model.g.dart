// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_volunteer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisteredVolunteerModel _$RegisteredVolunteerModelFromJson(
  Map<String, dynamic> json,
) => RegisteredVolunteerModel(
  event_id: (json['event_id'] as num).toInt(),
  event_name: json['event_name'] as String,
  scheduled_volunteer_date: json['scheduled_volunteer_date'] as String,
  event_status: json['event_status'] as String,
  report_id: (json['report_id'] as num).toInt(),
  reporter_username: json['reporter_username'] as String,
  description: json['description'] as String,
  report_date: json['report_date'] as String,
  is_resolved_by_volunteer: json['is_resolved_by_volunteer'] as bool,
  is_resolved_by_council: json['is_resolved_by_council'] as bool,
  resolved_image_url: json['resolved_image_url'] as String?,
  resolved_date: json['resolved_date'] as String,
  volunteer_count: (json['volunteer_count'] as num).toInt(),
);

Map<String, dynamic> _$RegisteredVolunteerModelToJson(
  RegisteredVolunteerModel instance,
) => <String, dynamic>{
  'event_id': instance.event_id,
  'event_name': instance.event_name,
  'scheduled_volunteer_date': instance.scheduled_volunteer_date,
  'event_status': instance.event_status,
  'report_id': instance.report_id,
  'reporter_username': instance.reporter_username,
  'description': instance.description,
  'report_date': instance.report_date,
  'is_resolved_by_volunteer': instance.is_resolved_by_volunteer,
  'is_resolved_by_council': instance.is_resolved_by_council,
  'resolved_image_url': instance.resolved_image_url,
  'resolved_date': instance.resolved_date,
  'volunteer_count': instance.volunteer_count,
};
