// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolunteerModel _$VolunteerModelFromJson(Map<String, dynamic> json) =>
    VolunteerModel(
      imageUrl: json['imageUrl'] as String,
      volunteerCount: (json['volunteerCount'] as num).toInt(),
      username: json['username'] as String,
      time: json['time'] as String,
      description: json['description'] as String,
      scheduleDate: json['scheduleDate'] as String,
    );

Map<String, dynamic> _$VolunteerModelToJson(VolunteerModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'volunteerCount': instance.volunteerCount,
      'username': instance.username,
      'time': instance.time,
      'description': instance.description,
      'scheduleDate': instance.scheduleDate,
    };
