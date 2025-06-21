import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_volunteer_history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportVolunteerHistoryModel extends ReportVolunteerHistoryEntity {
  const ReportVolunteerHistoryModel({
    required super.reportHistory,
    required super.volunteerHistory,
  });

  factory ReportVolunteerHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ReportVolunteerHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportVolunteerHistoryModelToJson(this);
}
