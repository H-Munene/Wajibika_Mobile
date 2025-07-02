// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_specific_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportSpecificDateModel _$ReportSpecificDateModelFromJson(
  Map<String, dynamic> json,
) => ReportSpecificDateModel(
  report_id: (json['report_id'] as num).toInt(),
  description: json['description'] as String,
  report_date: json['report_date'] as String,
  is_approved: json['is_approved'] as bool,
  is_resolved_by_volunteer: json['is_resolved_by_volunteer'] as bool,
  is_resolved_by_council: json['is_resolved_by_council'] as bool,
);

Map<String, dynamic> _$ReportSpecificDateModelToJson(
  ReportSpecificDateModel instance,
) => <String, dynamic>{
  'report_id': instance.report_id,
  'description': instance.description,
  'report_date': instance.report_date,
  'is_approved': instance.is_approved,
  'is_resolved_by_volunteer': instance.is_resolved_by_volunteer,
  'is_resolved_by_council': instance.is_resolved_by_council,
};
