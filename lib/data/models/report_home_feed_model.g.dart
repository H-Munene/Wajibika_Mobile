// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_home_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportHomeFeedModel _$ReportHomeFeedModelFromJson(Map<String, dynamic> json) =>
    ReportHomeFeedModel(
      json['resolved_image_url'] as String?,
      report_id: (json['report_id'] as num).toInt(),
      reporter_username: json['reporter_username'] as String,
      description: json['description'] as String,
      report_date: json['report_date'] as String,
      report_image_url: json['report_image_url'] as String,
      is_resolved_by_volunteer: json['is_resolved_by_volunteer'] as bool,
      is_resolved_by_council: json['is_resolved_by_council'] as bool,
      resolved_date: json['resolved_date'] as String,
      related_events:
          (json['related_events'] as List<dynamic>)
              .map(
                (e) => ReportHomefeedRelatedEventsModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
    );

Map<String, dynamic> _$ReportHomeFeedModelToJson(
  ReportHomeFeedModel instance,
) => <String, dynamic>{
  'report_id': instance.report_id,
  'reporter_username': instance.reporter_username,
  'description': instance.description,
  'report_date': instance.report_date,
  'report_image_url': instance.report_image_url,
  'is_resolved_by_volunteer': instance.is_resolved_by_volunteer,
  'is_resolved_by_council': instance.is_resolved_by_council,
  'resolved_image_url': instance.resolved_image_url,
  'resolved_date': instance.resolved_date,
  'related_events': instance.related_events.map((e) => e.toJson()).toList(),
};
