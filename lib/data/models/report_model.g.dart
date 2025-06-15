// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
  reportCategory: json['reportCategory'] as String,
  imageUrl: json['imageUrl'] as String,
  volunteerCount: (json['volunteerCount'] as num).toInt(),
  username: json['username'] as String,
  time: json['time'] as String,
  description: json['description'] as String,
  scheduleDate: json['scheduleDate'] as String,
);

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'volunteerCount': instance.volunteerCount,
      'username': instance.username,
      'time': instance.time,
      'description': instance.description,
      'scheduleDate': instance.scheduleDate,
      'imageUrl': instance.imageUrl,
      'reportCategory': instance.reportCategory,
    };
