import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_home_feed_related_events_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportHomefeedRelatedEventsModel
    extends ReportHomefeedRelatedEventsEntity {
  ReportHomefeedRelatedEventsModel({
    required super.event_id,
    required super.event_name,
    required super.scheduled_volunteer_date,
    required super.event_status,
    required super.participants_count,
  });

  factory ReportHomefeedRelatedEventsModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ReportHomefeedRelatedEventsModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ReportHomefeedRelatedEventsModelToJson(this);
}
