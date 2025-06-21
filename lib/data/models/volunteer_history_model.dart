import 'package:bloc_clean_arch/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'volunteer_history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VolunteerHistoryModel {
  const VolunteerHistoryModel({
    required this.daily_counts,
    required this.total_reports_count,
  });

  final List<DailyCounts> daily_counts;
  final int total_reports_count;

  factory VolunteerHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$VolunteerHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$VolunteerHistoryModelToJson(this);
}
