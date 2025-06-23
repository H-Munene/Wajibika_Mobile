// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_volunteer_list_specific_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportVolunteerListSpecificDateModel
_$ReportVolunteerListSpecificDateModelFromJson(Map<String, dynamic> json) =>
    ReportVolunteerListSpecificDateModel(
      reportVolunteerSpecificDateModel:
          (json['reportVolunteerSpecificDateModel'] as List<dynamic>)
              .map(
                (e) => ReportVolunteerSpecificDateModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
    );

Map<String, dynamic> _$ReportVolunteerListSpecificDateModelToJson(
  ReportVolunteerListSpecificDateModel instance,
) => <String, dynamic>{
  'reportVolunteerSpecificDateModel':
      instance.reportVolunteerSpecificDateModel.map((e) => e.toJson()).toList(),
};
