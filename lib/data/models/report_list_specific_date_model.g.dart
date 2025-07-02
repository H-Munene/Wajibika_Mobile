// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_list_specific_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportListSpecificDateModel _$ReportListSpecificDateModelFromJson(
  Map<String, dynamic> json,
) => ReportListSpecificDateModel(
  reports:
      (json['reports'] as List<dynamic>)
          .map(
            (e) => ReportSpecificDateModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$ReportListSpecificDateModelToJson(
  ReportListSpecificDateModel instance,
) => <String, dynamic>{
  'reports': instance.reports.map((e) => e.toJson()).toList(),
};
