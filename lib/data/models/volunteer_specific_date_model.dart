import 'package:json_annotation/json_annotation.dart';

part 'volunteer_specific_date_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VolunteerSpecificDateModel {
  const VolunteerSpecificDateModel({
    required this.event_id,
    required this.event_name,
    required this.scheduled_volunteer_date,
    required this.report_description,
    required this.event_status,
  });

  final int event_id;
  final String event_name;
  final String scheduled_volunteer_date;
  final String report_description;
  final String event_status;

  factory VolunteerSpecificDateModel.fromJson(Map<String, dynamic> json) =>
      _$VolunteerSpecificDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$VolunteerSpecificDateModelToJson(this);
}

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
