// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer_list_specific_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolunteerListSpecificDateModel _$VolunteerListSpecificDateModelFromJson(
  Map<String, dynamic> json,
) => VolunteerListSpecificDateModel(
  events:
      (json['events'] as List<dynamic>)
          .map(
            (e) =>
                VolunteerSpecificDateModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$VolunteerListSpecificDateModelToJson(
  VolunteerListSpecificDateModel instance,
) => <String, dynamic>{
  'events': instance.events.map((e) => e.toJson()).toList(),
};
