// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer_specific_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolunteerSpecificDateModel _$VolunteerSpecificDateModelFromJson(
  Map<String, dynamic> json,
) => VolunteerSpecificDateModel(
  event_id: (json['event_id'] as num).toInt(),
  event_name: json['event_name'] as String,
  scheduled_volunteer_date: json['scheduled_volunteer_date'] as String,
  report_description: json['report_description'] as String,
  event_status: json['event_status'] as String,
);

Map<String, dynamic> _$VolunteerSpecificDateModelToJson(
  VolunteerSpecificDateModel instance,
) => <String, dynamic>{
  'event_id': instance.event_id,
  'event_name': instance.event_name,
  'scheduled_volunteer_date': instance.scheduled_volunteer_date,
  'report_description': instance.report_description,
  'event_status': instance.event_status,
};
