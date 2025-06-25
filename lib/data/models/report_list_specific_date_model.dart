import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_list_specific_date_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportListSpecificDateModel extends Equatable {
  const ReportListSpecificDateModel({required this.reports});

  final List<ReportSpecificDateModel> reports;

  factory ReportListSpecificDateModel.fromJson(Map<String, dynamic> json) =>
      _$ReportListSpecificDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportListSpecificDateModelToJson(this);

  @override
  List<Object?> get props => [reports];
}

// reports specific date
//   {
//     "date": "2025-06-21",
//     "reports": [
//         {
//             "report_id": 7,
//             "description": "Moon above the Aberdare mountains",
//             "report_date": "2025-06-21T14:58:12.000Z",
//             "is_approved": true,
//             "is_resolved_by_volunteer": false,
//             "is_resolved_by_council": false
//         },
//
//     ]
// }

// volunteer specific date
//   {
//     "date": "2025-06-20",
//     "events": [
//         {
//             "event_id": 2,
//             "event_name": "Cleanup for Report 1",
//             "scheduled_volunteer_date": "2025-06-20T12:00:00.000Z",
//             "report_description": "Clogged Drain close to the back entrance of Siwaka plaza",
//             "event_status": "Completed"
//         }
//     ]
// }
