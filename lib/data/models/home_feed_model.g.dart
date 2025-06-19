// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeFeedModel _$HomeFeedModelFromJson(
  Map<String, dynamic> json,
) => HomeFeedModel(
  clogged_drain:
      (json['clogged_drain'] as List<dynamic>)
          .map((e) => ReportHomeFeedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  negligent_dumping:
      (json['negligent_dumping'] as List<dynamic>)
          .map((e) => ReportHomeFeedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$HomeFeedModelToJson(HomeFeedModel instance) =>
    <String, dynamic>{
      'clogged_drain': instance.clogged_drain.map((e) => e.toJson()).toList(),
      'negligent_dumping':
          instance.negligent_dumping.map((e) => e.toJson()).toList(),
    };
