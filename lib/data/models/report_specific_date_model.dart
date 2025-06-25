import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_specific_date_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportSpecificDateModel extends Equatable {
  const ReportSpecificDateModel({
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

  factory ReportSpecificDateModel.fromJson(Map<String, dynamic> json) =>
      _$ReportSpecificDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportSpecificDateModelToJson(this);

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

//             "report_id": 7,
//             "description": "Moon above the Aberdare mountains",
//             "report_date": "2025-06-21T14:58:12.000Z",
//             "is_approved": true,
//             "is_resolved_by_volunteer": false,
//             "is_resolved_by_council": false
