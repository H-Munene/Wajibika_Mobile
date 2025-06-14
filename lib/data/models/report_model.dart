import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportModel extends ReportEntity with EquatableMixin {
  ReportModel({
    required super.volunteerCount,
    required super.username,
    required super.time,
    required super.description,
    required super.scheduleDate,
  });

  factory ReportModel.froJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);

  @override
  List<Object?> get props => [
    volunteerCount,
    username,
    time,
    description,
    scheduleDate,
  ];
}
