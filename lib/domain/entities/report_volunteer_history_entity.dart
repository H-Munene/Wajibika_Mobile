import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ReportVolunteerHistoryEntity extends Equatable {
  const ReportVolunteerHistoryEntity({
    required this.report_history,
    required this.volunteer_history,
  });

  final ReportHistoryModel report_history;
  final VolunteerHistoryModel volunteer_history;

  @override
  List<Object?> get props => [report_history, volunteer_history];
}
