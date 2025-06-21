// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_volunteer_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportVolunteerHistoryModel _$ReportVolunteerHistoryModelFromJson(
  Map<String, dynamic> json,
) => ReportVolunteerHistoryModel(
  reportHistory:
      (json['reportHistory'] as List<dynamic>)
          .map((e) => ReportHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  volunteerHistory:
      (json['volunteerHistory'] as List<dynamic>)
          .map((e) => VolunteerHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ReportVolunteerHistoryModelToJson(
  ReportVolunteerHistoryModel instance,
) => <String, dynamic>{
  'reportHistory': instance.reportHistory.map((e) => e.toJson()).toList(),
  'volunteerHistory': instance.volunteerHistory.map((e) => e.toJson()).toList(),
};
