// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_volunteer_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportVolunteerHistoryModel _$ReportVolunteerHistoryModelFromJson(
  Map<String, dynamic> json,
) => ReportVolunteerHistoryModel(
  report_history: ReportHistoryModel.fromJson(
    json['report_history'] as Map<String, dynamic>,
  ),
  volunteer_history: VolunteerHistoryModel.fromJson(
    json['volunteer_history'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ReportVolunteerHistoryModelToJson(
  ReportVolunteerHistoryModel instance,
) => <String, dynamic>{
  'report_history': instance.report_history.toJson(),
  'volunteer_history': instance.volunteer_history.toJson(),
};
