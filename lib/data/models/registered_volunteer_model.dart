import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registered_volunteer_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisteredVolunteerModel extends Equatable {
  const RegisteredVolunteerModel({
    required this.event_id,
    required this.event_name,
    required this.scheduled_volunteer_date,
    required this.event_status,
    required this.report_id,
    required this.reporter_username,
    required this.description,
    required this.report_date,
    required this.is_resolved_by_volunteer,
    required this.is_resolved_by_council,
    required this.resolved_image_url,
    required this.resolved_date,
    required this.volunteer_count,
  });

  final int event_id;
  final String event_name;
  final String scheduled_volunteer_date;
  final String event_status;
  final int report_id;
  final String reporter_username;
  final String description;
  final String report_date;
  final bool is_resolved_by_volunteer;
  final bool is_resolved_by_council;
  final String? resolved_image_url;
  final String resolved_date;
  final int volunteer_count;

  factory RegisteredVolunteerModel.fromJson(Map<String, dynamic> json) =>
      _$RegisteredVolunteerModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisteredVolunteerModelToJson(this);

  @override
  List<Object?> get props => [
    event_id,
    event_name,
    scheduled_volunteer_date,
    event_status,
    report_id,
    reporter_username,
    description,
    report_date,
    is_resolved_by_volunteer,
    is_resolved_by_council,
    resolved_image_url,
    resolved_date,
  ];
}
