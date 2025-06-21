import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'report_home_feed_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportHomeFeedModel extends ReportHomeFeedEntity with EquatableMixin {
  ReportHomeFeedModel(
    super.resolved_image_url, {
    required super.report_id,
    required super.reporter_username,
    required super.description,
    required super.report_date,
    required super.report_image_url,
    required super.is_resolved_by_volunteer,
    required super.is_resolved_by_council,
    required super.resolved_date,
    required super.related_events,
    required super.is_volunteer,
  });

  factory ReportHomeFeedModel.fromJson(Map<String, dynamic> json) =>
      _$ReportHomeFeedModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportHomeFeedModelToJson(this);
}
