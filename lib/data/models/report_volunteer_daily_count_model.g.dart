// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_volunteer_daily_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyCounts _$DailyCountsFromJson(Map<String, dynamic> json) => DailyCounts(
  date: json['date'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$DailyCountsToJson(DailyCounts instance) =>
    <String, dynamic>{'date': instance.date, 'count': instance.count};
