import 'package:bloc_clean_arch/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportHistoryModel {
  const ReportHistoryModel({
    required this.daily_counts,
    required this.total_reports_count,
  });

  final List<DailyCounts> daily_counts;
  final int total_reports_count;

  factory ReportHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ReportHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportHistoryModelToJson(this);
}
