import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_volunteer_specific_date_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportVolunteerSpecificDateModel extends Equatable {
  const ReportVolunteerSpecificDateModel({
    required this.report_id,
    required this.description,
    required this.report_date,
    required this.is_approved,
    required this.is_resolved_by_volunteer,
    required this.is_resolved_by_council,
  });

  final int report_id;
  final String description;
  final String report_date;
  final bool is_approved;
  final bool is_resolved_by_volunteer;
  final bool is_resolved_by_council;

  factory ReportVolunteerSpecificDateModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ReportVolunteerSpecificDateModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ReportVolunteerSpecificDateModelToJson(this);

  @override
  List<Object?> get props => [
    report_id,
    description,
    report_date,
    is_approved,
    is_resolved_by_volunteer,
    is_resolved_by_council,
  ];
}
