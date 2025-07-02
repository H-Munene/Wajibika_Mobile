import 'package:json_annotation/json_annotation.dart';

part 'report_volunteer_daily_count_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DailyCounts {
  const DailyCounts({required this.date, required this.count});

  final String date;
  final int count;

  factory DailyCounts.fromJson(Map<String, dynamic> json) =>
      _$DailyCountsFromJson(json);

  Map<String, dynamic> toJson() => _$DailyCountsToJson(this);
}
