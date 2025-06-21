import 'package:bloc_clean_arch/data/data.dart';
import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ReportVolunteerHistoryEntity extends Equatable {
  const ReportVolunteerHistoryEntity({
    required this.reportHistory,
    required this.volunteerHistory,
  });

  final List<ReportHistoryModel> reportHistory;
  final List<VolunteerHistoryModel> volunteerHistory;

  @override
  List<Object?> get props => [reportHistory, volunteerHistory];
}

// {
//     "report_history": {
//         "daily_counts": [
//             {
//                 "date": "2025-06-21",
//                 "count": 3
//             },
//             {
//                 "date": "2025-06-18",
//                 "count": 2
//             }
//         ],
//         "total_reports_count": 5
//     },
//     "volunteer_history": {
//         "daily_counts": [
//             {
//                 "date": "2025-06-20",
//                 "count": 1
//             }
//         ],
//         "total_volunteer_events_count": 1
//     }
// }
