// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolunteerHistoryModel _$VolunteerHistoryModelFromJson(
  Map<String, dynamic> json,
) => VolunteerHistoryModel(
  daily_counts:
      (json['daily_counts'] as List<dynamic>)
          .map((e) => DailyCounts.fromJson(e as Map<String, dynamic>))
          .toList(),
  total_volunteer_events_count:
      (json['total_volunteer_events_count'] as num).toInt(),
);

Map<String, dynamic> _$VolunteerHistoryModelToJson(
  VolunteerHistoryModel instance,
) => <String, dynamic>{
  'daily_counts': instance.daily_counts.map((e) => e.toJson()).toList(),
  'total_volunteer_events_count': instance.total_volunteer_events_count,
};
